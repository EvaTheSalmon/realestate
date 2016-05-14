<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Недвижимость</title>        
        <link rel="shortcut icon" href="resources/favicon.ico" type="image/x-icon">
        <style>            
        </style>        
    </head>
    <body>
        <?php echo $surname; ?>
        <form action="../pages/cabinet.php<?php echo '?'.$_SERVER['QUERY_STRING'] ?>" method="post">
            <p>Количество новостей на страницу</p><input type="number" max="20" min="1" name="number" value="<?php echo $limit_bs ?>"/>
        <input type="submit" name="save" value="Сохранить настройки">
        </form>
               

    </body>
</html>