<?php

try {
    header('Content-Type:text/html; charset=utf-8');
    $host = 'localhost';
    $user = 'root';
    $pass = 'vertrigo';
    $db = 'realestate';
    $con = mysqli_connect($host, $user, $pass, $db);
    if (!$con) {
        throw new Exception('Не удаётся подключиться к базе');
    } else {
        //echo 'Подключено';
    }
    mysqli_query($con, "SET NAMES 'utf8'");
} catch (Exception $exc) {
    echo 'Ошибка: ', $exc->getMessage(), '\n';
    die();
}
?>
