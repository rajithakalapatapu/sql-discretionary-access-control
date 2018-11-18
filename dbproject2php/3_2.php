<?php

$role_name_to_insert = "";
$description_to_insert = "";
$link_user_account = 0;
session_start();

if (isset($_POST['submit']) && (
        ($_POST['role_name']) != "" &&
        ($_POST['description']) != "") ) {

    $_SESSION['role_name'] = $_POST['role_name'];
    $_SESSION['description'] = $_POST['description'];
    $_SESSION['link_account']  = $_POST['link_account'];
    
    header("Location: " . $_SERVER['REQUEST_URI']);
    exit;
} else {
    $role_name_to_insert = isset($_SESSION['role_name']) ? $_SESSION['role_name'] : '';
    $description_to_insert = isset($_SESSION['description']) ? $_SESSION['description'] : '';
    $link_user_account = isset($_SESSION['link_account']) ? $_SESSION['link_account'] : 0;

    unset($_SESSION['role_name']);
    unset($_SESSION['description']);
    unset($_SESSION['$link_user_account']);
}

?>

<!DOCTYPE html >
<head xmlns="http://www.w3.org/1999/html">
    <title>DB Project 2</title>
</head>
<body>
<?php
if ($role_name_to_insert != "") {
    echo "Creating role... " . $role_name_to_insert . "\n";

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

    $user_role_id_to_insert = 0;
    $sql = "select max(role_id) from user_role";
    $result = $conn->query($sql);

    while ($row = $result->fetch_assoc()) {

        $user_role_id_to_insert = intval($row['max(role_id)']) + 100;
    }

    $insert = " insert into user_role values (%d, '%s', '%s', %d)";
    $sql = sprintf($insert,
        $user_role_id_to_insert,
        $role_name_to_insert, $description_to_insert,
        $link_user_account);

    echo "Going to run '" . $sql . "'\n";

    $result = $conn->query($sql);

    if ($result === true) {
        // output data of each row
        echo "New Record created successfully" . "<br>";
        echo "User role created! ";
    } else {
        echo "Error:'" . $sql . "'<br>" . $conn->error . "<br>";
    }

    $conn->close();
} else {
    ?>

    <h2> Enter details for a new user role </h2>
    <form method="post">

        <label for="role_name">Role Name:</label>
        <input id="role_name" type="text" name="role_name"/>
        <br>
        <label for="description">Description:</label>
        <input id="description" type="text" name="description"/>
        <br>

        <label for="link_user_account">Which user account to link to?</label>
        <select id="link_user_account" name="link_account">
        <?php

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

        $result = $conn->query("select user_account_id, fname from user_account");

        while ($row = $result->fetch_assoc()) {
            echo "<option value=\"" . $row['user_account_id'] . "\">" .  $row['fname'] . "</option> <br>";
        }

        ?>
        </select>
        <input type="submit" name="submit" value="Go"/>
    </form>

<?php } ?>

</body>
</html>