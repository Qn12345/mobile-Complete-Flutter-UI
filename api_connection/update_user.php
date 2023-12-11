<?php
include "config.php";

$userid = $_POST['user_id'];
$user_name = $_POST['user_name'];
$user_password = $_POST['user_password'];
$user_guid = $_POST['user_guid'];
$dp_id = $_POST['dp_id'];

$sql = "SELECT * FROM user WHERE user_id = '$userid'";

$result = mysqli_query($connect, $sql);
$count = mysqli_num_rows($result);

if ($count == 1) {
    $sql1 = "UPDATE user SET user_name='$user_name', user_password='$user_password', user_guid='$user_guid', dp_id='$dp_id' WHERE user_id='$userid'"; 
    if ($connect->query($sql1) === TRUE) {
        echo "User updated successfully";
    } 
    else {
        echo "Error updating user: ";
    }
} else {
    echo json_encode("Error");
}
?>
