<?php require_once('Connections/conn.php'); ?>
<?php
   $R_ID = trim($_POST['R_ID']);
   $deleteSQL = "DELETE FROM  reserve  WHERE  R_ID  =?";
   $pdoStmt = $pdo->prepare($deleteSQL);
   // 請MySQL執行此 $deleteSQL 命命
   $pdoStmt->bindvalue(1, $R_ID);
   $pdoStmt->execute();
   $result = $pdoStmt->rowCount();
   if ($result) {
      // 1: 表示刪除成功(有1筆紀錄)
      // 0: 表示刪除失敗(有0筆紀錄)
        echo "ok";
   } else {
        echo "error";
   }
?>
