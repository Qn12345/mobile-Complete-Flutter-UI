import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

typedef RefreshCallback = void Function();

class AddUserForm extends StatelessWidget {
  final TextEditingController userIdController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController userPasswordController = TextEditingController();
  final TextEditingController userGuidController = TextEditingController();
  final TextEditingController dpIdController = TextEditingController();
  final RefreshCallback refreshCallback;

  AddUserForm({required this.refreshCallback});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add New User'),
      content: Container(
        width: MediaQuery.of(context).size.width * 0.8, // Adjust the width as needed
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 3.0),
                child: TextField(
                  controller: userIdController,
                  decoration: InputDecoration(
                    labelText: 'User ID (Email)',
                    labelStyle: TextStyle(fontSize: 20.0), // Adjust the font size as needed
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 3.0),
                child: TextField(
                  controller: userNameController,
                  decoration: InputDecoration(
                    labelText: 'User Name',
                    labelStyle: TextStyle(fontSize: 20.0),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 3.0),
                child: TextField(
                  controller: userPasswordController,
                  decoration: InputDecoration(
                    labelText: 'User Password',
                    labelStyle: TextStyle(fontSize: 20.0),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 3.0),
                child: TextField(
                  controller: userGuidController,
                  decoration: InputDecoration(
                    labelText: 'User Guid',
                    labelStyle: TextStyle(fontSize: 20.0),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 3.0),
                child: TextField(
                  controller: dpIdController,
                  decoration: InputDecoration(
                    labelText: 'DP ID',
                    labelStyle: TextStyle(fontSize: 20.0),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () async {
          // Validate inputs
          if (!_isEmail(userIdController.text)) {
            _showErrorDialog(context, 'Please enter a valid email address for User ID.');
            return;
          }

          if (_isEmpty(userNameController.text) ||
              _isEmpty(userPasswordController.text) ||
              _isEmpty(userGuidController.text) ||
              _isEmpty(dpIdController.text)) {
            _showErrorDialog(context, 'Please fill in all fields.');
            return;
          }

          // Perform the logic to add the new user here
          // You can access the entered values using the controllers
          String userId = userIdController.text;
          String userName = userNameController.text;
          String userPassword = userPasswordController.text;
          String userGuid = userGuidController.text;
          String dpId = dpIdController.text;

          // Send a request to your server to add the new user
          final response = await http.post(
            Uri.parse('http://10.0.2.2/api_connection/add_user.php'),
            body: {
              'user_id': userId,
              'user_name': userName,
              'user_password': userPassword,
              'user_guid': userGuid,
              'dp_id': dpId,
            },
          );

          // Handle the server response
          if (response.statusCode == 200) {
            // Assuming your PHP script echoes a message on success
            print(response.body); // Print the server response
            // Close the dialog
            Navigator.of(context).pop();
          // Show a success dialog
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Success'),
                  content: Text('User added successfully.'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // Close success dialog
                        refreshCallback();
                      },
                      child: Text('OK'),
                    ),
                  ],
                );
              },
            );
          } else {
            // Handle the error
            print('Error: ${response.statusCode}');
          }
        },
        child: Text('Add'),
      ),

      ],
    );
  }
}

bool _isEmail(String value) {
  // Simple email validation using a regular expression
  final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
  return emailRegex.hasMatch(value);
}

bool _isEmpty(String value) {
  return value.trim().isEmpty;
}

void _showErrorDialog(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          ),
        ],
      );
    },
  );
}