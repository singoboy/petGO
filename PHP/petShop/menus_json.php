<?php

//step2. read from mysql
$connection = mysqli_connect("localhost","menuuser","pass","menu_db");
mysqli_query($connection,"set names 'utf8'");
//mysqli_set_charset($connection,"utf8");
if ( mysqli_connect_errno()){
    die("Can't establish connection from database, ".mysqli_connect_error());
}

$query = "select * from menu ";
$result = mysqli_query($connection,$query);
if ( !$result){
    die("can't execute query ");
}
?>

<?php
    
    $menus = array();
    
    while( $row = mysqli_fetch_assoc($result)){
        
        $item = array();
        $item["name"] = $row["name"];
        $item["price"] = (int)$row["price"];
        
        $menus[] = $item;
    }
    echo json_encode($menus);
    mysqli_free_result($result);
?>


<?php
mysqli_close($connection);
?>