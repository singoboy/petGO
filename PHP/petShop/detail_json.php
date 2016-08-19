<?php

//step2. read from mysql
$connection = mysqli_connect("localhost","root","root","petDB");
mysqli_query($connection,"set names 'utf8'");
//mysqli_set_charset($connection,"utf8");
if ( mysqli_connect_errno()){
    die("Can't establish connection from database, ".mysqli_connect_error());
}

$orderID= trim($_POST['orderID']);

$query = "select * from detail  where D_OrderID = '$orderID'";
$result = mysqli_query($connection,$query);
if ( !$result){
    die("can't execute query ");
}
?>

<?php
    
    $menus = array();
    
    while( $row = mysqli_fetch_assoc($result)){
        
        $item = array();

        $item["name"] = $row["D_PName"];
        $item["price"] = $row["D_PPrice"];
        $item["number"] = $row["D_PQuantity"];
        $item["itemTotal"] = $row["D_ItemTotal"];

 
        $menus[] = $item;
    }
    //json_encode() escaping forward slashes  
    echo json_encode($menus,JSON_UNESCAPED_SLASHES);
    mysqli_free_result($result);
?>


<?php
mysqli_close($connection);
?>