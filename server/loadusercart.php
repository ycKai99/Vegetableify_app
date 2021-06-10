<?php
include_once("dbconnect.php");
$email = $_POST['email'];

$sqlloadcart = "SELECT * FROM tbl_cart INNER JOIN tbl_products ON tbl_cart.prid = tbl_products.prid WHERE tbl_cart.email = '$email'";;

$result = $conn->query($sqlloadcart);

if ($result->num_rows > 0) {
    $products['cart'] = array();
    while ($row = $result->fetch_assoc()) {
        $productlist['prid'] = $row['prid'];
        $productlist['prname'] = $row['prname'];
        $productlist['prtype'] = $row['prtype'];
        $productlist['prprice'] = $row['prprice'];
        $productlist['cartqty'] = $row['cartqty'];
        $productlist['prqty'] = $row['prqty'];
        array_push($products['cart'], $productlist);
    }
    echo json_encode($products);
} else {
    echo "nodata";
}

?>