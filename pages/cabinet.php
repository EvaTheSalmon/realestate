<?php
session_start();
$persinf[] = $_SESSION['persinf'];
if (isset($persinf[0]['name'])){
    $name = $persinf[0]['name'];
    $surname = $persinf[0]['surname'];
    
     
    
} else {
    header("Location: ./login_page.php");
}
?>


