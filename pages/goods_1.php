<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Недвижимость</title>        
        <link rel="shortcut icon" href="resources/favicon.ico" type="image/x-icon">
        <style>  
            td {border: black solid}
            .image {height: 240px; width: 320px;}
            .timg{width: 320px;}
        </style>
    </head> 
    <body> 
        <?php
        include_once './config.php';
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
            echo $path;
            header('Location: ' . $path);
        } else {
            $page = filter_input(INPUT_GET, 'page');
        }
        $numpages = ceil(getobjectcount($con) / $limit);
        if ($page > $numpages) {
            $page = $numpages;
            $path = basename(__FILE__) . '?page=' . ($page);
            header('Location: ' . $path);
        }
        //--------------------------чтобы не было разницы в выводе
        $squery = mysqli_query($con, "SELECT * FROM object o where o.sold=0 limit " . $page * $limit . ", $limit");
        $mass = loadnescojects($con, $page, $limit);
        ?>
        <table class="main_conteiner" style="border: black dotted; width: 100%">
            <?php
            $array = array();
            while ($mass = mysqli_fetch_assoc($squery)) {
                //----------------Подгрузка картинок
                $filename = loadimages($mass['number']);
                $text = "<tr><td class = \"capt\"><a href=\"item.php?numb=".$mass['number']."\">".$mass['title']."</a>
                    </td>
                    <td class=\"timg\">
                        <img src=\"".$filename."\" class=\"image\" alt=\"".$mass['title']."\"/>
                    </td>
                </tr>
                <tr>
                    <td colspan=\"2\">".$mass['description']."</td>
                </tr>";
                array_push($array, $text);
            }
            //print_r($array);
            foreach ($array as $value) {
                echo $value;
            }
            ?>

        </table>
        <?php
        if ($numpages > 1) {
            if ($page != 0) {
                echo "<a href=\"" . basename(__FILE__) . "?page=0\">Первая</a> ";
            }
            for ($i = 0; $i < $numpages; $i++) {
                //-----------------------------------------------------------------------------------
                if ($page != $i) {
                    echo "<a href=\"" . basename(__FILE__) . "?page=" . $i . "\">" . ($i + 1) . "</a> ";
                } else {
                    echo "<strong><a href=\"" . basename(__FILE__) . "?page=" . $i . "\">" . ($i + 1) . "</a></strong> ";
                }
                //-----------------------------------------------------------------------------------
            }
            if ($page != ($numpages - 1)) {
                echo "<a href=\"" . basename(__FILE__) . "?page=" . ($numpages - 1) . "\">Последняя</a>";
            }
        }
        ?>
    </body>
</html>