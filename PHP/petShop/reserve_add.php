<?php session_start(); ?>
<?php require_once('Connections/conn.php'); ?>
<?php

$reserveTime = trim($_POST['reserveTime']);
$memberID =  trim($_POST['memberID']);

try {
	// 啟動交易
	$pdo->beginTransaction ();
	// 寫入訂單主檔
	$insertSQL = "INSERT INTO reserve( R_TIME, R_MEMBER_ID) VALUES " . "( ?, ?)";
	$pdoStmt = $pdo->prepare ( $insertSQL );
	$pdoStmt->bindValue ( 1, $reserveTime, PDO::PARAM_STR );
	$pdoStmt->bindValue ( 2, $memberID, PDO::PARAM_INT );

	$pdoStmt->execute ();
	$num = $pdoStmt->rowCount ();

	$pdo->commit ();
	echo "ok";
	
} catch ( PDOException $ex ) {
	/* write log here */
// 	echo "存取資料庫疵發生錯誤，訊息:" . $ex->getMessage () . "<br>";
// 	echo "行號:" . $ex->getLine () . "<br>";
	$pdo->rollback ();
	echo "error";
}
?>