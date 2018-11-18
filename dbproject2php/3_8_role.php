<?php include 'secdb.php' ?>
<?php

$link_role = 0;
session_start();

if (isset($_POST['submit'])) {
    $_SESSION['link_role'] = $_POST['link_role'];

    header("Location: " . $_SERVER['REQUEST_URI']);
    exit;
} else {
    $link_role = isset($_SESSION['link_role']) ? $_SESSION['link_role'] : 0;

    unset($_SESSION['link_role']);
}

?>

<!DOCTYPE html >
<head xmlns="http://www.w3.org/1999/html">
    <title>DB Project 2</title>
</head>
<body>
<?php
if ($link_role != 0) {
    echo "Retrieving relation privileges for user role " . $link_role;

    $conn = get_db_connection();

    $sql = "select * from part_of where role_id = " . $link_role;
    $result = $conn->query($sql);
    while ($row = $result->fetch_assoc()) {
        echo $row['role_id'] . "\t" . $row['po_table_name'] . "\t" . $row['po_rp_name'];
    }

    echo "Retrieving account privileges for user role " . $link_role;

    $sql = "select * from account_privilege where ap_role_id = " . $link_role;
    $result = $conn->query($sql);
    while ($row = $result->fetch_assoc()) {
        echo $row['acc_priv_name'] . "\t" . $row['ap_uid'] . "\t" . $row['ap_role_id'];
    }


    $conn->close();
} else {
    ?>

    <h2>Retrieve all privileges associate with a particular ROLE</h2>
    <form method="post">

        <label for="link_role">Which user role to retrieve details about?</label>
        <select id="link_role" name="link_role">
            <?php

            $role_ids = get_user_roles(get_db_connection());

            foreach ($role_ids as $key => $value) {
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