<!Doctype html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Недвижимость</title>        
        <link rel="shortcut icon" href="../resources/favicon.ico" type="image/x-icon">
        <style>
            html{background-color: #4f4f4f;}
            .back{margin-left: 15%; margin-right: 15%; min-width: 700px; height: max-content; background: red;}
            .mappa{height: 150px; width: 100%; top: 5px; left: 5px;}
            .image{height: 240px; width: 320px}
            .sys_adr{}
        </style>
    </head>    
    <body>
        <input value="<?php echo $address ?>" id="address" class="sys_adr" disabled hidden/>
        <div class="back">
            <table>
                <tr>
                    <td>
                        <p style = "caption"><?php echo $title ?></p><br/>
                        <p class="description"><?php echo $description ?></p>
                    </td>
                    <td><img src="<?php echo $filename ?>" class="image"></td>
                </tr>
                <tr>
                    <td><div style="width: 100%; height: 200px;" id="map"></div></td>
                    <td><p><?php echo $address ?></p></td>
                </tr>                     
                <tr>
                    <td>
                        <form method="post">
                         <?php echo $loggin; ?>   
                        <br/>
                        <?php if($isloggin==1 and $reviews !== null){ echo implode('<br>', $reviews);} ?>
                    </td>
                    <td>                        
                        
                            <input type="submit" value="Купить за <?php echo $cost ?>" name="buy">
                        </form>
                        <!--<a href="<?php basename(__FILE__) . '?numb=' . $number. '&&' ?>">Купить за <?php echo $cost ?></a>-->
                    </td>
                </tr>
                
            </table>            
        </div>
        <!-------------------------------------->
        <script type="text/javascript" src="../js/map.js">
            initMap();
        </script>
        <script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCKJy5rIOT0ALJP6x7Ks32fm7gMTyDylcE&callback=initMap"></script>
    </body>
</html> 