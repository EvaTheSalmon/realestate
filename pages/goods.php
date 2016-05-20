<?php

include_once './functions.php';
$con = config();
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
$morlinks = '';
//empty(mysqli_real_escape_string($con, ucfirst(strtolower(trim(filter_input(INPUT_POST, 'srhtxt')))))) == 0
//Модуль для поиска
if (isset($_REQUEST['srhbtn'])) {
    
    $name = mysqli_real_escape_string($con, ucfirst(strtolower(trim(filter_input(INPUT_GET, 'srhtxt')))));
    $street = mysqli_real_escape_string($con, ucfirst(strtolower(trim(filter_input(INPUT_GET, 'street')))));
    $district = mysqli_real_escape_string($con, ucfirst(strtolower(trim(filter_input(INPUT_GET, 'district')))));
    $settling = mysqli_real_escape_string($con, ucfirst(strtolower(trim(filter_input(INPUT_GET, 'settling')))));
    $roomcount = filter_input(INPUT_GET, 'roomcount');
    $housenumb = filter_input(INPUT_GET, 'housenumb');
    $pricebefor = filter_input(INPUT_GET, 'pricebefor');
    $pricefrom = filter_input(INPUT_GET, 'pricefrom');
    $house = filter_input(INPUT_GET, 'housenumb');

    $mass = searchitems($name, $pricefrom, $pricebefor, $roomcount, $street, $district, $settling, $house, $page, $limit);
    $count_all_el = countitemssearch($name, $pricefrom, $pricebefor, $roomcount, $street, $district, $settling, $house, $page, $limit);
    //echo $limit;
    $morlinks = '&' . substr($_SERVER["QUERY_STRING"], 1, strlen($_SERVER["QUERY_STRING"]) - 1);
    $numpages = ceil($count_all_el / $limit);
    //echo $numpages . '<br>';

    if ($page > $numpages) {
        $page = $numpages;
        $path = basename(__FILE__) . '?page=' . ($page);
        header('Location: ' . $path);
    }
    //-------Запрос в базу для сопоставления while
    $sql = $mass['sql'];
    $query = mysqli_query($con, $sql);
    //$mass = searchitems($srhtxt);
    //--------------------------------
    if (isset($con)) {
        mysqli_close($con);
    }
    //-------------------------------- 
    //Проверка на пустоту/отсутствие значений
    if (empty($mass) == 0) {
        while ($mass = mysqli_fetch_assoc($query)) {
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
    } 
} else {
    //Для стандартной выдачи (не поиск)
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
    //--------------------------------
    if (isset($con)) {
        mysqli_close($con);
    }
    //-------------------------------- 
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
}
//Страницы внизу экрана
$links = array();
if ($numpages > 1) {
    if ($page != 0) {
        $first = "<a href=\"" . basename(__FILE__) . "?page=0" . $morlinks . "\">Первая</a> ";
        array_push($links, $first);
    }
    for ($i = 0; $i < $numpages; $i++) {
        //-----------------------------------------------------------------------------------
        if ($page != $i) {
            $else = "<a href=\"" . basename(__FILE__) . "?page=" . $i . $morlinks . "\">" . ($i + 1) . "</a> ";
            array_push($links, $else);
        } else {
            $else = "<strong><a href=\"" . basename(__FILE__) . "?page=" . $i . $morlinks . "\">" . ($i + 1) . "</a></strong> ";
            array_push($links, $else);
        }
        //-----------------------------------------------------------------------------------
    }
    if ($page != ($numpages - 1)) {
        $last = "<a href=\"" . basename(__FILE__) . "?page=" . ($numpages - 1) . $morlinks . "\">Последняя</a>";
        $links[] = $last;
    }
}
if (empty($items)==1){$items[] = 'Нет элементов с такими параметрами';}

include '../templates/goods.tpl';
?>    