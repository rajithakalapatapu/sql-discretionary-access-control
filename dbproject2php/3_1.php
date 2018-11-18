<?php

$fname_to_insert = "";
$lname_to_insert = "";
$area_code_to_insert = "";
$state_code_to_insert = "";
$number_to_insert = "";
session_start();

if (isset($_POST['submit']) && (
        ($_POST['fname']) != "" &&
        ($_POST['lname']) != "" &&
        ($_POST['area_code']) != "" &&
        ($_POST['state_code']) != "" &&
        ($_POST['number']) != "")) {

    $_SESSION['fname'] = $_POST['fname'];
    $_SESSION['lname'] = $_POST['lname'];
    $_SESSION['area_code'] = $_POST['area_code'];
    $_SESSION['state_code'] = $_POST['state_code'];
    $_SESSION['number'] = $_POST['number'];

    header("Location: " . $_SERVER['REQUEST_URI']);
    exit;
} else {
    $fname_to_insert = isset($_SESSION['fname']) ? $_SESSION['fname'] : '';
    $lname_to_insert = isset($_SESSION['lname']) ? $_SESSION['lname'] : '';
    $area_code_to_insert = isset($_SESSION['area_code']) ? $_SESSION['area_code'] : '';
    $state_code_to_insert = isset($_SESSION['state_code']) ? $_SESSION['state_code'] : '';
    $number_to_insert = isset($_SESSION['number']) ? $_SESSION['number'] : '';

    unset($_SESSION['fname']);
    unset($_SESSION['lname']);
    unset($_SESSION['area_code']);
    unset($_SESSION['state_code']);
    unset($_SESSION['number']);
}

?>

<!DOCTYPE html >
<head xmlns="http://www.w3.org/1999/html">
    <title>DB Project 2</title>
</head>
<body>
<?php
if ($fname_to_insert != "") {
    echo "Welcome " . $fname_to_insert . "<br/>";
    echo "Creating your account... \n";

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

    $user_account_id_to_insert = 0;
    $sql = "select max(user_account_id) from user_account";
    $result = $conn->query($sql);
    while ($row = $result->fetch_assoc()) {
        $user_account_id_to_insert = intval($row['max(user_account_id)']) + 1;
    }

    $insert = " insert into user_account values (%d, '%s', '%s', %d, %d, %d)";
    $sql = sprintf($insert,
        $user_account_id_to_insert,
        $fname_to_insert, $lname_to_insert,
        $area_code_to_insert, $state_code_to_insert, $number_to_insert);

    echo "Going to run '" . $sql . "'\n";


    $result = $conn->query($sql);

    if ($result === true) {
        // output data of each row
        echo "New Record created successfully" . "<br>";
        echo "Account created! ";
    } else {
        echo "Error:'" . $sql . "'<br>" . $conn->error . "<br>";
    }

    $conn->close();
} else {
    ?>

    <h2> Enter details for a new user account </h2>
    <form method="post">
        <label for="fname">FirstName:</label>
        <input id="fname" type="text" name="fname"/>
        <br>
        <label for="lname">LastName:</label>
        <input id="lname" type="text" name="lname"/>
        <br>
        <label for="area_code">Area_Code:</label>
        <input id="area_code" type="text" name="area_code"/>
        <br>
        <label for="state_code">State_Code:</label>
        <input id="state_code" type="text" name="state_code"/>
        <br>
        <label for="number">Number:</label>
        <input id="number" type="text" name="number"/>
        <br>
        <input type="submit" name="submit" value="Go"/>
    </form>

<?php } ?>

</body>
</html>