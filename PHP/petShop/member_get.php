<?php

//step2. read from mysql
$connection = mysqli_connect("localhost","root","root","petDB");
mysqli_query($connection,"set names 'utf8'");
//mysqli_set_charset($connection,"utf8");
if ( mysqli_connect_errno()){
    die("Can't establish connection from database, ".mysqli_connect_error());
}

   $account = trim($_POST['account']);
   $password = trim($_POST['password']);

$query = "select * from member  where  M_Account = '$account'   and M_Password =  '$password' "; 
 // query 字串要加引號
$result = mysqli_query($connection,$query);
if ( !$result){
    die("can't execute query ");
}
?>

 <?php
    
    $menus = array();
    
    while( $row = mysqli_fetch_assoc($result)){
        
        $item = array();
        $item["memberID"] = (int)$row["M_ID"];
        $item["memberAccount"] = (String)$row["M_Account"];
        $item["memberName"] = (String)$row["M_Name"];
        $item["memberAddr"] = (String)$row["M_Addr"];
 
        $menus[] = $item;
    }
    //json_encode() escaping forward slashes  
    echo json_encode($menus,JSON_UNESCAPED_SLASHES);
    mysqli_free_result($result);
?>


<?php
mysqli_close($connection);
?>