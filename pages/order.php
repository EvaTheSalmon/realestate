<?php

include_once './functions.php';
session_start();
if (empty($_SESSION['persinf']) == 0) {
    if ((filter_input(INPUT_COOKIE, 'log')) !== '') {
        $cook = filter_input(INPUT_COOKIE, 'log');
        if (islogin($cook) == true) {
            $mass = unserialize(filter_input(INPUT_COOKIE, 'log'));
            $fb = $mass['pa'];
            $_SESSION['persinf'] = get_name($fb);
        }
    }
    $order = $_SESSION['bin'];
    if (empty($order) == 0) {
        $i = 0;
        $persinf = $_SESSION['persinf'];

        foreach ($order as $value) {
            $filename = loadimages($value);
            $comil[$i] = selectobject($value);
            //Здесь формируется таблица с краткой информацией о выбранных объектах, начиная с <tr>
            $mass[] = "<tr><td><img src=\"" . $filename . "\" class=\"image\" alt=\"" . $comil[$i]['title'] . "\"/></td></tr><tr><td>" . $comil[$i]['title'] .
                    "</td></tr><tr><td>" . $comil[$i]['description'] . "</td></tr><tr><td>Купить<input type='checkbox' "
                    . "value=\"$value\" name=\"$value\" checked/></td></tr>";
            $i++;
        }
//Обнуление/объявление общей цены и письма
        $total_cost = 0;
        $mailbody = '';
//Перебираем все чекбоксы с именами оъектов в базе
        if (isset($_REQUEST['cor'])) {
            for ($i = 1; $i <= getobjectcount(); $i++) {
                if (isset($_REQUEST["$i"])) {
                    //Если выбран чекбокс с номером объекта - покупаем
                    $name = $_REQUEST["$i"];
                    if ($name = 1) {
                        //Грузим инофрмацию об объекте
                        $inf = loadgoodsinf($i);
                        $title = $inf['title'];
                        $cost = $inf['cost'];
                        $total_cost +=$cost;
                        //$date = $inf['offer-date'];
                        //$description = $inf['description'];                
                        $address = getaddress($inf['number']);
                        $text[] = "Дом: " . $title . " по адресу " . $address . " теперь Ваш." . " С вас " . $cost . " рублей.";
                        $agentinf = getbuynescinf($inf['number']);
                        $text[] = 'Вас будет обслуживать ' . $agentinf['name'] . " " . $agentinf['surname'];
                        if (0 !== $agentinf['phonenumb']) {
                            $text[] = 'С ним можно связться по телефону ' . $agentinf['phonenumb'];
                        }
                        $text[] = 'Дополнительная информация по адресу: ' . loadaddressfil($agentinf['FilNumb']) . ' в рабочие часы: ' . $agentinf['Grapho'];
                        setitemsbuy($persinf['id'], $i);
                    }
                }
            }
            $text[] = 'Общая сумма ' . $total_cost;
            //print_r($text);
            $mailbody = implode('<br>', $text);
            //echo $mailbody;

            send_mime_mail('Магазин mroleg.xyz', 'mail@mroleg.xyz', $persinf['name'], $persinf['email'], 'utf-8', // кодировка, в которой находятся передаваемые строки
                    'windows-1251', // кодировка, в которой будет отправлено письмо
                    'Информация по заказу', $mailbody);
            //echo '<script language="javascript">alert("Заказ оформлен. Проверьте почту. Сейчас вы будете перенаправлены");</script>';       
            //sleep(5);
            $bin = array();
            $_SESSION['bin'] = $bin;
            header('Location: goods.php');
        }
    }
    if (empty($mass)) {
        $b = 'Корзина пуста';
    }
} else {
    header('Location: login.php');
}


include '../templates/order.tpl';
?>