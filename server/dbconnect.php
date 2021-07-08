<?php
$servername = "localhost";
$username   = "yckcom_myshopadmin";
$password   = "JhT6N5-CBh1Y";
$dbname     = "yckcom_myshopdb";

$conn = new mysqli($servername, $username, $password, $dbname);
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}
?>