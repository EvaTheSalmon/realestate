<?php

include_once './config.php';
$number = $_GET['numb'];
$sql = "SELECT * FROM object o where o.number =" . $number;
$query = mysqli_query($con, $sql);
$inf = mysqli_fetch_assoc($query);
$title = $inf['title'];
$cost = $inf['cost'];
$date = $inf['offer-date'];
$description = $inf['description'];

$sql_m = "SELECT o.house, d.name AS 'District', s.name as 'Town', s1.name AS 'Street' FROM object o JOIN district d ON o.`district-id` = d.id
JOIN settling s ON o.`settling-id` = s.id JOIN street s1 ON o.`street-id` = s1.id WHERE o.number=".$inf['number'];
$query_m=  mysqli_query($con, $sql_m);
$mass = mysqli_fetch_assoc($query_m);
$address = 'Улица '.$mass['Street'].' '.$mass['house'].' '.$mass['District'].' район, '.$mass['Town'];
try {
    $filename = '../resources/' . $inf['number'] . '.jpg';
    if (!file_exists($filename)) {
        throw new Exception('noImg');
    }
} catch (Exception $exc) {
    $filename = '../resources/domik.jpg';
}

$price = $inf['price'];

include '../templates/item.tpl';
?>