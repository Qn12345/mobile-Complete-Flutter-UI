<?php
include "config.php";

$username = $_POST['user_id'];
$password = $_POST['user_password'];

$sql = "SELECT * FROM user WHERE user_id = '" . $username . "' AND user_password = '" . $password . "'";

$result = mysqli_query($connect, $sql);
$count = mysqli_num_rows($result);

if ($count == 1) {
    echo json_encode("Success");
} else {
    echo json_encode("Error");
}
?>
