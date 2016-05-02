<?php
//проверка на вход
include_once './config.php';
include_once './functions.php';

$number =  $_GET['number'];

$an = getagentname($con, $number);
$agentname = $an['name']. ' '. $an['surname'];

$on = getownername($con, $number);
$ownername = $on['name'].' '.$on['surname'];


?>