<?php include 'secdb.php' ?>
<?php

$link_user = 0;
session_start();

if (isset($_POST['submit'])) {
    $_SESSION['link_user'] = $_POST['link_user'];

    header("Location: " . $_SERVER['REQUEST_URI']);
    exit;
} else {
    $link_user = isset($_SESSION['link_user']) ? $_SESSION['link_user'] : 0;

    unset($_SESSION['link_user']);
}

?>

<!DOCTYPE html >
<head xmlns="http://www.w3.org/1999/html">
    <title>DB Project 2</title>
</head>
<body>
<?php
if ($link_user != 0) {
    echo "Retrieving relation privileges for user  " . $link_user;

    $conn = get_db_connection();

    $sql = "select * from part_of where role_id in (select role_id from user_role where uid = " . $link_user . ")";
    $result = $conn->query($sql);
    while ($row = $result->fetch_assoc()) {
        echo $row['role_id'] . "\t" . $row['po_table_name'] . "\t" . $row['po_rp_name'];
    }

    echo "Retrieving account privileges for user role " . $link_user;

    $sql = "select * from account_privilege where ap_role_id in (select role_id from user_role where uid = " . $link_user . ")";
    $result = $conn->query($sql);
    while ($row = $result->fetch_assoc()) {
        echo $row['acc_priv_name'] . "\t" . $row['ap_uid'] . "\t" . $row['ap_role_id'];
    }


    $conn->close();
} else {
    ?>

    <h2> Retrieve all privileges associate with a particular USER_ACCOUNT</h2>
    <form method="post">

        <label for="link_user">Which user account to retrieve details about?</label>
        <select id="link_user" name="link_user">
            <?php

            $role_ids = get_user_names_ids(get_db_connection());

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