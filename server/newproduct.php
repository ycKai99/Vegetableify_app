<?php
include_once("dbconnect.php");
$product_name = $_POST['name'];
$product_type = $_POST['type'];
$product_price = $_POST['price'];
$product_qty = $_POST['qty'];
$encoded_string = $_POST["encoded_string"];

$sqlinsert = "INSERT INTO tbl_products(prname,prtype,prprice,prqty) VALUES('$product_name','$product_type','$product_price','$product_qty')";
if ($conn->query($sqlinsert) === TRUE){
    $decoded_string = base64_decode($encoded_string);
    $filename = mysqli_insert_id($conn);
    $path = '../images/'.$filename.'.png';
    $is_written = file_put_contents($path, $decoded_string);
    echo "success";
}else{
    echo "failed";
}

?>