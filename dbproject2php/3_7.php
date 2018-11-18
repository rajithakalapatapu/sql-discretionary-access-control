<?php include 'secdb.php' ?>
<?php

$link_table = '';
$link_rel_privilege = '';
$link_role = 0;
session_start();

if (isset($_POST['submit'])) {
    $_SESSION['link_table'] = $_POST['link_table'];
    $_SESSION['link_relpriv'] = $_POST['link_relpriv'];
    $_SESSION['link_role'] = $_POST['link_role'];

    header("Location: " . $_SERVER['REQUEST_URI']);
    exit;
} else {
    $link_table = isset($_SESSION['link_table']) ? $_SESSION['link_table'] : '';
    $link_rel_privilege = isset($_SESSION['link_relpriv']) ? $_SESSION['link_relpriv'] : '';
    $link_role = isset($_SESSION['link_role']) ? $_SESSION['link_role'] : 0;

    unset($_SESSION['link_table']);
    unset($_SESSION['link_relpriv']);
    unset($_SESSION['link_role']);
}

?>

<!DOCTYPE html >
<head xmlns="http://www.w3.org/1999/html">
    <title>DB Project 2</title>
</head>
<body>
<?php
if ($link_rel_privilege != '') {
    echo "Linking relation privilege " . $link_rel_privilege . " to user role " . $link_role . " and table " . $link_table;

    $conn = get_db_connection();

    $insert = " insert into security_database.relation_privilege values ('%s', %d, '%s')";
    $sql = sprintf($insert, $link_rel_privilege, $link_role, $link_table);
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

    <h2> Link relation privilege to a role and a table </h2>
    <form method="post">

        <label for="link_relpriv">Which relation privilege to link to?</label>
        <select id="link_relpriv" name="link_relpriv">
            <?php

            $privs = get_rel_privileges(get_db_connection());

            foreach ($privs as $key => $value) {
                echo "<option value=\"" . $key . "\">" . $value . "</option> <br>";
            }

            ?>
        </select>
        <br/>

        <label for="link_role">Which user role to link to?</label>
        <select id="link_role" name="link_role">
            <?php

            $role_ids = get_user_roles(get_db_connection());

            foreach ($role_ids as $key => $value) {
                echo "<option value=\"" . $key . "\">" . $value . "</option> <br>";
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