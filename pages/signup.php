<?php

include_once './functions.php';
$con = config();
if (isset($_REQUEST['sign'])) {
    //Здесь живёт гугловская капча----
    $grr = $_POST['g-recaptcha-response'];
    $secret = '6LfRKiATAAAAAH609Lw326E2c2i3c2VunZdSRkC3';
    require_once "recaptchalib.php";
    $response = null;
    $reCaptcha = new ReCaptcha($secret);
    $response = $reCaptcha->verifyResponse($_SERVER["REMOTE_ADDR"], $_POST["g-recaptcha-response"]);
    //--------------------------------
    if (( $response != null && $response->success)) {
        try {
            $name = mysqli_real_escape_string($con, filter_input(INPUT_POST, 'name'));

            $surname = mysqli_real_escape_string($con, filter_input(INPUT_POST, 'surname'));
            $middlename = '';
            $middlename = mysqli_real_escape_string($con, filter_input(INPUT_POST, 'middle-name'));
            
            $email = filter_input(INPUT_POST, 'email');
            if (!is_email($email)) {
                //Проверяем почту 
                $err[] = 'Формат почты не совпадет с существующими форматами';
                throw new Exception();
            } else {
                $email = mysqli_real_escape_string($con, $email);
            }
            $passport='';
            $passport = filter_input(INPUT_POST, 'passport');
            if (($passport)!=='') {
                if (strlen($passport) !== 10) {
                    $err[] = 'Формат паспорта неверен';
                    throw new Exception();
                }
            }
            $phonenumb='';
            $phonenumb = filter_input(INPUT_POST, 'phonenumb');
            echo strlen($phonenumb);
            echo substr($phonenumb, 0, 1);
            //Проверка номера телефона
            if ($phonenumb !== "" and (!(strlen($phonenumb) == 11 and substr($phonenumb, 0, 1) == 8))) {
                $err[] = 'Формат телефона неверен. Убедитесь что пишете в формате 8*';
                throw new Exception();
            }

            //Cверяем пароль и хешируем его
            $pass='';
            $pass = trim(filter_input(INPUT_POST, 'password'));
            $pass_ch = trim(filter_input(INPUT_POST, 'password_ch'));
            if ($pass === $pass_ch) {
                $pass_hash = hash('sha256', $pass);
            } else {
                $err[] = 'Введённые пароли не совпадают';
                throw new Exception();                
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
            $b = 'Ошибка данных: '.  implode(' , ', $err)."\n";
        }
    } else {
        echo '<script language="javascript">alert("Проверьте капчу");</script>';
    }
}
include '../templates/signup.tpl';
?>