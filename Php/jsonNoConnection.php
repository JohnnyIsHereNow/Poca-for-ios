<?php

header('Content-type: application/json');
if($_POST) {
	$userID   = $_POST['userID'];
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
				$query = "Select Users.Id from Users Where Users.Id != " . $userID . "";
                                $result = $mysqli->query($query);
                                while($row = $result->fetch_array())
								{
								$rows[] = $row;
								}

								foreach($rows as $row)
								{
								echo "+" . $row['Id']  ;
								}
								echo "/";
				$query = "Select SenderId from Connections Where ReceiverId = " . $userID . "";
                                $result = $mysqli->query($query);
                                while($row = $result->fetch_array())
								{
								$rows[] = $row;
								}

								foreach($rows as $row)
								{
								echo "+" . $row['SenderId'] ;
								}
								
				$query = "Select ReceiverId from Connections Where SenderId = " . $userID . "";
                                $result = $mysqli->query($query);
                                while($row = $result->fetch_array())
								{
								$rows[] = $row;
								}

								foreach($rows as $row)
								{
								echo "+" . $row['ReceiverId'] ;
								}

                                $mysqli->close();
            }
}
    
?>
