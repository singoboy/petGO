<?php session_start(); ?>
<?php require_once('Connections/conn.php'); ?>
<?php

$photo = "";

// 此變數表示使用者輸入之資料是否正確無誤，預設值為1，表示正確無誤
$validData = 1;

// ((isset($_POST["MM_insert"])) && ($_POST["MM_insert"] == "form1"))
// 可用來判斷瀏覽器是第1次對本程式發出HTTP請求，還是第2,3,4...次對
// 本程式發出HTTP請求。
//
// "MM_insert"是本表單內的一個隱藏欄位，瀏覽器是第1次對本程式發出HTTP
// 請求時(注意：此時本程式會在Server端執行)瀏覽器不會送來此欄位，但是
// 當本程式產生回應給瀏覽器時，會送回含有名為 "MM_insert" 的隱藏欄位，
// 如 <input type="hidden" name="MM_insert" value="form1" />，
// 因此當瀏覽器第2,3,4...次對本程式發出HTTP請求，就會送出有此欄位。
if ((isset ( $_POST ["MM_insert"] )) && ($_POST ["MM_insert"] == "form1")) {
	
	$path= "upload/".$_FILES['ufile']['name'];
	if($_FILES['ufile']['name'] != "")
	{
		copy($_FILES['ufile']['tmp_name'], $path);
		
	}
	
	// 表示使用者應該已經輸入了資料，接下來讀取這些輸入資料
	$name = $_POST ['name'];
	$price = $_POST ['price'];
	$imageName = $_FILES ['ufile'] ['name'];
	
	// 開始檢查輸入資料
	
	// $_FILES["uploadFile"]["error"]錯誤代號的含義：
	// http://php.net/manual/en/features.file-upload.errors.php
	// if ($_FILES["uploadFile"]["error"] > 0) { // 表示上傳資料出問題
	// $validData = 0;
	// if ($_FILES["uploadFile"]["error"] == 4) {
	// $errPicture = '您未挑選圖片檔';
	// } else {
	// $errPicture = '檔案上傳失敗,' . $_FILES["uploadFile"]["error"];
	// }
	// } else { //上傳檔案沒有問題
	// // file_get_contents():讀取圖片檔案的全部內容，然後以字串的形式傳回該內容。
	// $fileData = file_get_contents($_FILES['uploadFile']['tmp_name']);
	
	// // addslashes($fileData):將字串$fileData內的一些特殊字元
	// // (例如', ", ) ... 等 )加以編碼，以免讓資料庫管理系統(DBMS)誤判程式的
	// // 送出的 SQL命令
	// //$data = mysql_real_escape_string($fileData); // 不要用此敘述
	// //$data = addslashes($fileData);
	// // $_FILES["uploadFile"]["name"] : 圖片檔的檔名
	// $photo = $_FILES["uploadFile"]["name"];
	// }
	// 如果輸入的資料都正確
	if ($validData) {
		try {
			$insertSQL = "Insert Into product (name,price,imageName) values " . " ( ?, ?, ?) ";
			// 選擇要存取的資料庫
			$pdoStmt = $pdo->prepare ( $insertSQL );
			$pdoStmt->bindValue ( 1, $name, PDO::PARAM_STR );
			$pdoStmt->bindValue ( 2, $price, PDO::PARAM_INT );
			$pdoStmt->bindValue ( 3, $imageName, PDO::PARAM_STR );
			
			$pdoStmt->execute ();
			
			// 請MySQL執行此 $insertSQL 命命
			$result = $pdoStmt->rowCount ();
			if ($result == 1) {
				// $pdoStmt->rowCount(); 取得執行先前之SQL命令所影響的紀錄個數
				// 1: 表示新增成功(有1筆紀錄)
				// 0: 表示新增失敗(有0筆紀錄)
				$_SESSION ['Book_Message'] = '書籍新增成功';

				// header('Location: BookList.php?pageNum_Recordset1=' . . '&totalRows_Recordset1=');
			}
		} catch ( PDOException $ex ) {
			
			if (strpos ( $ex->getMessage (), 'bookNo' ) != false) {
				$errBookNo = '書號已存在'; // 此錯誤經常會出現，要單獨處理
			} else {
				// 此為存取資料庫時發生其它的錯誤，如網路未開，....
				$errDBMessage = '資料庫錯誤:' . $errDb;
			}
		}
	}
}
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Hold不住購物商</title>
<link href="../style.css" rel="stylesheet" type="text/css" />

</head>

<body onload="setFocus('title')" background="../img/bookMaintain.jpg">
	<h3 align="center">書籍維護</h3>
	<hr />
	<br />

	<br />
	<!-- 上傳檔案時<form>標籤的 enctype屬性必須是 "multipart/form-data" -->
	<form id="form1" name="form1" method="post" action="product_insert.php"
		enctype="multipart/form-data">

		<table class="table_color" width="780" border="2" align="center"
			cellpadding="2" cellspacing="2">
			<tr height='40'>
				<td colspan="4" align="center" valign="bottom"><font color='blue'
					size='+2'>新增商品資料</font></td>
			</tr>
			<tr height='36'>
				<td width="45" align="right" class="title_font">名稱</td>
				<td colspan="3"><input name="name" class='InputClass' type="text"
					id="name" value="" size="50" /><font color='red' size='-3'></font>
				</td>
			</tr>
			<tr height='36'>
				<td width="45" align="right" class="title_font">價格</td>
				<td colspan="3"><input name="price" class='InputClass' type="text"
					id="price" value="" size="50" /><font color='red' size='-3'></font>
				</td>
			</tr>
			<tr height='36'>
				<td width="45" align="right" class="title_font">圖片</td>
				<td colspan="3"><input name="ufile" type="file" id="ufile" size="50" /><font
					color='red' size='-3'> </font></td>
			</tr>
			<tr height="36">
				<td height="61" colspan="6" align="center"><font color='red'
					size='-3'></font><br /> <input type="submit" name="Submit"
					value="新增" /></td>
			</tr>
		</table>
		<div id="insert">
			<a href="BookList.php">回瀏覽書籍</a> <input type="hidden"
				name="MM_insert" value="form1" />
		</div>
	</form>
	<p>&nbsp;</p>
</body>
</html>