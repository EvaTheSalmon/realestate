<?php

include_once './functions.php';

$persinf = checklogin();

if (empty($persinf) == 0) {
//print_r(get_name($fb));
    $name = $persinf[0]['name'];
    $surname = $persinf[0]['surname'];
    $id = $persinf[0]['id'];
    if (isset($_REQUEST['number']) && $_REQUEST['number'] != '') {
        $limit_bs = $_REQUEST['number'];
    } else {
        $limit_bs = $persinf[0]['limit'];
    }

    if (isset($_REQUEST['save'])) {
        $limit = $_REQUEST['number'];
        savesettings($limit, $id);
    }
    $con = config();
    if (isset($_REQUEST['add'])) {
        
            $name = mysqli_real_escape_string($con, filter_input(INPUT_POST, 'name'));
            $description = mysqli_real_escape_string($con, filter_input(INPUT_POST, 'description'));
            $price = filter_input(INPUT_POST, 'price');
            $roomcount = filter_input(INPUT_POST, 'roomcount');
            $typeid = filter_input(INPUT_POST, 'typeid');
            $typeids = filter_input(INPUT_POST, 'typeids');
            
            $housenumb = filter_input(INPUT_POST, 'housenumb');
            //-------Адрес            
            $street = mysqli_real_escape_string($con, filter_input(INPUT_POST, 'street'));
            $district = mysqli_real_escape_string($con, filter_input(INPUT_POST, 'district'));
            $settling = mysqli_real_escape_string($con, filter_input(INPUT_POST, 'settling'));
            //-------В формат "Xxxxxx"
            $street = ucfirst(strtolower(trim($street)));
            $district = ucfirst(strtolower(trim($district)));
            $settling = ucfirst(strtolower(trim($settling)));
            //Вставляем в базу если нет и получаем id 
            $street_id = insertstreet($street);
            $district_id = insertdistrict($district);
            $settling_id = insertsettling($settling, $typeids);
            //Получаем последний свободный номер, ставим продавца и получаем случайного агента
            $number = lastmaxnumb() + 1;
            $sellerid = $persinf[0]['id'];
            $agentid = selectrandagent();
            
            $r = set_object($agentid, $sellerid, $name, $price, $number, $roomcount, $typeid, $description, $housenumb, $street_id, $district_id, $settling_id);
            if ($r!==1){
                echo '<script language="javascript">alert("Произошла ошибка, проверьте данные");</script>';
            }
        
    }


    include '../templates/cabinet.tpl';
} else {
    header("Location: login.php");
}
?>