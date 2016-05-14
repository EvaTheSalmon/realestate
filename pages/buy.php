<?php

include_once './config.php';
include_once './functions.php';
session_start();
$number = $_SESSION['item_number'];
$persinf = checklogin($con);
echo $number;
$_SESSION['bin'];

if (!$persinf == 0) {
    if (isset($_REQUEST['buy'])) {
        if (!isset($_SESSION['bin'], $number)) {
            array_push($_SESSION['bin'], $number);

            //header('Location: ' . $_SERVER['HTTP_REFERER']);
        } else {
            echo 'Уже добавлен';
        }
    }
} else {
    header("Location: login.php");
}
?>