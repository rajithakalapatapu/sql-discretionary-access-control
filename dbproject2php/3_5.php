<?php include 'secdb.php' ?>
<?php

$link_account = 0;
$link_role = 0;
$link_rel_priv = 0;session_start();

if (isset($_POST['submit'])) {
   $_SESSION['link_account']  = $_POST['link_account'];
    $_SESSION['link_role']  = $_POST['link_role'];

    header("Location: " . $_SERVER['REQUEST_URI']);
    exit;
} else {
    $link_account = isset($_SESSION['link_account']) ? $_SESSION['link_account'] : '';
    $link_role = isset($_SESSION['link_role']) ? $_SESSION['link_role'] : 0;

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
if ($link_account != 0) {
    echo "Linking user account " . $link_account . " to user role \n" . $link_role;

    $conn = get_db_connection();

    $insert = " insert into security_database.assigned_with values (%d, %d)";
    $sql = sprintf($insert, $link_role, $link_account);
    echo "Going to run '" . $sql . "'\n";

    $result = $conn->query($sql);

    if ($result === true) {
        // output data of each row
        echo "New Record created successfully" . "<br>";
        echo "Table created! ";
    } else {
        echo "The user with id " . $link_role . " has a conflict while linking to user role with id " . $link_role . "\n";
        echo "Error:'" . $sql . "'<br>" . $conn->error . "<br>";
    }

    $conn->close();
} else {
    ?>

    <h2> Link user account to a role </h2>
    <form method="post">

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