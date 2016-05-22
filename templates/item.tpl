<!Doctype html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Недвижимость</title>        
        <link rel="shortcut icon" href="../resources/favicon.ico" type="image/x-icon">
        <link rel="stylesheet" type="text/css" href="../css/common.css">
        <link rel="stylesheet" type="text/css" href="../css/item.css">
        <style></style>
    </head>    
    <body>
        <?php include 'head.html'; ?>
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
                            <div class="g-recaptcha" data-sitekey="6LfRKiATAAAAAB3UKUtUx0GlcvLIEgZES-1SNpCC"></div>
                            <?php echo $loggin; ?>   
                            <br/>
                            <?php if($isloggin==1){ echo implode('<br>', $reviews);}?>                        
                        </form>
                    </td>
                    <td>                        
                        <form method="post">
                            <input type="submit" value="Купить за <?php echo $cost ?>" name="buy">
                        </form>                        
                    </td>
                </tr>

            </table>            
        </div>
        <!-------------------------------------->
        <script type="text/javascript" src="../js/map.js.gz">
            initMap();
        </script>
        <script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCKJy5rIOT0ALJP6x7Ks32fm7gMTyDylcE&callback=initMap"></script>
        <script src='https://www.google.com/recaptcha/api.js'></script>
    </body>
</html> 