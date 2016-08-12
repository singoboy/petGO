<?php

//step2. read from mysql
$connection = mysqli_connect("localhost","root","root","petDB");
mysqli_query($connection,"set names 'utf8'");
//mysqli_set_charset($connection,"utf8");
if ( mysqli_connect_errno()){
    die("Can't establish connection from database, ".mysqli_connect_error());
}

$query =" SELECT count(*)  as num  FROM reserve  where R_TIME = "."'".$_POST["reserveTime"]."'"; 
$result = mysqli_query($connection,$query);
if ( !$result){
    die("can't execute query ");
}
?>

<?php
    while( $row = mysqli_fetch_assoc($result)){
     $num =	$row["num"];      //$num is string
    }

    if ($num == "0"){
    	echo trim("yes");
    }
    else {
    	echo trim("no");
    }
    
    mysqli_free_result($result);
?>


<?php
mysqli_close($connection);
?>