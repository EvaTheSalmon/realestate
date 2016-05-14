<?php


include_once './functions.php';
$con = config();
if (isset($_REQUEST['sign'])) {


    try {
        $name = mysqli_real_escape_string($con, filter_input(INPUT_POST, 'name'));

        $surname = mysqli_real_escape_string($con, filter_input(INPUT_POST, 'surname'));

        $middlename = mysqli_real_escape_string($con, filter_input(INPUT_POST, 'middle-name'));

        $email = filter_input(INPUT_POST, 'email');
        if (!is_email($email)) {
            //Проверяем почту                       
            throw new Exception('Формат почты не совпадет с существующими форматами');
        } else {
            $email = mysqli_real_escape_string($con, $email);
        }

        $passport = filter_input(INPUT_POST, 'passport');
        if (isset($passport)) {
            if (strlen($passport) !== 10) {
                throw new Exception('Формат паспорта неверен');
            }
        }

        $phonenumb = mysqli_real_escape_string($con, filter_input(INPUT_POST, 'phonenumb'));
        //Проверка номера телефона
        if ($phonenumb != "" and ! (strlen($phonenumb) == 11 and substr($phonenumb, 0, 1) == 8 and ! is_int($phonenumb))) {
            throw new Exception('Формат телефона неверен. Убедитесь что пишете в формате 8*');
        }

        //Cверяем пароль и хешируем его
        $pass = trim(filter_input(INPUT_POST, 'password'));
        $pass_ch = trim(filter_input(INPUT_POST, 'password_ch'));
        if ($pass === $pass_ch) {
            $pass_hash = hash('sha256', $pass);
        } else {
            throw new Exception('Введённые пароли не совпадают');
        }


        //Получем данные о том, работник клиент, или нет
        if (isset($_REQUEST['ch'])) {
            $da = filter_input(INPUT_POST, 'filialid');
            $filialid = select_id_fil($da);
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
        
        $email_hash = hash('sha256', trim($email));
        
        set_man($name, $surname, $middlename, $filialid, $passport, $email, $pass_hash, $email_hash, $phonenumb);
    } catch (Exception $exc) {
        echo 'Ошибка данных: ';
        
            echo $exc->getMessage(), "\n";
        
    }
}
include '../templates/signup.tpl';
?>