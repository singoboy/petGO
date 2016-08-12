<?php session_start(); ?>
<?php require_once('Connections/conn.php'); ?>
<?php
$now = date("Y/m/d H:i:s");
$total = trim($_POST['total']);
$memberID = trim($_POST['memberID']);
// 確定訂單編號
while ( true ) {
	$OrderID = date ( "YmdHis" ) . substr ( md5 ( uniqid ( rand () ) ), 0, 5 );
	$selectSQL = "SELECT count(*) FROM orders WHERE  O_OrderID = '$OrderID' ";
	$pdoStmt = $pdo->prepare ( $selectSQL );
	$pdoStmt->execute ();
	$num = $pdoStmt->fetchColumn ();
	if ($num == 0) {
		break;
	}
}
try {
	// 啟動交易
	$pdo->beginTransaction ();
	// 寫入訂單主檔
	$insertSQL = "INSERT INTO orders (O_OrderID, O_Date	, O_Total, O_MemberID) VALUES " . "(?, ?, ?, ?)";
	$pdoStmt = $pdo->prepare ( $insertSQL );
	$pdoStmt->bindValue ( 1, $OrderID, PDO::PARAM_STR );
	$pdoStmt->bindValue ( 2, $now, PDO::PARAM_STR );
	$pdoStmt->bindValue ( 3, $total, PDO::PARAM_INT );
	$pdoStmt->bindValue ( 4, $memberID, PDO::PARAM_INT );;
	$pdoStmt->execute ();
	$num = $pdoStmt->rowCount ();

	$pdo->commit ();
	echo $OrderID;

} catch ( PDOException $ex ) {
	/* write log here */
// 	echo "存取資料庫疵發生錯誤，訊息:" . $ex->getMessage () . "<br>";
// 	echo "行號:" . $ex->getLine () . "<br>";
	$pdo->rollback ();
	echo "error";
}
?>