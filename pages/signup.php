<?php
include_once './config.php';
include './functions.php';
include './signup_code.php';
?>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Недвижимость</title>        
        <link rel="shortcut icon" href="resources/favicon.ico" type="image/x-icon">
        <style>
            html{background-color: #4f4f4f;}

            input[type=checkbox] + label {
                visibility: hidden;                
            } 
            input[type=checkbox]:checked + label {

                visibility: visible;
            } 
        </style>
<!--     <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.2/jquery.min.js"></script>
    <script type="text/javascript">
        window.jQuery || document.write("<script type=\"text/javascript\" src=\"js/jquery-2.2.2.min.js\"><\/script>");
    </script>       -->
    </head>

    <body>   
        <form action="signup.php" method="post">
            <input type="text" name="name" placeholder="Имя" value="" required/>
            <input type="text" name="surname" placeholder="Фамилия" value="" required/>
            <input type="text" name="middle-name" placeholder="Отчество" value=""/>
            <input type="email" name="email" placeholder="Email" value="" required/>
            <input type="text" name="passport" placeholder="Паспорт" value="" required/>
            <input type="text" name="phonenumb" placeholder="Телефон" value=""/>
            <input type="checkbox" value="Я работник компании" id="ch" name="ch"/>
            <label for='ch'><?php select_fil($con) ?></label>             
            <input type="password" name="password" class='list' id='list' placeholder="Придумайте пароль" value="" required/>
            <input type="submit" name="sign" value="Войти" />
        </form>

    </body>
</html>

