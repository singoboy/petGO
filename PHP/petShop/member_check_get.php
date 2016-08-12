<?php require_once('Connections/conn.php'); ?>
<?php
   $account= trim($_POST['account']);
   $password= trim($_POST['password']);
   $deleteSQL = "select * from member where M_Account =?  and M_Password =? ";
   $pdoStmt = $pdo->prepare($deleteSQL);
   // 請MySQL執行此 $deleteSQL 命命
   $pdoStmt->bindvalue(1, $account);
   $pdoStmt->bindvalue(2, $password);
   $pdoStmt->execute();
   $result = $pdoStmt->rowCount();
   if ($result == 1) {
      // 1: 表示刪除成功(有1筆紀錄)
      // 0: 表示刪除失敗(有0筆紀錄)
        echo "ok";
   } else {
        echo "error";
   }
?>
