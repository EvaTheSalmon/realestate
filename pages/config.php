<?php
header('Content-Type:text/html; charset=utf-8');
$host = 'localhost';
$user = 'root';
$pass = 'vertrigo';
$db = 'realestate';

$con = mysqli_connect($host, $user, $pass, $db);
if (!$con) {
    echo '<br>The base has been droped' . mysql_error($con);
    exit();
} else {
    //echo 'Connected';
}
mysqli_query($con, "SET NAMES 'utf8'");
?>
