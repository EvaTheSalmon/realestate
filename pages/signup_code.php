<?php

include_once './config.php';
include_once './functions.php';

if (isset($_REQUEST['sign'])) {
    $name = filter_input(INPUT_POST, 'name');
    $surname = filter_input(INPUT_POST, 'surname');
    $middlename = filter_input(INPUT_POST, 'middle-name');
    $email = filter_input(INPUT_POST, 'email');
    $passport = filter_input(INPUT_POST, 'passport');
    $phonenumb = filter_input(INPUT_POST, 'phonenumb');
    $pass = trim(filter_input(INPUT_POST, 'password'));
    $pass_hash = hash('sha256', $pass);
    
    //if ((is_email($email) == true) and ( strlen($phonenumb) == 11 and substr($phonenumb, 0, 1) == 8) and ( strlen($passport) == 10)) {
      
        if ($_REQUEST['ch'] == 1) {
            $da = filter_input(INPUT_POST, 'filialid');
            $filialid = select_id_fil($con, $da);
        } else {
            $filialid = 0;
        }
    
        echo 'Филя '.$filialid.'<br>';
        set_man($name, $surname, $middlename, $filialid, $passport, $email, $pass_hash, $phonenumb);
        
    }
//} else {
//    echo 'Введены неверные данные';
//}
?>
