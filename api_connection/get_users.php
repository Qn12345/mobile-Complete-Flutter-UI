<?php
include 'config.php';

// Fetch users from the database
$sql = "SELECT * FROM user";
$result = $connect->query($sql);

if ($result->num_rows > 0) {
    $users = array();

    while ($row = $result->fetch_assoc()) {
        $users[] = $row;
    }

    // Output JSON response
    header('Content-Type: application/json');
    echo json_encode($users);
} else {
    // No users found
    echo "No users found";
}

?>