<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Недвижимость</title>        
        <link rel="shortcut icon" href="resources/favicon.ico" type="image/x-icon">        
        <link rel="stylesheet" type="text/css" href="../css/goods.css">
        <style>  
            
           
        </style>
    </head> 
    <body>
        <?php include 'head.html'; ?>
        <div class="signbl">
        <form method="get">
            <div class="s" style="float:left;">
            <input type="text" name="srhtxt" placeholder="Введите название"/><br/>                                  
                <input name="pricefrom" placeholder="Цена от" type="number"  min="1" max="1000000000"/><br/>
                <input name="pricebefor" placeholder="Цена до" type="number"  min="1" max="1000000000"/><br/>
                <input name="roomcount" placeholder="Кол-во комнат" type="number"  min="1" max="100"/><br/>              
                </div>                
                <hr class="b">
                <div class="s" style="float:right;">
                <input name="housenumb" placeholder="Номер дома" type="number" /><br/>
                <input name="street" placeholder="Улица" type="text" /><br/>
                <input name="district" placeholder="Район" type="text" /><br/>
                <input name="settling" placeholder="Город" type="text" /><br/>
                </div>
            <input type="submit" name="srhbtn" value="Искать">
        </form>
        <table class="main_conteiner">
            <?php echo implode('', $items);?>
        </table>
        </div>
        <div class='links'><?php echo implode('', $links);?></div>
        
    </body>   
</html>