<?php
include_once './config.php';
include_once './functions.php';
include_once './goods_code.php';
?>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Недвижимость</title>        
        <link rel="shortcut icon" href="resources/favicon.ico" type="image/x-icon">
        <style>
            html{background-color: #4f4f4f;}
            .back{margin-left: 15%; margin-right: 15%; min-width: 700px; height: max-content; background: red;}
            .mappa{height: 150px; width: 100%; top: 5px; left: 5px;}
        </style>
    </head>    
    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.2/jquery.min.js"></script>
    <script type="text/javascript">
        window.jQuery || document.write("<script type=\"text/javascript\" src=\"js/jquery-2.2.2.min.js\"><\/script>");
    </script>    
    <body>   
        <div class="back">
            <?php
            $n=$i+5;
            while ($i<$n) {
            $obj = loadgoodsinf($con, $i);
            try{
                $filename = '../resources/'.$i.'.jpg';
                
                    if(!file_exists($filename)){
                        throw new Exception('noImg');
            }} 
            catch (Exception $exc){
                $filename = '../resources/domik.jpg';
            }            
            ?>
            <table>
                <tr>
                    <td>
                        <p style = "caption"><?php echo $obj['title'] ?></p><br/>
                        <p class="description"><?php echo $obj['description'] ?></p>
                    </td>
                    <td><img src='<?php echo $filename ?>' height='240' width='320'></td>
                </tr>
                <tr>
                    <td colspan="2">
                        <form action="goods.php" method="post">
                            <input type="submit" name="buy" value="Цена вопроса <?php echo $obj['cost'] ?>">
                        </form>
                    </td>
                </tr>                     
                <tr>
                    <td>
                        <div id="map<?php //echo $i; ?>" class="mappa"></div>
                    </td>
                    <td><input type="text" value="<?php echo loadgoodsadr($con, $i) ?>" id="address<?php //echo $i; ?>"></td>
                </tr>
            </table>
            <?php } ?>
            <!---------------------------------------------------------------------------->
            <script type="text/javascript" src="http://maps.google.com/maps/api/js"></script>
            <script src="map.js">            
            </script>
            <script async defer
                    src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCKJy5rIOT0ALJP6x7Ks32fm7gMTyDylcE&callback=initMap">
            </script>
            <!---------------------------------------------------------------------------->

        </div>
        <form action="goods.php">
            <?php if ($i-5>0) {?>
            <input type="submit" name="back" value="Назад"/>
            <?php } ?>
            <input type="submit" name="next" value="Далее"/>            
        </form>
    </body>
</html>