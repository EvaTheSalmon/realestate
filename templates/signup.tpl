<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Недвижимость</title>        
        <link rel="shortcut icon" href="../resources/favicon.ico" type="image/x-icon">
        <link rel="stylesheet" type="text/css" href="../css/common.css">
        <link rel="stylesheet" type="text/css" href="../css/signup.css">
        <style>                                   
        </style>
    </head>

    <body>   
        <?php include 'head.html'; ?>
        <?php if(isset($b)){?> <div class="pop"><p> <?php echo $b; ?></p></div> <?php } unset($b); ?>
        <div class="signbl">
            <form action="../pages/signup.php" method="post">
                <div class="s" style="float:left;">
                    <input type="text" name="name" placeholder="Имя" value="" required/><br/>
                    <input type="text" name="surname" placeholder="Фамилия" value="" required/><br/>
                    <input type="text" name="middle-name" placeholder="Отчество" value=""/><br/>
                    <input type="text" name="email" placeholder="Email" value="" required/><br/>
                </div>
                <hr class="b">
                <div class="s" style="float:right;">
                    <input type="text" name="passport" placeholder="Паспорт" value=""/><br/>
                    <input type="text" name="phonenumb" placeholder="Телефон" value=""/><br/>
                    <input type="checkbox" id="ch" name="ch"/>Я работник организации
                    <label for='ch'><?php select_fil($con); ?></label><br/>
                    <input type="password" name="password" class='list' id='list' placeholder="Придумайте пароль" value="" required/><br/>
                    <input type="password" name="password_ch" class='list' id='list' placeholder="Повторите пароль" value="" required/><br/>
                </div>
                <div class="g-recaptcha" data-sitekey="6LfRKiATAAAAAB3UKUtUx0GlcvLIEgZES-1SNpCC"></div>
                <input type="submit" name="sign" value="Зарегестрироваться" /><br>            
            </form>   
        </div>
        <script src='https://www.google.com/recaptcha/api.js'></script>
    </body>
</html>

