<html>
    <head>
        <meta charset="UTF-8">
        <title>Недвижимость</title>        
        <link rel="shortcut icon" href="../resources/favicon.ico" type="image/x-icon">
        <link rel="stylesheet" type="text/css" href="../css/common.css">
        <link rel="stylesheet" type="text/css" href="../css/order.css">
        <style>            
        </style>
    </head>
    <body>   
        <?php include 'head.html'; ?>
        
        <table style="" class="main">
            <form method="post">
                <tr>
                    <?php if (empty($mass)==0){ echo implode('', $mass);?>
                </tr>
                <tr align="center">
                    <td colspan="<?php echo count($mass)*4; ?>" style="border: black dotted">
                        <input type="submit" value="Подтвердить" name="cor"/>После нажатия кнопки ваш заказ будет оформлены и Вас перенаправят
                    </td> <?php } ?>
                </tr>
            </form>
        </table>
        
    </body>
</html>