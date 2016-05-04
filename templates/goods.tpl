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
            
            <tr>
                <td class = "capt">
                    <a href=\"http://localhost/realestate-master/pages/item.php?numb="<?php  echo $mass['number']?>"><?php echo $mass['title']?></a>
                </td>
                <td class="timg">
                    <img src="<?php echo $filename ?>" class="image"/>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <?php echo $mass['description']?>
                </td>
            </tr>
        </table>