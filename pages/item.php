<?php
    $number=$_GET['numb'];
    $sql = "SELECT * FROM object o where o.number =".$number;
    $query = mysqli_query($con, $sql);
    $inf =  mysqli_fetch_assoc($query);
    $title = $mass['title'];
    $cost = $mass['cost'];
    $date = $mass['offer-date'];
?>