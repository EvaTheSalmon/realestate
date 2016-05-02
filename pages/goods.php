
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
            
        //$path = $_SERVER['SCRIPT_NAME'];
        
        include_once './config.php';
        include_once './functions.php';
        
        $limit = 5;


        if (empty($_GET['page']) or isset($page) < 0) {
            $page = 0;
        } else {
            $page = $_GET['page'];
        }
        $total = itemcount($con);
        if ($page > $total) {
            $page = $total;
        }
        //--------------------------
        $sql = "SELECT * FROM object o limit " . $page * $limit . ", $limit";
        $query = mysqli_query($con, $sql);
        $mass = mysqli_fetch_assoc($query);
        //--------------------------чтобы не было разницы в выводе
        $ssql = "SELECT * FROM object o limit " . $page * $limit . ", $limit";
        $squery = mysqli_query($con, $ssql);
        ?>
        <table class="main_conteiner" style="border: black dotted">
            <?php
            while ($mass = mysqli_fetch_assoc($squery)) {

                //----------------
                try {
                    $filename = '../resources/' . $mass['number'] . '.jpg';
                    if (!file_exists($filename)) {
                        throw new Exception('noImg');
                    }
                } catch (Exception $exc) {
                    $filename = '../resources/domik.jpg';
                }
                //-----------------

                echo "<tr><td class = \"capt\"><a href=\"http://localhost/realestate-master/pages/item.php?numb=" . $mass['number'] . "\">" . $mass['title'] . "</a></td><td class=\"timg \"><img src=\"" . $filename . "\" class=\"image\"></td><tr><td colspan=\"2\">" . $mass['description'] . "</td></tr>";
            }
            ?>
        </table>
        <?php
        $sql_n = "SELECT COUNT(*) FROM object o";
        $query_n = mysqli_query($con, $sql_n);
        $m = mysqli_fetch_row($query_n);

        $numpages = ceil($m[0] / $limit);
        if ($numpages > 1) {
            if ($page != 0) {
                echo "<a href=\"http://localhost/realestate-master/pages/goods.php?page=0\">Первая</a> ";
            }
            for ($i = 0; $i < $numpages; $i++) {
                //-----------------------------------------------------------------------------------
                if ($page != $i) {
                    echo "<a href=\"http://localhost/realestate-master/pages/goods.php?page=" . $i . "\">" . ($i + 1) . "</a> ";
                } else {
                    echo "<strong><a href=\"http://localhost/realestate-master/pages/goods.php?page=" . $i . "\">" . ($i + 1) . "</a></strong> ";
                }
                //-----------------------------------------------------------------------------------
            }
            if ($page != ($numpages - 1)) {
                echo "<a href=\"http://localhost/realestate-master/pages/goods.php?page=" . ($numpages - 1) . "\">Последняя</a>";
            }
        }
        ?>

    </body>
</html>