<?php
/**
 * Created by PhpStorm.
 * User: rajitha
 * Date: 11/17/18
 * Time: 10:35 PM
 */

function get_db_connection() {
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
    return $conn;
}

function get_max_user_account($conn) {
    $user_account_id_to_insert = 0;
    $sql = "select max(user_account_id) from user_account";
    $result = $conn->query($sql);
    while ($row = $result->fetch_assoc()) {
        $user_account_id_to_insert = intval($row['max(user_account_id)']) + 1;
    }
    return $user_account_id_to_insert;
}

function get_max_user_role($conn) {
    $user_role_id_to_insert = 0;
    $sql = "select max(role_id) from user_role";
    $result = $conn->query($sql);
    while ($row = $result->fetch_assoc()) {
        $user_role_id_to_insert = intval($row['max(role_id)']) + 100;
    }
    return $user_role_id_to_insert;
}

function get_user_names_ids($conn) {
    $output = array();
    $result = $conn->query("select user_account_id, fname from user_account");
    while ($row = $result->fetch_assoc()) {
        $output[$row['user_account_id']] = $row['fname'];
    }
    return $output;
}
?>