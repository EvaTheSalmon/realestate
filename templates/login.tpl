<html>
    <head>
        <meta charset="UTF-8">
        <title>Недвижимость</title>        
        <link rel="shortcut icon" href="../resources/favicon.ico" type="image/x-icon">        
        <link rel="stylesheet" type="text/css" href="../css/common.css">
        <link rel="stylesheet" type="text/css" href="../css/login.css">
        
        <style>                        
        </style>
    </head>
    <body>
        <?php include 'head.html'; if (isset($b)) {?>
        <div class="pop"><p><?php echo $b; ?></p></div> <?php } ?>
        <div class="poles">            
            <form action="../pages/login.php" method="post">
                <input type="text" name="name" placeholder="Ваше имя" />
                <input type="password" name="pass" placeholder="Ваш пароль" />
                <input type="submit" name="send" value="Войти"/>
                <?php if (!isset($_SESSION)) {session_start();} if(empty($_SESSION['persinf'])==0){ ?><input type="submit" name="quit" value="Выйти"/><?php } ?>
            </form>        
        </div>
    </body>
</html>