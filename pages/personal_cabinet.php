<?php
if (isset($_COOKIE['login'])) {
    $name = $_COOKIE['login'];
    ?>
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
            <?php echo 'Добро пожаловать, ' . $name; ?>
        </body>
    </html>
<?php } else {
    header("Location: ./login_page.php");
}
?>


