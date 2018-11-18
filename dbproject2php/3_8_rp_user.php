<?php include 'secdb.php' ?>
<?php

$link_user = 0;
$link_rel_priv = 0;
session_start();

if (isset($_POST['submit'])) {
    $_SESSION['link_user'] = $_POST['link_user'];
    $_SESSION['link_rel'] = $_POST['link_rel'];

    header("Location: " . $_SERVER['REQUEST_URI']);
    exit;
} else {
    $link_user = isset($_SESSION['link_user']) ? $_SESSION['link_user'] : 0;
    $link_rel_priv = isset($_SESSION['link_rel']) ? $_SESSION['link_rel'] : 0;

    unset($_SESSION['link_user']);
    unset($_SESSION['link_rel']);
}

?>

<!DOCTYPE html >
<head xmlns="http://www.w3.org/1999/html">
    <title>DB Project 2</title>
</head>
<body>
<?php
if ($link_user != 0) {
    echo "Check if user  " . $link_user . " has been GRANTED relation privilege " . $link_rel_priv;

    $conn = get_db_connection();

    $sql = "select * from relation_privilege where rp_role_id in (select role_id from user_role where uid =  " . $link_user . ")";
    $result = $conn->query($sql);
    if ($result->num_rows >= 1) {
        echo "Yes";
    } else {
        echo "No";
    }

    $conn->close();
} else {
    ?>

    <h2> Check whether a particular privilege is currently available (granted) to a particular user account.</h2>
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