<?php

function let_login($con, $parm, $name) {
    //parm - поле по которому выбираем, тип того, что ввёл юзверь
    $sql = "SELECT p.hash FROM people p WHERE p.$parm='$name'";
    $query = mysqli_query($con, $sql);
    $r = mysqli_fetch_row($query);
    if ($r != 0) {
        return $r[0];
    } else {
        return 'end';
    }
}

function get_nameold($con, $fb, $parm) {
    //$sql = "select p.name as 'name', p.surname as 'surname' from people p where p.hash='$fb'";
    $sql = "select p.$parm from people p where p.hash='$fb'";
    echo '<br>' . $sql;
    $query = mysqli_query($con, $sql);
    $r = mysqli_fetch_row($query);
    return $r[0];
}

function is_email($email) {
    if (!preg_match('/^[A-Za-z0-9!#$%&\'*+-\/=?^_`{|}~]+@[A-Za-z0-9- ]+(\.[AZa-z0-9-]+)+[A-Za-z]$/', $email)) {
        return false;
    } else {
        return true;
    }
}

function set_hash($con) {
    for ($i = 1; $i < 101; $i++) {
        $nim = rand(1111111111, 9999999999);
        $sql = 'UPDATE realestate.people p SET p.`phonenumb`="8' . $nim . '" WHERE p.id =' . "'$i'";
        $query = mysqli_query($con, $sql);
    }

    echo mysqli_affected_rows($con);
}

function get_name($con, $fb) {
    $sql = "select * from people p where p.hash='$fb'";
    $query = mysqli_query($con, $sql);
    $rows = mysqli_fetch_assoc($query);
    return $rows;
}

?>