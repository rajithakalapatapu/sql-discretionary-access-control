<?php

$name = "";
session_start();

if (isset($_POST['submit']) && (
        ($_POST['name']) != "" && ($_POST['id']) != "" && ($_POST['role']) != "")) {
    $_SESSION['name'] = $_POST['name'];
    $_SESSION['id'] = $_POST['id'];
    $_SESSION['role'] = $_POST['role'];
    header("Location: " . $_SERVER['REQUEST_URI']);
    exit;
} else {
    if (isset($_SESSION['name']) && isset($_SESSION['id']) && isset($_SESSION['role'])) {
        //Retrieve show string from form submission.
        $name = $_SESSION['name'];
        $id = $_SESSION['id'];
        $role = $_SESSION['role'];
        unset($_SESSION['name']);
        unset($_SESSION['id']);
        unset($_SESSION['role']);
    }
}

?>

<!DOCTYPE html >
<head>
    <title>DB Project 2</title>
</head>
<body>
<br/><br/>
<h2>Enter your credentials</h2>

<?php
if ($name != "") {
    echo "Welcome " . $name . "<br/>";
    echo "Getting your privileges...";

    

} else {
    ?>


    <p><h3>Enter text in the box then select "Go":</h3></p>

    <form method="post">
        <label for="name">Name:</label>
        <input id="name" type="text" name="name"/>
        <br>
        <label for="id">ID:</label>
        <input id="id" type="text" name="id"/>
        <br>
        <label for="role">Role:</label>
        <input id="role" type="text" name="role"/>
        <br>
        <input type="submit" name="submit" value="Go"/>
    </form>

<?php } ?>

</body>
</html>