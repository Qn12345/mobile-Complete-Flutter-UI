import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

typedef RefreshCallback = void Function();

class AddUserForm extends StatelessWidget {
  final TextEditingController userIdController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController userGuidController = TextEditingController();
  final RefreshCallback refreshCallback;

  AddUserForm({super.key, required this.refreshCallback});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New User'),
        backgroundColor: Colors.orange, // Customize background color
      elevation: 0,
      ),
      body: SafeArea(
        //width: MediaQuery.of(context).size.width * 0.8,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: TextField(
                  controller: userIdController,
                  decoration: const InputDecoration(
                    labelText: 'User ID (Email)',
                    labelStyle: TextStyle(fontSize: 20.0),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: TextField(
                  controller: userNameController,
                  decoration: const InputDecoration(
                    labelText: 'User Name',
                    labelStyle: TextStyle(fontSize: 20.0),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: TextField(
                  controller: userGuidController,
                  decoration: const InputDecoration(
                    labelText: 'User Guid',
                    labelStyle: TextStyle(fontSize: 20.0),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(height: 16.0), // Add some spacing
              ElevatedButton(
                onPressed: () async {
                  // Validate inputs
                  if (!_isEmail(userIdController.text)) {
                    _showErrorDialog(context, 'Please enter a valid email address for User ID.');
                    return;
                  }

                  if (_isEmpty(userNameController.text) || _isEmpty(userGuidController.text)) {
                    _showErrorDialog(context, 'Please fill in all fields.');
                    return;
                  }

                  // Perform the logic to add the new user here
                  // You can access the entered values using the controllers
                  String userId = userIdController.text;
                  String userName = userNameController.text;
                  String userGuid = userGuidController.text;

                  // Send a request to your server to add the new user
                  final response = await http.post(
                    Uri.parse('http://office.panda-eco.com:18243/rest_b2b/index.php/B2b_trigger/Add'),
                    body: {
                      'user_id': userId,
                      'user_name': userName,
                      'user_guid': userGuid,
                    },
                  );
                  var data = json.decode(response.body);
                  // Handle the server response
                  if (data['status'] == 'true') {
                    // Assuming your PHP script echoes a message on success
                    print(data['message']); // Print the server response
                    refreshCallback();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('User added successfully.'),
                      ),
                    );
                    Navigator.of(context).pop();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('User Email already in the system.'),
                      ),
                    );
                  }
                },
                child: Text('Add'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

bool _isEmail(String value) {
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
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}
