<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Недвижимость</title>        
        <link rel="shortcut icon" href="resources/favicon.ico" type="image/x-icon">
        <style>  
            td {border: black solid}
            .image {height: 240px; width: 320px;}
            .timg{width: 320px;}
        </style>
    </head> 
    <body>
        <table class="main_conteiner" style="border: black dotted">
            <?php echo implode('', $items);?>
        </table>
        <?php echo implode('', $links);?>
    </body>   
</html>