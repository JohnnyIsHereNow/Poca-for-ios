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
				$query = "Select ReceiverId from Connections Where SenderId = " . $userID .  " AND Accepted = 1 ";
                                $result = $mysqli->query($query);
				echo "+" . "";
                                while($row = $result->fetch_array())
								{
								$rows[] = $row;
								}
							if ( sizeof($rows) > 0 ) 
								{
								foreach($rows as $row)
								{
								echo "+" . $row['ReceiverId']  ;
								}
								}
				$query = "Select SenderId from Connections Where ReceiverId = " . $userID  . " AND Accepted = 1 ";
                                $result = $mysqli->query($query);
                                while($row = $result->fetch_array())
								{
								$rows[] = $row;
								}
							if ( sizeof($rows) > 0 ) 
								{
								foreach($rows as $row)
								{
								echo "+" . $row['SenderId'] ;
								}
								}

                                $mysqli->close();
            }
}
    
?>