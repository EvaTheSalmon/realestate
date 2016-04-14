<?php ?>
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
        <form action="signup.php" method="post">
            <input type="text" name="name" placeholder="Имя" value="" required/>
            <input type="text" name="surname" placeholder="Фамилия" value="" required/>
            <input type="text" name="middle-name" placeholder="Отчество" value=""/>
            <input type="email" name="email" placeholder="Email" value="" required/>
            <input type="text" name="passport" placeholder="Паспорт" value="" required/>
            <input type="text" name="phonenumb" placeholder="Телефон" value=""/>
            <input type="checkbox" value="Я работник компании"/>
            <input type="submit" name="sign" value="Войти"/>
        </form>
        
    </body>
</html>