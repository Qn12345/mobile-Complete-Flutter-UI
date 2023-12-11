<?php 
    include "config.php";
    // Get user data from POST request
    $userId = $_POST['user_id'];

    // Delete the user from the database
    $query = "DELETE FROM user WHERE user_id = '$userId'";
    $result = mysqli_query($connect, $query);

    if ($result) {
        echo json_encode(['message' => 'User deleted successfully']);
    } else {
        echo json_encode(['message' => 'Failed to delete user']);
    }

    


    
    
    ?>