<?php
include_once './config.php';
include_once './functions.php';
?>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Недвижимость</title>        
        <link rel="shortcut icon" href="resources/favicon.ico" type="image/x-icon">
        <style>
            html{background-color: #4f4f4f;}
            .back{margin-left: 15%; margin-right: 15%; min-width: 700px; height: max-content; background: red;}
        </style>
    </head>
    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.2/jquery.min.js"></script>
    <script type="text/javascript">
        window.jQuery || document.write("<script type=\"text/javascript\" src=\"js/jquery-2.2.2.min.js\"><\/script>");
        function GetLocation() {
            var geocoder = new google.maps.Geocoder();
            var address = document.getElementById("txtAddress").value;
            geocoder.geocode({'address': address}, function (results, status) {
                if (status == google.maps.GeocoderStatus.OK) {
                    var latitude = results[0].geometry.location.lat();
                    var longitude = results[0].geometry.location.lng();
                    alert("Latitude: " + latitude + "\nLongitude: " + longitude);
                } else {
                    alert("Request failed.")
                }
            });
        };
    </script>
    <body>   
        <div class="back">
            <?php
            for ($i = 1; $i < 6; $i++) {
                $sql = "SELECT * FROM object o WHERE o.id='$id'";
                $query = mysqli_query($con, $sql);
                $mass[] = mysqli_fetch_assoc($query);
                echo '<table><tr><td><p style="caption">' . $mass[0]['title'] . '</p><br/><p class="description">' . $mass[0]['description'] . '</p></td>';
                //-------------------------------------------
                $filelimit = 1500000;
                $filename = "../resources/$i.jpg";
                if (filesize($filename) < $filelimit) {
                    echo '<td>' . "<img src='$filename'>" . '</td>';
                } else {
                    //Дополнить                                   
                }
                echo '</tr><tr><td colspan="2"><form action="goods.php" method="post"><input type="submit" name="buy" value="Цена вопроса ' . $mass[0]['cost'] . '"></td></tr>';
                echo '<tr><td></td><td></td></tr></table>';
                
                }
            ?>            

        </div>
    </body>
</html>