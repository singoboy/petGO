<?php require_once('Connections/conn.php'); ?>
<?php
   $account= trim($_POST['account']);
   $deleteSQL = "select * from member where M_Account =?";
   $pdoStmt = $pdo->prepare($deleteSQL);
   // 請MySQL執行此 $deleteSQL 命命
   $pdoStmt->bindvalue(1, $account);
   $pdoStmt->execute();
   $result = $pdoStmt->rowCount();
   if ($result == 0) {
      // 1: 表示刪除成功(有1筆紀錄)
      // 0: 表示刪除失敗(有0筆紀錄)
        echo "ok";
   } else {
        echo "error";
   }
?>
