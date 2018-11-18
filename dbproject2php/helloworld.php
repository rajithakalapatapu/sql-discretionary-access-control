<?php
/**
 * Created by PhpStorm.
 * User: rajitha
 * Date: 10/24/18
 * Time: 8:57 AM
 */

//print "helloworld";
//print "first php code"
?>

<?php
$servername = "localhost";
$username = "root";
$password="";
$dbname = "security_database";

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);
// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

$sql = "show tables";
$result = $conn->query($sql);

if ($result->num_rows > 0) {
    // output data of each row
    while($row = $result->fetch_assoc()) {
        print_r($row);
    }
} else {
    echo "0 results";
}
$conn->close();
?>

