<?php

include_once './functions.php';
session_start();
if (null !== (filter_input(INPUT_COOKIE, 'log'))) {
    $cook = filter_input(INPUT_COOKIE, 'log');
    if (islogin($cook) == true) {
        $mass = unserialize(filter_input(INPUT_COOKIE, 'log'));
        $fb = $mass['pa'];
        $_SESSION['persinf'] = get_name($fb);
        $bin = array();
        $_SESSION['bin'] = $bin;
        $isloggin = 1;
    }
}

$con = config();

(int) $number = filter_input(INPUT_GET, 'numb');
//В случае зачистки строки - элемент по умолчанию
//Наименьший непроданый (по id)
if (!isset($number)) {
    $number = selectitnotsold();
//header('Location: ' . basename(__FILE__) . '?numb='.$number);
}
//Экранируем данные от пользователя
//Проданый элемент
if (issold($number) == 0) {
//Отрицательные значения
    if ($number < 1) {
        $number = 1;
        $path = basename(__FILE__) . '?numb=' . $number;
        header('Location: ' . $path);
    }
//Превышающие общее кол-во
    if ($number > getobjectcount()) {
        $number = getobjectcount();
        $path = basename(__FILE__) . '?numb=' . ($number - 1);
        header('Location: ' . $path);
    }
//Помещаем текущий номер объекта в сессию для обработки
//при покупке
    $_SESSION['item_number'] = $number;

    $inf = loadgoodsinf(mysqli_real_escape_string($con, $number));
//Подготовка данных для показа пользователю
    $title = $inf['title'];
    $cost = $inf['cost'];
    $date = $inf['offer-date'];
    $description = $inf['description'];
//Берём данные из функций для нетипичной информации
    $address = getaddress($inf['number']);
    $filename = loadimages($inf['number']);

    $sql = "SELECT p.`name` as 'name', r.`text` as 'text', r.date FROM reviews r JOIN people p ON p.id = r.author WHERE r.object = " . $inf['number'];
    echo $sql;
    $con = config();
    $query = mysqli_query($con, $sql);
    
    $mass = loadreview($inf['number']);
    
    while ($mass = mysqli_fetch_assoc($query)) {
        $reviews[] = $mass['name'].' говорит: '. $mass['text'].' ('.$mass['date'].')';
    }
    
    if ($reviews == null) {
        $loggin = "Отзывов нет";
    }


    if (isset($_REQUEST['buy'])) {
        $rez = buy();
        switch ($rez) {
            case 'alr': echo '<script language="javascript">alert("Уже добавлено");</script>';
                break;
            default :echo '<script language="javascript">alert("Добавлено в корзину");</script>';
        }
    }

    if ($isloggin == 1) {
        $persinf = $_SESSION['persinf'];
        $loggin = "<input type='text' name='review'/><input type='submit' name='write' value='Отправить'/>";
        if (isset($_REQUEST['write'])) {
            $review_r = mysqli_real_escape_string($con, filter_input(INPUT_POST, 'review'));
            sendreview($review_r, $persinf['id'], $inf['number']);
        }
    } else {
        $loggin = 'Необходимо войти или зарегистрироваться чтобы оставлять отзывы';
    }

    include '../templates/item.tpl';
} else {
    echo 'Данный объект уже продан';
}
?>