<?php include 'secdb.php' ?>
<?php

$ap_name_to_insert = "";
$link_account = 0;
$link_role = 0;
session_start();

if (isset($_POST['submit']) ) {

    $_SESSION['acpriv_name'] = $_POST['acpriv_name'];
    $_SESSION['link_account']  = $_POST['link_account'];
    $_SESSION['link_role']  = $_POST['link_role'];

    header("Location: " . $_SERVER['REQUEST_URI']);
    exit;
} else {
    $ap_name_to_insert = isset($_SESSION['acpriv_name']) ? $_SESSION['acpriv_name'] : '';
    $link_account = isset($_SESSION['link_account']) ? $_SESSION['link_account'] : '';
    $link_role = isset($_SESSION['link_role']) ? $_SESSION['link_role'] : 0;

    unset($_SESSION['acpriv_name']);
    unset($_SESSION['link_account']);
    unset($_SESSION['link_role']);
}

?>

<!DOCTYPE html >
<head xmlns="http://www.w3.org/1999/html">
    <title>DB Project 2</title>
</head>
<body>
<?php
if ($ap_name_to_insert != "") {
    echo "Creating account privilege... " . $ap_name_to_insert . "\n";

    $conn = get_db_connection();

    $insert = " insert into security_database.account_privilege values ('%s', %d, %d)";
    $sql = sprintf($insert,
        $ap_name_to_insert,
        $link_account, $link_role);

    echo "Going to run '" . $sql . "'\n";

    $result = $conn->query($sql);

    if ($result === true) {
        // output data of each row
        echo "New Record created successfully" . "<br>";
        echo "Account privilege created! ";
    } else {
        echo "Error:'" . $sql . "'<br>" . $conn->error . "<br>";
    }

    $conn->close();
} else {
    ?>

    <h2> Enter details for a new account privilege </h2>
    <form method="post">

        <label for="acpriv_name">Account Privilege Name:</label>
        <input id="acpriv_name" type="text" name="acpriv_name"/>
        <br/>

        <label for="link_user_account">Which user account to link to?</label>
        <select id="link_user_account" name="link_account">
            <?php

            $names_ids = get_user_names_ids(get_db_connection());

            foreach($names_ids as $key => $value) {
                echo "<option value=\"" . $key . "\">" .  $value . "</option> <br>";
            }

            ?>
        </select>
        <br/>

        <label for="link_user_role">Which user role to link to?</label>
        <select id="link_user_role" name="link_role">
            <?php

            $role_ids = get_user_roles(get_db_connection());

            foreach($role_ids as $key => $value) {
                echo "<option value=\"" . $key . "\">" .  $value . "</option> <br>";
            }

            ?>
        </select>
        <br/>

        <input type="submit" name="submit" value="Go"/>
    </form>

<?php } ?>

</body>
</html>