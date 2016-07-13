<?php

header('Content-type: application/json');
if($_POST) {
	$username   = $_POST['username'];
	$x = $_POST['x'];
	$y = $_POST['y'];
			$db_name     = 'sql7119998';
			$db_user     = 'sql7119998';
			$db_password = 'P84zkmhJYx';
			$server_url  = 'sql7.freemysqlhosting.net';

			$mysqli = new mysqli($server_url, $db_user, $db_password, $db_name);
			/* check connection */
			if (mysqli_connect_errno())
            {
				error_log("Connect failed: " . mysqli_connect_error());
				echo '{"success":0,"error_message":"' . mysqli_connect_error() . '"}';
			} else
            {
				$query = "DELETE FROM Locations WHERE username='" . $username. "'";
                                $result = $mysqli->query($query);
				
				$query = "Insert INTO Locations(username,longitude,latitude) VALUES ('" . $username . "','" . $x . "','" . $y . "')";
                                $result = $mysqli->query($query);
				echo "Inserted";
                               
                                $mysqli->close();
            }
}
    
?>