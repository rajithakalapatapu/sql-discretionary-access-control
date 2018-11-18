<?php include 'secdb.php' ?>
<?php

$table_name_to_insert = "";
$link_account = 0;
$link_role = 0;
$link_rel_priv = 0;
session_start();

if (isset($_POST['submit']) && (
        ($_POST['table_name']) != "") ) {

    $_SESSION['table_name'] = $_POST['table_name'];
    $_SESSION['link_account']  = $_POST['link_account'];
    $_SESSION['link_role']  = $_POST['link_role'];
    $_SESSION['link_rel']  = $_POST['link_rel'];


    header("Location: " . $_SERVER['REQUEST_URI']);
    exit;
} else {
    $table_name_to_insert = isset($_SESSION['table_name']) ? $_SESSION['table_name'] : '';
    $link_account = isset($_SESSION['link_account']) ? $_SESSION['link_account'] : '';
    $link_role = isset($_SESSION['link_role']) ? $_SESSION['link_role'] : 0;
    $link_rel_priv = isset($_SESSION['link_rel']) ? $_SESSION['link_rel'] : 0;

    unset($_SESSION['table_name']);
    unset($_SESSION['link_account']);
    unset($_SESSION['link_role']);
    unset($_SESSION['link_rel']);
}

?>

<!DOCTYPE html >
<head xmlns="http://www.w3.org/1999/html">
    <title>DB Project 2</title>
</head>
<body>
<?php
if ($table_name_to_insert != "") {
    echo "Creating table... " . $table_name_to_insert . "\n";

    $conn = get_db_connection();
    $user_role_id_to_insert = get_max_user_role($conn);

    $insert = " insert into security_database.table values ('%s', %d, %d, '%s')";
    $sql = sprintf($insert,
        $table_name_to_insert,
        $link_account, $link_role,
        $link_rel_priv);

    echo "Going to run '" . $sql . "'\n";

    $result = $conn->query($sql);

    if ($result === true) {
        // output data of each row
        echo "New Record created successfully" . "<br>";
        echo "Table created! ";
    } else {
        echo "Error:'" . $sql . "'<br>" . $conn->error . "<br>";
    }

    $conn->close();
} else {
    ?>

    <h2> Enter details for a new table </h2>
    <form method="post">

        <label for="table_name">Table Name:</label>
        <input id="table_name" type="text" name="table_name"/>
        <br>

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

        <label for="link_rel_priv">Which relation privilege link to?</label>
        <select id="link_rel_priv" name="link_rel">
            <?php

            $rel_privs = get_rel_privileges(get_db_connection());

            foreach($rel_privs as $key => $value) {
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