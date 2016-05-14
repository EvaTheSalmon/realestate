<?php

function config() {
    try {
        header('Content-Type:text/html; charset=utf-8');
        $host = 'localhost';
        $user = 'root';
        $pass = 'vertrigo';
        $db = 'realestate';
        $con = mysqli_connect($host, $user, $pass, $db);
        if (!$con) {
            throw new Exception('Не удаётся подключиться к базе');
        } else {
            mysqli_query($con, "SET NAMES 'utf8'");
            return $con;
        }
        
    } catch (Exception $exc) {
        echo 'Ошибка: ', $exc->getMessage(), '\n';
        die();
    }
}

function let_login($parm, $name) {
    //-----------Открываем соединение
    $con = config();
    //parm - поле по которому выбираем, тип того, что ввёл юзверь
    $sql = "SELECT p.pass_hash FROM people p WHERE p.$parm='$name'";
    //echo $sql;
    $query = mysqli_query($con, $sql);
    $r = mysqli_fetch_row($query);
    //-----------Закрываем соединение
    if (isset($con)) {
        mysqli_close($con);
    }
    //-------------------------------
    if ($r != 0) {
        return $r[0];
    } else {
        return 'end';
    }
}

function get_nameold($fb, $parm) {
    $con = config();
    //$sql = "select p.name as 'name', p.surname as 'surname' from people p where p.pass_hash='$fb'";
    $sql = "select p.$parm from people p where p.pass_hash='$fb'";
    //echo '<br>' . $sql;
    $query = mysqli_query($con, $sql);
    $r = mysqli_fetch_row($query);
    //--------------------------------
    if (isset($con)) {
        mysqli_close($con);
    }
    //--------------------------------
    return $r[0];
}

function is_email($email) {
    if (!preg_match('/^[A-Za-z0-9!#$%&\'*+-\/=?^_`{|}~]+@[A-Za-z0-9- ]+(\.[AZa-z0-9-]+)+[A-Za-z]$/', $email)) {
        return false;
    } else {
        return true;
    }
}

function set_hash() {
    $con = config();
    for ($i = 1; $i < 107; $i++) {
        $nim = "SELECT p.email from people p WHERE p.id =" . $i;
        $sql = 'UPDATE realestate.people p SET p.`email_hash`="' . hash('sha256', $nim) . '" WHERE p.id =' . "'$i'";
        $query = mysqli_query($con, $sql);
    }
    //--------------------------------
    if (isset($con)) {
        mysqli_close($con);
    }
    //--------------------------------
    echo mysqli_affected_rows($con);
}

function get_name($fb) {
    $con = config();
    $sql = "select * from people p where p.pass_hash='$fb'";
    $query = mysqli_query($con, $sql);
    $rows = mysqli_fetch_assoc($query);

    //--------------------------------
    if (isset($con)) {
        mysqli_close($con);
    }
    //--------------------------------

    return $rows;
}

function set_man($name, $surname, $middlename, $filialid, $passport, $email, $pass_hash, $email_hash, $phonenumb) {
    $con = config();
    $sql = "INSERT IGNORE INTO people (`name`, surname, `middle-name`, `filial-id`, passport, email, pass_hash, email_hash, phonenumb) VALUES ('$name', '$surname', '$middlename', '$filialid', '$passport', '$email', '$pass_hash', '$email_hash', '$phonenumb')";
    echo $sql;
    $query = mysqli_query($con, $sql);
    //--------------------------------
    if (isset($con)) {
        mysqli_close($con);
    }
    //--------------------------------
    echo '+';
}

function select_fil() {
    $con = config();
    if (isset($_REQUEST["filialid"]))
        $name = $_REQUEST["filialid"];
    else {
        $name = '0';
    }
    $sql = "SELECT f.number from filials f";
    //echo '<br>s=' . $sql;
    $query = mysqli_query($con, $sql);
    echo "<select name='filialid'>";
    while ($r = mysqli_fetch_assoc($query)) {
        if ($r["number"] == $name)
            $s = 'selected';
        else {
            $s = '';
        }
        echo "<option value =" . $r["number"] . " $s>" . $r["number"] . "</option>";
    }
    echo '</select>';
    if (isset($con)) {
        mysqli_close($con);
    }
}

function select_id_fil($da) {
    $con = config();
    $sql = "SELECT f.id from filials f WHERE f.number='" . $da . "'";
    $query = mysqli_query($con, $sql);
    $r = mysqli_fetch_row($query);
    //--------------------------------
    if (isset($con)) {
        mysqli_close($con);
    }
    //--------------------------------
    return $r[0];
}

//function imageresize($src, $dest, $width, $height, $quality) {
//    $info = getimagesize($src);
//    $mime = $info['mime'];
//    switch ($mime) {
//        case 'image/jpeg':
//            $im = imagecreatefromjpeg($src);
//            $im1 = imagecreatetruecolor($width, $height);
//            imagecopyresampled($im1, $im, 0, 0, 0, 0, $width, $height, imagesx($im), imagesy($im));
//            imagejpeg($im1, $dest, $quality);
//            imagedestroy($im);
//            imagedestroy($im1);
//            break;
//        case 'image/png':
//            $im = imagecreatefrompng($src);
//            $im1 = imagecreatetruecolor($width, $height);
//            imagecopyresampled($im1, $im, 0, 0, 0, 0, $width, $height, imagesx($im), imagesy($im));
//            imagepng($im1, $dest, $quality);
//            imagedestroy($im);
//            imagedestroy($im1);
//            break;
//        case 'image/gif':
//            $im = imagecreatefromgif($src);
//            $im1 = imagecreatetruecolor($width, $height);
//            imagecopyresampled($im1, $im, 0, 0, 0, 0, $width, $height, imagesx($im), imagesy($im));
//            imagegif($im1, $dest, $quality);
//            imagedestroy($im);
//            imagedestroy($im1);
//            break;
//    }
//}

function get_user_emhas($hash) {
    $con = config();
    $sql = "SELECT p.`email_hash` from people p WHERE p.`pass_hash` = '" . $hash . "'";
    $query = mysqli_query($con, $sql);
    $val = mysqli_fetch_row($query);
    //--------------------------------
    if (isset($con)) {
        mysqli_close($con);
    }
    //--------------------------------
    return $val[0];
}

function islogin($info) {
    $con = config();
    if (null !== (filter_input(INPUT_COOKIE, 'log'))) {
        $info = unserialize(filter_input(INPUT_COOKIE, 'log'));
        $email = mysqli_real_escape_string($con, $info['em']);
        $pass = mysqli_real_escape_string($con, $info['pa']);
        $ip = mysqli_real_escape_string($con, $info['ip']);
        $sql = "SELECT p.email_hash from people p WHERE p.pass_hash = '" . $pass . "'";
        $query = mysqli_query($con, $sql);
        $email_ch = mysqli_fetch_row($query);
        if ($email_ch[0] == $email and $ip == hash('sha256', $_SERVER['REMOTE_ADDR'])) {
            return TRUE;
        } else {
            return FALSE;
        }
    }
    //--------------------------------
    if (isset($con)) {
        mysqli_close($con);
    }
    //--------------------------------
}

function getagentname($number) {
    $con = config();
    $sql = "SELECT p.name, p.surname, p.`filial-id` from object o JOIN people p ON o.`agent-id` = p.id WHERE o.number ='" . $number . "'";
    $query = mysqli_query($sql, $sql);
    $mass = mysqli_fetch_assoc($query);
    //--------------------------------
    if (isset($con)) {
        mysqli_close($con);
    }
    //--------------------------------
    return $mass;
}

function getownername($number) {
    $con = config();
    $sql = "SELECT p.name, p.surname from object o JOIN people p ON o.`seller-id` = p.id WHERE o.number = '" . $number . "'";
    $query = mysqli_query($sql, $sql);
    $mass = mysqli_fetch_assoc($query);
    //--------------------------------
    if (isset($con)) {
        mysqli_close($con);
    }
    //--------------------------------
    return $mass;
}

function loadgoodsinf($i) {
    $con = config();
    $sql = "SELECT * FROM object o WHERE o.number='$i'";
    $query = mysqli_query($con, $sql);
    $obj[] = mysqli_fetch_assoc($query);
    //--------------------------------
    if (isset($con)) {
        mysqli_close($con);
    }
    //--------------------------------
    return $obj[0];
}

function loadgoodsadr($i) {
    $con = config();
    $sql = "SELECT  s.name as 'street', o.house, d.name AS 'dist', s1.name AS 'city' FROM object o JOIN district d ON o.`district-id` = d.id JOIN street s ON o.`street-id` = s.id JOIN settling s1 ON o.`settling-id` = s1.id WHERE o.id = " . $i;
    $query = mysqli_query($con, $sql);
    $ad[] = mysqli_fetch_assoc($query);
    (string) $adr = $ad[0]['street'] . ' ' . $ad[0]['house'] . ' ' . $ad[0]['dist'] . ' ' . $ad[0]['city'];
    //--------------------------------
    if (isset($con)) {
        mysqli_close($con);
    }
    //--------------------------------
    return $adr;
}

function getobjectcount() {
    $con = config();
    $sql = "SELECT COUNT(*) FROM object o";
    $query = mysqli_query($con, $sql);
    $m = mysqli_fetch_row($query);
    //--------------------------------
    if (isset($con)) {
        mysqli_close($con);
    }
    //--------------------------------
    return $m[0];
}

function loadimages($number) {
    $con = config();
    try {
        $filename = '../resources/' . $number . '.jpg';
        if (!file_exists($filename)) {
            throw new Exception('noImg');
        }
    } catch (Exception $exc) {
        $filename = '../resources/domik.jpg';
    }
    //--------------------------------
    if (isset($con)) {
        mysqli_close($con);
    }
    //--------------------------------
    return $filename;
}

function loadnescojects($page, $limit) {
    $con = config();
    $sql = "SELECT * FROM object o limit " . $page * $limit . ", $limit";
    echo $sql;
    $query = mysqli_query($con, $sql);
    $mass = mysqli_fetch_assoc($query);
    //--------------------------------
    if (isset($con)) {
        mysqli_close($con);
    }
    //--------------------------------
    return $mass;
}

function getaddress($number) {
    $con = config();
    $sql = "SELECT o.house, d.name AS 'District', s.name as 'Town', s1.name AS 'Street' FROM object o JOIN district d ON o.`district-id` = d.id
JOIN settling s ON o.`settling-id` = s.id JOIN street s1 ON o.`street-id` = s1.id WHERE o.number=" . $number;
    $query = mysqli_query($con, $sql);
    $mass = mysqli_fetch_assoc($query);
    $address = 'Улица ' . $mass['Street'] . ' ' . $mass['house'] . ' ' . $mass['District'] . ' район, ' . $mass['Town'];
    //--------------------------------
    if (isset($con)) {
        mysqli_close($con);
    }
    //--------------------------------
    return $address;
}

function savesettings($limit, $id) {
    $con = config();
    $sql = "update people p SET p.`limit` = $limit WHERE p.id = $id";
    $query = mysqli_query($con, $sql);
    //--------------------------------
    if (isset($con)) {
        mysqli_close($con);
    }
    //--------------------------------
}

function issold($number) {
    $con = config();
    $sql = "SELECT o.sold from object o WHERE o.number = " . $number;
    $query = mysqli_query($con, $sql);
    $m = mysqli_fetch_row($query);
    //echo $sql;
    //--------------------------------
    if (isset($con)) {
        mysqli_close($con);
    }
    //--------------------------------
    return $m[0];
}

//function setbuy($con, $number, $id) {
//    $sql = "INSERT IGNORE INTO `bin` (`client-id`, `object-id`) VALUES ($id, $number)";
//    $query = mysqli_query($con, $sql);   
//}

function checklogin() {
    $con = config();
    if (!isset($_SESSION)) {
        session_start();
    }
    $cook = filter_input(INPUT_COOKIE, 'log');
    if (islogin($cook, $con) == true) {
        $mass = unserialize(filter_input(INPUT_COOKIE, 'log'));
        $fb = $mass['pa'];
        $_SESSION['persinf'] = get_name($con, $fb);
    }
    if (isset($_SESSION['persinf'])) {
        $persinf[] = $_SESSION['persinf'];
    }
    if (isset($persinf)) {
        return $persinf;
    } else {
        return 0;
    }
    //--------------------------------
    if (isset($con)) {
        mysqli_close($con);
    }
    //--------------------------------
}

function selectitnotsold() {
    $con = config();
    $sql = "SELECT o.number FROM object o WHERE o.sold = 0 ORDER BY o.number ASC LIMIT 1";
    $query = mysqli_query($con, $sql);
    $m = mysqli_fetch_row($query);
    //--------------------------------
    if (isset($con)) {
        mysqli_close($con);
    }
    //--------------------------------
    return $m[0];
}

?>