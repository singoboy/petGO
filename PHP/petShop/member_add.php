<?php session_start(); ?>
<?php require_once('Connections/conn.php'); ?>
<?php

$account = trim($_POST['account']);   // find error with $account = trim($_POST['account]');
$password = trim($_POST['password']);
$name = trim($_POST['name']);
$address = trim($_POST['address']);

try {
	// 啟動交易
	$pdo->beginTransaction ();
	// 寫入訂單主檔
	$insertSQL = "INSERT INTO member ( M_Account , M_Password, M_Name, M_Addr) VALUES " . "( ? , ?, ? ,? )";
	$pdoStmt = $pdo->prepare ( $insertSQL );
	$pdoStmt->bindValue ( 1, $account , PDO::PARAM_STR );
	$pdoStmt->bindValue ( 2, $password, PDO::PARAM_STR );
	$pdoStmt->bindValue ( 3, $name, PDO::PARAM_STR );
	$pdoStmt->bindValue ( 4, $address, PDO::PARAM_STR );

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