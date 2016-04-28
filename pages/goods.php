<?php

include_once './config.php';
include_once './functions.php';
include_once './goods_code.php';
$limit = 5;
////----------------
//try {
//    $filename = '../resources/' . $mass[$i]['id'] . '.jpg';
//    if (!file_exists($filename)) {
//        throw new Exception('noImg');
//    }
//} catch (Exception $exc) {
//    $filename = '../resources/domik.jpg';
//}
////-----------------

if (empty($_GET['page']) or isset($page) < 0) {
    $page = 0;
} else {
    $page = $_GET['page'];
}
$total = itemcount($con);
if ($page > $total)
    $page = $total;

$sql = "SELECT * FROM object o limit " . $page * $limit . ", $limit";
$query = mysqli_query($con, $sql);
$mass = mysqli_fetch_assoc($query);

while ($mass = mysqli_fetch_assoc($query)) {
    echo "<strong>" . $mass['title'] . "</strong><p>" . $mass['description'] . "</p>";
}

$sql_n = "SELECT COUNT(*) FROM object o";
$query_n = mysqli_query($con, $sql_n);
$m = mysqli_fetch_row($query_n);

$numpages = ceil($m[0] / $limit);
$test = "RealEstate/pages";
if ($numpages > 1) {
    if ($page != 0) {
        echo "<a href=\"/$test/goods.php?page=0\">Первая</a> ";
    }
    for ($i = 0; $i < $numpages; $i++) {
        if ($page != $i) {
            echo "<a href=\"/$test/goods.php?page=" . $i . "\">" . ($i + 1) . "</a> ";
        } else {
            echo "<strong><a href=\"/$test/goods.php?page=" . $i . "\">" . ($i + 1) . "</a></strong> ";
        }
    }
    if ($page != ($numpages - 1)) {
        echo "<a href=\"/$test/goods.php?page=" . ($numpages - 1) . "\">Последняя</a>";
    }
}
?>