<!DOCTYPE html>
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
        <form action="../pages/signup.php" method="post">
            <input type="text" name="name" placeholder="Имя" value="" required/><br/>
            <input type="text" name="surname" placeholder="Фамилия" value="" required/><br/>
            <input type="text" name="middle-name" placeholder="Отчество" value=""/><br/>
            <input type="text" name="email" placeholder="Email" value="" required/><br/>
            <input type="text" name="passport" placeholder="Паспорт" value=""/><br/>
            <input type="text" name="phonenumb" placeholder="Телефон" value=""/><br/>
            <input type="checkbox" id="ch" name="ch"/>Я работник организации
            <label for='ch'><?php select_fil($con); ?></label><br/>
            <input type="password" name="password" class='list' id='list' placeholder="Придумайте пароль" value="" required/><br/>
            <input type="password" name="password_ch" class='list' id='list' placeholder="Повторите пароль" value="" required/><br/>
            <div class="g-recaptcha" data-sitekey="6LfRKiATAAAAAB3UKUtUx0GlcvLIEgZES-1SNpCC"></div>
            <input type="submit" name="sign" value="Войти" /><br>            
        </form>   
        <script src='https://www.google.com/recaptcha/api.js'></script>
    </body>
</html>

