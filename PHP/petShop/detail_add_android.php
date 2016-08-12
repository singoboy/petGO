<?php require_once('Connections/conn.php'); ?>
<?php

$orderID = $_POST["orderID"];
$D_PNo 	 = $_POST["productID"];
$D_PName = $_POST["name"];
$D_PPrice = $_POST["price"];
$D_PQuantity = $_POST["quantity"];
$D_PitemTotal = $_POST["itemTotal"] ;
try {
	// 啟動交易
	$pdo->beginTransaction ();
	// 寫入訂單明細檔	
		$insertSQL = "INSERT INTO detail (D_OrderID, D_ProductID, D_PName, D_PPrice, D_PQuantity, D_ItemTotal) VALUES  " . "(?, ?, ?, ?, ?, ?) ";
		$pdoStmt = $pdo->prepare ( $insertSQL );
		$pdoStmt->bindValue ( 1, $orderID, PDO::PARAM_STR );
		$pdoStmt->bindValue ( 2, $D_PNo, PDO::PARAM_STR );
		$pdoStmt->bindValue ( 3, $D_PName, PDO::PARAM_STR );
		$pdoStmt->bindValue ( 4, $D_PPrice, PDO::PARAM_INT );
		$pdoStmt->bindValue ( 5, $D_PQuantity, PDO::PARAM_INT );
		$pdoStmt->bindValue ( 6, $D_PitemTotal, PDO::PARAM_INT );	
		$pdoStmt->execute ();
		$num = $pdoStmt->rowCount ();
	$pdo->commit ();
} catch ( PDOException $ex ) {
	$pdo->rollback ();
	echo "error";
}

?>