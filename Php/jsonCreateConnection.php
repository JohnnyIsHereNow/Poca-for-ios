<?php

header('Content-type: application/json');
if($_POST) {
	$myId   = $_POST['myId'];
	$hisId   = $_POST['hisId'];
 
			$db_name     = 'sql7119998';
			$db_user     = 'sql7119998';
			$db_password = 'P84zkmhJYx';
			$server_url  = 'sql7.freemysqlhosting.net';

			$mysqli = new mysqli($server_url, $db_user, $db_password, $db_name);

			/* check connection */
			if (mysqli_connect_errno()) {
				error_log("Connect failed: " . mysqli_connect_error());
				echo '{"success":0,"error_message":"' . mysqli_connect_error() . '"}';
			} else {
				if ($stmt = $mysqli->prepare("INSERT INTO Connections (SenderId,ReceiverId,Accepted) VALUES (" . $myId . "," . $hisId . ",0)"))
				 {
					/* execute query */
					$stmt->execute();

					/* bind result variables */
					//$stmt->bind_result($id);

					/* fetch value */
					$stmt->fetch();

					/* close statement */
					$stmt->close();
				}

				/* close connection */
				$mysqli->close();

					echo '{"success":1}'; 
			}
	} else {
		echo '{"success":0,"error_message":"Failed2"}';
	}
?>