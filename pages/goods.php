<?php

include_once './functions.php';
//Подгрузка количества элементов на странице из базы, если есть
if (isset($_SESSION['persinf'])) {
    $info = $_SESSION['persinf'];
    $limit = $info['limit'];
} else {
    $limit = 5;
}
//Экранируем нестандартные значения страницы
(int) $page = filter_input(INPUT_GET, 'page');
if ($page < 0) {
    $path = basename(__FILE__) . '?page=0';    
    header('Location: ' . $path);
} else {
    $page = filter_input(INPUT_GET, 'page');
}

$numpages = ceil(getobjectcount() / $limit);
if ($page > $numpages) {
    $page = $numpages;
    $path = basename(__FILE__) . '?page=' . ($page);
    header('Location: ' . $path);
}
//--------------------------чтобы не было разницы в выводе
$sql = "SELECT * FROM object o where o.sold=0 limit " . $page * $limit . ", $limit";
$con = config();
$squery = mysqli_query($con, $sql);
$mass = loadnescojects($page, $limit);


$items = array();
while ($mass = mysqli_fetch_assoc($squery)) {
    //----------------Подгрузка картинок
    $filename = loadimages($mass['number']);
    $text = "<tr><td class = \"capt\"><a href=\"item.php?numb=" . $mass['number'] . "\">" . $mass['title'] . "</a>
                    </td>
                    <td class=\"timg\">
                        <img src=\"" . $filename . "\" class=\"image\" alt=\"" . $mass['title'] . "\"/>
                    </td>
                </tr>
                <tr>
                    <td colspan=\"2\">" . $mass['description'] . "</td>
                </tr>";

    $items[] = $text;
}
//print_r($array);


$links = array();
if ($numpages > 1) {
    if ($page != 0) {
        $first = "<a href=\"" . basename(__FILE__) . "?page=0\">Первая</a> ";
        array_push($links, $first);
    }
    for ($i = 0; $i < $numpages; $i++) {
        //-----------------------------------------------------------------------------------
        if ($page != $i) {
            $else = "<a href=\"" . basename(__FILE__) . "?page=" . $i . "\">" . ($i + 1) . "</a> ";
            array_push($links, $else);
        } else {
            $else = "<strong><a href=\"" . basename(__FILE__) . "?page=" . $i . "\">" . ($i + 1) . "</a></strong> ";
            array_push($links, $else);
        }
        //-----------------------------------------------------------------------------------
    }
    if ($page != ($numpages - 1)) {
        $last = "<a href=\"" . basename(__FILE__) . "?page=" . ($numpages - 1) . "\">Последняя</a>";
        $links[] = $last;
    }
}
include '../templates/goods.tpl';
?>    