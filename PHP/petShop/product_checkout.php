<?php require_once('Connections/conn.php'); ?>
<?php

//step2. read from mysql

//echo $_POST["name"];
//echo $_POST["price"];

$connection = mysqli_connect("localhost","root","root","menu_db");
mysqli_query($connection,"set names 'utf8'");
//mysqli_set_charset($connection,"utf8");
if ( mysqli_connect_errno()){
    die("Can't establish connection from database, ".mysqli_connect_error());
}

// 確定訂單編號
while (true){
	$OrderID = date("YmdHis") . substr(md5(uniqid(rand())), 0, 5);
	$selectSQL = "SELECT count(*) FROM Orders WHERE  O_OrderID = '$OrderID' " ;
	$pdoStmt = $pdo->prepare($selectSQL);
	$pdoStmt->execute();
	$num = $pdoStmt->fetchColumn();
	if ($num == 0){
		break;
	}
}
   $now = date("Y/m/d H:i:s");
   $total = trim($_POST['O_Total']);

try {
	// 啟動交易
	$pdo->beginTransaction();
	// 寫入訂單主檔
	$insertSQL = "INSERT INTO orders (O_OrderID,O_Date, O_Total) VALUES " .
			"(?, ?, ?)" ;
	$pdoStmt = $pdo->prepare($insertSQL);
	$pdoStmt->bindValue(1, $OrderID, PDO::PARAM_STR);
	$pdoStmt->bindValue(2, $now, PDO::PARAM_STR);
	$pdoStmt->bindValue(3, $total, PDO::PARAM_INT);

	$pdoStmt->execute();
	$num = $pdoStmt->rowCount();
	// 寫入訂單明細檔
	$productString =  $_POST['productList'] ;
	$productArray = explode(",",$productString);
	
foreach ($productArray as $value) {
	$query = "select * from product where productID = " . $value ;
	$result = mysqli_query($connection,$query);
	
	
}

	
	// 寫入訂單明細檔
// 	foreach($_SESSION['Cart'] as $i => $val){
// 		$D_PNo 			= $_SESSION['Cart'][$i];
// 		$D_PName		= $_SESSION['Name'][$i];
// 		$D_PPrice		= $_SESSION['Price'][$i];
// 		$D_PQuantity	= $_SESSION['Quantity'][$i];
// 		$D_PitemTotal	= $_SESSION['itemTotal'][$i];

// 		$insertSQL = "INSERT INTO detail (D_OrderID, D_PNo, D_PName, D_PPrice, D_PQuantity, D_ItemTotal) VALUES  " .
// 				"(?, ?, ?, ?, ?, ?) ";
// 		$pdoStmt = $pdo->prepare($insertSQL);
// 		$pdoStmt->bindValue(1, $OrderID, PDO::PARAM_STR);
// 		$pdoStmt->bindValue(2, $D_PNo, PDO::PARAM_STR);
// 		$pdoStmt->bindValue(3, $D_PName, PDO::PARAM_STR);
// 		$pdoStmt->bindValue(4, $D_PPrice, PDO::PARAM_STR);
// 		$pdoStmt->bindValue(5, $D_PQuantity, PDO::PARAM_STR);
// 		$pdoStmt->bindValue(6, $D_PitemTotal, PDO::PARAM_INT);
			
// 		$pdoStmt->execute();
// 		$num = $pdoStmt->rowCount();
// 	}
	$pdo->commit();

} catch(PDOException $ex){
	echo "存取資料庫疵發生錯誤，訊息:" . $ex->getMessage() . "<br>";
	echo "行號:" . $ex->getLine() . "<br>";
	$pdo->rollback();
}




// $stmt = $connection->prepare("insert into menu (name,price) values (?,?)");
//     //可以先用$_GET測試
// $stmt->bind_param('sd', $_POST["name"] , $_POST["price"]); //first parameter, s :string d:integer
// $stmt->execute();
// $stmt->close();

// mysqli_close($connection);
// echo json_encode(array("status"=>"ok"));


echo $_POST['O_Total'] ;

?>

