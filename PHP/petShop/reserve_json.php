<?php

//step2. read from mysql
$connection = mysqli_connect("localhost","root","root","petDB");
mysqli_query($connection,"set names 'utf8'");
//mysqli_set_charset($connection,"utf8");
if ( mysqli_connect_errno()){
    die("Can't establish connection from database, ".mysqli_connect_error());
}

//$memberID =  $_POST['memberID'];
// 此處商業邏輯 讓使用者 看全部的預約時間在做挑選
$query = "select a.R_ID , a.R_TIME , a.R_MEMBER_ID , b.M_Name,b.M_Account from reserve a join member b on a.R_MEMBER_ID = b.M_ID  where  a.R_TIME > now() order by a.R_TIME  ";
$result = mysqli_query($connection,$query);
if ( !$result){
    die("can't execute query ");
}
?>

<?php
    
    $menus = array();
    
    while( $row = mysqli_fetch_assoc($result)){
    	
        $item = array();
        $item["R_ID"] = $row["R_ID"];
        $item["R_TIME"] = $row["R_TIME"];
        $item["R_MEMBER_ID"] = (int)$row["R_MEMBER_ID"];
        $item["M_Name"] = $row["M_Name"];
        $item["M_Account"] = $row["M_Account"];
 
        $menus[] = $item;
    }
    //json_encode() escaping forward slashes  
    echo json_encode($menus,JSON_UNESCAPED_SLASHES);
    mysqli_free_result($result);
?>


<?php
mysqli_close($connection);
?>