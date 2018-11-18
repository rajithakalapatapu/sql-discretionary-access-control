<?php include 'secdb.php' ?>
<?php

$rp_name_to_insert = "";
$link_user_role = 0;
$link_table = 0;
session_start();

if (isset($_POST['submit']) ) {

    $_SESSION['relpriv_name'] = $_POST['relpriv_name'];
    $_SESSION['link_user_role']  = $_POST['link_user_role'];
    $_SESSION['link_table']  = $_POST['link_table'];

    header("Location: " . $_SERVER['REQUEST_URI']);
    exit;
} else {
    $rp_name_to_insert = isset($_SESSION['relpriv_name']) ? $_SESSION['relpriv_name'] : '';
    $link_user_role = isset($_SESSION['link_user_role']) ? $_SESSION['link_user_role'] : '';
    $link_table = isset($_SESSION['link_table']) ? $_SESSION['link_table'] : 0;

    unset($_SESSION['relpriv_name']);
    unset($_SESSION['link_user_role']);
    unset($_SESSION['link_table']);
}

?>

<!DOCTYPE html >
<head xmlns="http://www.w3.org/1999/html">
    <title>DB Project 2</title>
</head>
<body>
<?php
if ($rp_name_to_insert != "") {
    echo "Creating account privilege... " . $rp_name_to_insert . "\n";

    $conn = get_db_connection();

    $insert = " insert into security_database.relation_privilege values ('%s', %d, '%s')";
    $sql = sprintf($insert,
        $rp_name_to_insert,
        $link_user_role, $link_table);

    echo "Going to run '" . $sql . "'\n";

    $result = $conn->query($sql);

    if ($result === true) {
        // output data of each row
        echo "New Record created successfully" . "<br>";
        echo "Relation privilege created! ";
    } else {
        echo "Error:'" . $sql . "'<br>" . $conn->error . "<br>";
    }

    $conn->close();
} else {
    ?>

    <h2> Enter details for a new relation privilege </h2>
    <form method="post">

        <label for="relpriv_name">Relation Privilege Name:</label>
        <input id="relpriv_name" type="text" name="relpriv_name"/>
        <br/>

        <label for="link_user_role">Which user role to link to?</label>
        <select id="link_user_role" name="link_user_role">
            <?php

            $role_ids = get_user_roles(get_db_connection());

            foreach($role_ids as $key => $value) {
                echo "<option value=\"" . $key . "\">" .  $value . "</option> <br>";
            }

            ?>
        </select>
        <br/>

        <label for="link_table">Which table to link to?</label>
        <select id="link_table" name="link_table">
            <?php

            $tables = get_tables(get_db_connection());

            foreach ($tables as $key => $value) {
                echo "<option value=\"" . $key . "\">" . $value . "</option> <br>";
            }

            ?>
        </select>
        <br/>

        <input type="submit" name="submit" value="Go"/>
    </form>

<?php } ?>

</body>
</html>