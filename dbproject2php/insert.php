<?php
//$myfile = fopen("userrole.txt", "r") or die("Unable to open file!");
//echo fgets($myfile);
//fclose($myfile);

$servername = "localhost";
$username = "root";
$password = "";
$dbname = "security_database";

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);
// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

$handle = fopen("granting1", "r");
if ($handle) {
    while (($line = fgets($handle)) !== false) {
        $sql = $line;
        echo "Going to run query '" . $sql . "'" . "<br>";
        if (empty(trim($sql))) {
            echo "Skipping empty sql string" . "<br>";
            continue;
        }
        $result = $conn->query($sql);

        if ($result === true) {
            // output data of each row
            echo "New Record created successfully" . "<br>";
        } else {
            echo "Error:'" . $sql . "'<br>" . $conn->error . "<br>";
        }
    }

    fclose($handle);
} else {
    echo "error opening the file.";
}

$conn->close();

?>


