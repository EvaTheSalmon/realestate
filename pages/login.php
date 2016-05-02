<?php

include_once './config.php';
include_once './functions.php';

if (null !== (filter_input(INPUT_COOKIE, 'log'))) {
    $cook = filter_input(INPUT_COOKIE, 'log');
    if (islogin($cook, $con) == true) {
        $mass = unserialize(filter_input(INPUT_COOKIE, 'log'));
        $fb = $mass['pa'];
        $_SESSION['persinf'] = get_name($con, $fb);
    }
}
if (!isset($_SESSION['persinf'])) {
    
    if (isset($_REQUEST['send'])) {
        $name = mysqli_real_escape_string($con, filter_input(INPUT_POST, 'name'));
        //экранируем name   
        if (is_email($name)) {
            //определяем почта ли, для поиска        
            $fb = let_login($con, 'email', $name);
            //echo 'email';
            //----------------------------------------------
        } elseif (strlen($name) == 10) {
            //определяем паспорт ли        
            $fb = let_login($con, 'passport', $name);
            //echo 'pass';
            //----------------------------------------------
        } elseif (strlen($name) == 11 and substr($name, 0, 1) == 8) {
            //номер в записи с 8        
            $fb = let_login($con, 'phonenumb', $name);
            //echo 'numb 8 ';
            //----------------------------------------------
        } elseif (substr($name, 0, 2) == "+7" and strlen($name) == 12) {
            $name = substr($name, 2);
            $name = '8' . $name;
            //номер в записи с +7              
            $fb = let_login($con, 'phonenumb', $name);
            //echo 'numb +7';
            //----------------------------------------------
        } else {
            echo '<br>Вы ввели неверные данные';
        }
        //----------------------------------------------
        //Далее код входа на сайт, сравнение хэша.
        if (isset($fb) and $fb != 'end') {
            $pass = trim(filter_input(INPUT_POST, 'pass'));
            $pass_hash = hash('sha256', $pass);

            if ($fb == $pass_hash) {
                session_start();
                //Передаём массив с данными в сессию. Массив двумерный             
                $_SESSION['persinf'] = get_name($con, $fb);
                //для куков-------------------------
                $info['em'] = get_user_emhas($con, $pass_hash);
                $info['pa'] = $pass_hash;
                $info['ip'] = hash('sha256', $_SERVER['REMOTE_ADDR']);
                $value = serialize($info);
                setcookie('log', $value, time() + 60 * 60 * 24 * 7);
                header('location: login.php');
                //----------------------------------
                echo '<br>Данные переданы';
            } else {
                echo 'Вы не зарегестрированы в базе';
            }
        }
    }
} else {
    echo 'Вы уже вошли';
}
include '../templates/login.tpl';
?>