<?php

include './config.php';
include './functions.php';
if (isset($_REQUEST['sign'])) {
    $name = filter_input(INPUT_POST, 'name');
    $surname = filter_input(INPUT_POST, 'surname');
    $middlename = filter_input(INPUT_POST, 'middle-name');
    $email = filter_input(INPUT_POST, 'email');
    $passport = filter_input(INPUT_POST, 'passport');
    $phonenumb = filter_input(INPUT_POST, 'phonenumb');    
    $pass = trim(filter_input(INPUT_POST, 'password'));
    $pass_hash = hash('sha256', $pass);
    
    if ($_REQUEST['ch']==1){
        $da = filter_input(INPUT_POST, 'filialid');
        $filialid = select_id_fil($con, $da);
    } else {
        $filialid = 0;
    }
    
    set_man($name, $surname, $middlename, $filialid, $passport, $email, $pass_hash, $phonenumb);
}
?>
