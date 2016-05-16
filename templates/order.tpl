<html>
    <head>
        <meta charset="UTF-8">
        <title>Недвижимость</title>        
        <link rel="shortcut icon" href="../resources/favicon.ico" type="image/x-icon">
        <style>
            html{background-color: #4f4f4f;}
            .image{height: 100px; width 80px;}
            td{border: black dotted }
        </style>
    </head>
    <body>   
        <table style="border: black dotted; max-width: 1024px; margin: auto;" >
            <form method="post">
                <tr>
                    <?php echo implode('', $mass);?>
                </tr>
                <tr align="center">
                    <td colspan="<?php echo count($mass)*4; ?>" style="border: black dotted">
                        <input type="submit" value="Подтвердить" name="cor"/>После нажатия кнопки ваш заказ будет оформлены и Вас перенаправят
                    </td>
                </tr>
            </form>
        </table>
    </body>
</html>