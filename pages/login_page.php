<?php include './login.php';?>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Недвижимость</title>
        <link rel="stylesheet" href="css/normalize.css">
        <link rel="shortcut icon" href="resources/favicon.ico" type="image/x-icon">
        <style>
            html{background-color: #4f4f4f;}
        </style>
    </head>
    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.2/jquery.min.js"></script>
    <script type="text/javascript">
        window.jQuery || document.write("<script type=\"text/javascript\" src=\"js/jquery-2.2.2.min.js\"><\/script>");
    </script>
    <body>   
        <form action="login_page.php" method="post">
            <input type="text" name="name" placeholder="Ваше имя" value="jftf@b-d-un.com"/>
            <input type="password" name="pass" placeholder="Ваш пароль" value="1"/>
            <input type="submit" name="send" value="Войти"/>
        </form>
        
    </body>
</html>