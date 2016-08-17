<?php

//step2. read from mysql
$connection = mysqli_connect("localhost","root","root","petDB");
mysqli_query($connection,"set names 'utf8'");
//mysqli_set_charset($connection,"utf8");
if ( mysqli_connect_errno()){
    die("Can't establish connection from database, ".mysqli_connect_error());
}

$query = "select * from product ";
$result = mysqli_query($connection,$query);
if ( !$result){
    die("can't execute query ");
}
?>

<?php
    
    $menus = array();
    
    while( $row = mysqli_fetch_assoc($result)){
        
        $item = array();
        $item["productID"] = (int)$row["productID"];
        $item["name"] = $row["name"];
        $item["price"] = (int)$row["price"];
        $item["imageName"] = $row["imageName"];
        $item["imageUrl"] = "http://10.0.2.2:8888/petShop/upload/".(String)$row["imageName"];
 
        $menus[] = $item;
    }
    //json_encode() escaping forward slashes  
    echo json_encode($menus,JSON_UNESCAPED_SLASHES);
    mysqli_free_result($result);
?>


<?php
mysqli_close($connection);
?>