<?php

//step2. read from mysql
$connection = mysqli_connect("localhost","root","root","petDB");
mysqli_query($connection,"set names 'utf8'");
//mysqli_set_charset($connection,"utf8");
if ( mysqli_connect_errno()){
    die("Can't establish connection from database, ".mysqli_connect_error());
}

$memberID =  $_POST['memberID'];

$query = "select * from reserve  where R_TIME > now()  ";
$result = mysqli_query($connection,$query);
if ( !$result){
    die("can't execute query ");
}
?>

<?php
    
    $menus = array();
    
    while( $row = mysqli_fetch_assoc($result)){
        
        $item = array();
        $item["R_ID"] = (int)$row["R_ID"];
        $item["R_TIME"] = $row["R_TIME"];
        $item["R_MEMBER_ID"] = (int)$row["R_MEMBER_ID"];
        $item["GET_MEMBER_ID"] = $memberID;
 
        $menus[] = $item;
    }
    //json_encode() escaping forward slashes  
    echo json_encode($menus,JSON_UNESCAPED_SLASHES);
    mysqli_free_result($result);
?>


<?php
mysqli_close($connection);
?>