<?php 
    include "config.php";
    // Get user data from POST request
    $user_id = $_POST['user_id'];
    $user_name = $_POST['user_name'];
    $user_password = $_POST['user_password'];
    $user_guid = $_POST['user_guid'];
    $dp_id = $_POST['dp_id'];

    $sql = "SELECT * FROM user WHERE user_id = '$user_id'";

    $result = mysqli_query($connect, $sql);
    $count = mysqli_num_rows($result);

    if ($count == 1) {
        http_response_code(405);
        echo json_encode(array('error' => 'User Email already in the system. Please check again.'));
        //("User Email already in the system. Please check again.");
    } 
    else {
        $sql = "INSERT INTO user (user_id, user_name, user_password, user_guid, dp_id)
        VALUES ('$user_id', '$user_name', '$user_password', '$user_guid', '$dp_id')";

        if ($connect->query($sql) === TRUE) {
            echo "New user added successfully";
        } else {
            echo "Error: " . $sql . "<br>" . $connect->error;
        }

    }

    ?>