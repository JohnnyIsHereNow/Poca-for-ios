<?php

header('Content-type: application/json');
    if($_POST)
    {
        $username   = $_POST['username'];
        if($_POST['username'])
        {
			$db_name     = 'sql7119998';
			$db_user     = 'sql7119998';
			$db_password = 'P84zkmhJYx';
			$server_url  = 'sql7.freemysqlhosting.net';

			// Create connection
                           $conn = new mysqli($server_url, $db_user, $db_password, $db_name);
                        // Check connection
                        if ($conn->connect_error) 
                           {
                               die("Connection failed: " . $conn->connect_error);
                           } 

                           $sql = "SELECT Id, Username, Email, Name, Passion1, Passion2, Passion3,Birthdate FROM Users WHERE Username = '" . $username . "';" ;
                           $result = $conn->query($sql);

                           if ($result->num_rows > 0) 
                           {
                               // output data of each row
                               while($row = $result->fetch_assoc()) {
                                   echo $row["Name"]. "+" . $row["Email"]. "+" . $row["Username"]. "+" . $row["Birthdate"] . "+" . $row["Passion1"]. "+" . $row["Passion2"]. "+" . $row["Passion3"]. "+" .$row["Id"];
                               }
                           } 
                           else 
                           {
                               echo "0 results";
                           }
                  $conn->close();
       }
   }
?>