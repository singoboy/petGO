<?php

//step2. read from mysql

//echo $_POST["name"];
//echo $_POST["price"];

$connection = mysqli_connect("localhost","menuuser","pass","menu_db");
mysqli_query($connection,"set names 'utf8'");
//mysqli_set_charset($connection,"utf8");
if ( mysqli_connect_errno()){
    die("Can't establish connection from database, ".mysqli_connect_error());
}
$stmt = $connection->prepare("insert into menu (name,price) values (?,?)");
    //可以先用$_GET測試
$stmt->bind_param('sd', $_POST["name"] , $_POST["price"]); //first parameter, s :string d:integer
$stmt->execute();
$stmt->close();

mysqli_close($connection);
echo json_encode(array("status"=>"ok"));

?>

