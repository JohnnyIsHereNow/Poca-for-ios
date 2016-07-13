<?php

header('Content-type: application/json');
if($_POST) {
    $realname   = $_POST['realname'];
    $email   = $_POST['email'];
	$username   = $_POST['username'];
	$password   = $_POST['password'];
    $repassword   = $_POST['repassword'];
	$birthdate   = $_POST['birthdate'];
    $passion1   = $_POST['passion1'];
    $passion2   = $_POST['passion2'];
    $passion3   = $_POST['passion3'];
    $isAdvisor =$_POST['isAdvisor'];

	if($_POST['username']) {
		if ( $password == $repassword ) {

			$db_name     = 'sql7119998';
			$db_user     = 'sql7119998';
			$db_password = 'P84zkmhJYx';
			$server_url  = 'sql7.freemysqlhosting.net';

            $mysqli = new mysqli($server_url, $db_user, $db_password, $db_name);

			/* check connection */
			if (mysqli_connect_errno()) {
				error_log("Connect failed: " . mysqli_connect_error());
				echo '{"success":0,"error_message":"Errasd' . mysqli_connect_error() . '"}';
			} else {
				$stmt = $mysqli->prepare("INSERT INTO Users (Username, Password, Email, Name, Passion1, Passion2, Passion3,Birthdate,isAdvisor) VALUES ('" .$username ."','" . $password . "','" . $email . "','". $realname . "',". $passion1 . ",". $passion2 . ",". $passion3 . ",'" . $birthdate . "',". $isAdvisor . ")");
                    /*$password = md5($password);*/
                   // $stmt->bind_param('ss', $username, $password, $email, $realname, $passion1, $passion2, $passion3, $isAdvisor);

				/* execute prepared statement */
				$stmt->execute();

				if ($stmt->error) {error_log("Error: " . $stmt->error); }

				$success = $stmt->affected_rows;

				/* close statement and connection */
				$stmt->close();

				/* close connection */
				$mysqli->close();
				error_log("Success: $success");

				if ($success > 0) {
					error_log("User '$username' created.");
					echo '{"success":1}';
				} else {
					echo '{"success":0,"error_message":"Username Exist."}';
				}
			}
		} else {
			echo '{"success":0,"error_message":"Passwords does not match."}';
		}
	} else {
		echo '{"success":0,"error_message":"Invalid Username."}';
	}
}else {
	echo '{"success":0,"error_message":"Invalid Data."}';
}
?>
