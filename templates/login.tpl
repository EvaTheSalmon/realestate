<?php
if (isset($_COOKIE['log'])){print_r(unserialize($_COOKIE['log']));}
?>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Недвижимость</title>        
        <link rel="shortcut icon" href="../resources/favicon.ico" type="image/x-icon">
        <style>
            html{background-color: #4f4f4f;}
        </style>
    </head>
    <body>   
        <form action="../pages/login.php" method="post">
            <input type="text" name="name" placeholder="Ваше имя" value="jftf@b-d-un.com"/>
            <input type="password" name="pass" placeholder="Ваш пароль" value="1"/>
            <input type="submit" name="send" value="Войти"/>
        </form>        
    </body>
</html>