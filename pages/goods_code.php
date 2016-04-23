<?php

function loadgoodsinf($con, $i) {
    $sql = "SELECT * FROM object o WHERE o.id='$i'";        
    $query = mysqli_query($con, $sql);        
    $obj[] = mysqli_fetch_assoc($query);    
    return $obj[0];
}
function loadgoodsadr($con, $i){
    $sql = "SELECT  s.name as 'street', o.house, d.name AS 'dist', s1.name AS 'city' FROM object o JOIN district d ON o.`district-id` = d.id JOIN street s ON o.`street-id` = s.id JOIN settling s1 ON o.`settling-id` = s1.id WHERE o.id = ".$i;
    $query = mysqli_query($con, $sql);
    $ad[] = mysqli_fetch_assoc($query);
    (string)$adr = $ad[0]['street'].' '.$ad[0]['house'].' '.$ad[0]['dist'].' '.$ad[0]['city'];    
    return $adr;
}

if (isset($_REQUEST['next'])){
    $i = $i+1;
}
if (isset($_REQUEST['back'])){
    $i = $i-4;
}
function itemcount ($con){
    $sql = "SELECT COUNT(*) FROM object o";
    $query = mysqli_query($con, $sql); 
    $m = mysqli_fetch_row($query);
    return $m[0];
}
?>
