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
            <table>
                <tr>
                    <td>
                        <p style = "caption"></p><br/>
                        <p class="description"></p>
                    </td>
                    <td><img src='<?php echo $filename ?>' height='240' width='320'></td>
                </tr>
                <tr>
                    <td colspan="2">
                        <form action="goods.php" method="post">
                            <input type="submit" name="buy" value="Цена вопроса <?php echo $mass[$i]['cost'] ?>">
                        </form>
                    </td>
                </tr>                     
                <tr>
                    <td>
                        <div id="map" class="mappa"></div>
                    </td>
                    <td><input type="text" value="<?php echo loadgoodsadr($con, $i) ?>" id="address"></td>
                </tr>
            </table>
        </div>
    </body>
</html> 