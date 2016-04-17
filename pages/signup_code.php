<?php

if (isset($_REQUEST['sign'])) {

    include_once './config.php';
    include_once './functions.php';

    $name = filter_input(INPUT_POST, 'name');

    $surname = filter_input(INPUT_POST, 'surname');

    $middlename = filter_input(INPUT_POST, 'middle-name');

    $email = filter_input(INPUT_POST, 'email');
    if (!is_email($email)) {
        //Проверяем почту               
        echo 'Формат почты не совпадет с существующими форматами<br>';
        $e = 1;
    }

    $passport = filter_input(INPUT_POST, 'passport');

    $phonenumb = filter_input(INPUT_POST, 'phonenumb');
    //Проверка номера телефона
    if ($phonenumb != "" and ! ( strlen($phonenumb) == 11 and substr($phonenumb, 0, 1) == 8)) {
        echo 'Формат телефона неверен. Убедитесь что пишете в формате 8*<br>';
        $e = 1;
    }

    //Cверяем пароль и хешируем его
    $pass = trim(filter_input(INPUT_POST, 'password'));
    $pass_ch = trim(filter_input(INPUT_POST, 'password_ch'));
    if ($pass === $pass_ch) {
        $pass_hash = hash('sha256', $pass);
    } else {
        echo 'Введённые пароли не совпадают<br>';
        $e = 1;
    }


    //Получем данные о том, работник клиент, или нет
    if (isset($_REQUEST['ch'])) {
        $da = filter_input(INPUT_POST, 'filialid');
        $filialid = select_id_fil($con, $da);
    } else {
        $filialid = 0;
    }
    //Назначаем отсутствие телефона для помещения в базу, если не введён
    if ($phonenumb == "") {
        $phonenumb = 0;
    }
    if ($passport == "") {
        $passport = 0;
    }

    if ($e!=1) {
        set_man($con, $name, $surname, $middlename, $filialid, $passport, $email, $pass_hash, $phonenumb);
    }
}
?>
