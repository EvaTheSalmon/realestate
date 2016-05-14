<?php

include_once './config.php';
include_once './functions.php';
(int) $number = filter_input(INPUT_GET, 'numb');
if (!isset($number)) {
    $number = selectitnotsold($con);
    //header('Location: ' . basename(__FILE__) . '?numb='.$number);
}
if (issold($con, $number) == 0) {
    session_start();
    

    if ($number < 1) {
        $number = 1;
        $path = basename(__FILE__) . '?numb=' . $number;
        header('Location: ' . $path);
    }
    if ($number > getobjectcount($con)) {
        $number = getobjectcount($con);
        $path = basename(__FILE__) . '?numb=' . ($number - 1);
        header('Location: ' . $path);
    }
    $_SESSION['item_number'] = $number;
    $inf = loadgoodsinf($con, mysqli_real_escape_string($con, $number));
    $title = $inf['title'];
    $cost = $inf['cost'];
    $date = $inf['offer-date'];
    $description = $inf['description'];
    $address = getaddress($con, $inf['number']);
    $filename = loadimages($inf['number']);
    include '../templates/item.tpl';
} else {
    echo 'Данный объект уже продан';
}
?>