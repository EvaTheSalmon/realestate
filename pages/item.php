<?php

include_once './config.php';
include_once './functions.php';
(int) $number = filter_input(INPUT_GET, 'numb');
if ($number < 1) {
    $number = 1;
    $path = basename(__FILE__) . '?numb=' . $number;
    header('Location: ' . $path);
}
if ($number > getobjectcount($con)) {
    $number = getobjectcount($con);
    $path = basename(__FILE__) . '?numb=' . $number;
    header('Location: ' . $path);
}
$inf = loadgoodsinf($con, mysqli_real_escape_string($con, $number));
$title = $inf['title'];
$cost = $inf['cost'];
$date = $inf['offer-date'];
$description = $inf['description'];
$address = getaddress($con, $inf['number']);
$filename = loadimages($inf['number']);
include '../templates/item.tpl';
?>