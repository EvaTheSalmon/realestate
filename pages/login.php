<?php

include './config.php';
include './functions.php';
echo '<br>';
if (isset($_REQUEST['send'])) {
    $name = filter_input(INPUT_POST, 'name');

    if (is_email($name)) {
        //определяем почта ли, для поиска        
        $fb = let_login($con, 'email', $name);
        echo 'email';
        //----------------------------------------------
    } elseif (strlen($name) == 10) {
        //определяем паспорт ли        
        $fb = let_login($con, 'passport', $name);
        echo 'pass';
        //----------------------------------------------
    } elseif (strlen($name) == 11 and substr($name, 0, 1) == 8) {
        //номер в записи с 8        
        $fb = let_login($con, 'phonenumb', $name);
        echo 'numb 8 ';
        //----------------------------------------------
    } elseif (substr($name, 0, 2) == "+7" and strlen($name) == 12) {
        $name = substr($name, 2);
        $name = '8' . $name;
        //номер в записи с +7              
        $fb = let_login($con, 'phonenumb', $name);
        echo 'numb +7';
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
            echo '<br>Данные переданы';
        } else {
            echo 'Вы не зарегестрированы в базе';
        }
    }
}
?>