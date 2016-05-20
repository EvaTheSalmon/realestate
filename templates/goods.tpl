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
        <form method="get">
            <input type="text" name="srhtxt" placeholder="Введите название"/>
            
                           
                <input name="pricefrom" placeholder="Цена от" type="number"  min="1" max="1000000000"/>
                <input name="pricebefor" placeholder="Цена до" type="number"  min="1" max="1000000000"/>
                <input name="roomcount" placeholder="Кол-во комнат" type="number"  min="1" max="100"/>
                <!--Адрес-->
                <input name="housenumb" placeholder="Номер дома" type="number" />
                <input name="street" placeholder="Улица" type="text" />
                <input name="district" placeholder="Район" type="text" />
                <input name="settling" placeholder="Город" type="text" />
           
            <input type="submit" name="srhbtn" value="Искать">
        </form>
        <table class="main_conteiner" style="border: black dotted">
            <?php echo implode('', $items);?>
        </table>
        <?php echo implode('', $links);?>
    </body>   
</html>