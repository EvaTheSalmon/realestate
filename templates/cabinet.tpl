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
        <!--Сюда добавить "Предложить дом" -->  
        <br/>
        <form method="post">
            <input name="name" placeholder="Название" type="text" required/>
            <input name="description" placeholder="Описание" type="text" required/>
            <input name="price" placeholder="Цена" type="number" required min="1" max="1000000000"/>
            <input name="roomcount" placeholder="Кол-во комнат" type="number" min="1" max="100" value="1"/>
            <?php select_type(); //Вывод вариантов жилья ?>
            <!--Адрес-->
            <input name="housenumb" placeholder="Номер дома" type="number" required/>
            <input name="street" placeholder="Улица" type="text" required/>
            <input name="district" placeholder="Район" type="text" required/>
            <input name="settling" placeholder="Город" type="text" required/>
            <?php select_types() ?>
            <input name="add" value="Добавить" type="submit"/>
        </form>
    </body>
</html>