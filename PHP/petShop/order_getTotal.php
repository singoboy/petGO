<?php

//step2. read from mysql
$connection = mysqli_connect("localhost","root","root","petDB");
mysqli_query($connection,"set names 'utf8'");
//mysqli_set_charset($connection,"utf8");
if ( mysqli_connect_errno()){
    die("Can't establish connection from database, ".mysqli_connect_error());
}
$memberID = trim($_POST['memberID']);
$query = " SELECT sum(O_Total) as total FROM orders  where O_MemberID  = $memberID  ";
$result = mysqli_query($connection,$query);
if ( !$result){
    die("can't execute query ");
}
?>

<?php

    $row = mysqli_fetch_assoc($result) ;
       if ($row["total"] == null){
       	echo 0;
       }
       else{ 	
       echo $row["total"];
       }
    mysqli_free_result($result);
?>


<?php
mysqli_close($connection);
?>