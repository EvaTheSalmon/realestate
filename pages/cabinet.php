<?php

include_once './functions.php';

$persinf = checklogin();

switch ($persinf) {
    case $persinf !== '':
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
        print_r($persinf);
        include '../templates/cabinet.tpl';
        
        break;
    default:
        header("Location: login.php");
}
?>