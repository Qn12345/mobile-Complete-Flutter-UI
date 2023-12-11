import 'package:flutter/material.dart';

class EditUserForm extends StatefulWidget {
  final String initialUserId;
  final String initialUserName;
  final String initialUserPassword;
  final String initialUserGuid;
  final String initialDpId;
  final Function(String, String, String, String, String) editUserCallback;

  EditUserForm({
    required this.initialUserId,
    required this.initialUserName,
    required this.initialUserPassword,
    required this.initialUserGuid,
    required this.initialDpId,
    required this.editUserCallback,
  });

  @override
  _EditUserFormState createState() => _EditUserFormState();
}

class _EditUserFormState extends State<EditUserForm> {
  late TextEditingController userNameController;
  late TextEditingController userPasswordController;
  late TextEditingController userGuidController;
  late TextEditingController dpIdController;

  @override
  void initState() {
    super.initState();
    userNameController = TextEditingController(text: widget.initialUserName);
    userPasswordController = TextEditingController(text: widget.initialUserPassword);
    userGuidController = TextEditingController(text: widget.initialUserGuid);
    dpIdController = TextEditingController(text: widget.initialDpId);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Edit User'),
      content: Container(
        width: MediaQuery.of(context).size.width * 0.8, // Adjust the width as needed
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 3.0),
                child: TextField(
                  controller: TextEditingController(text: widget.initialUserId),
                  enabled: false,
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
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            widget.editUserCallback(
              widget.initialUserId,
              userNameController.text,
              userPasswordController.text,
              userGuidController.text,
              dpIdController.text,
            );
            Navigator.of(context).pop();
          },
          child: Text('Update'),
        ),
      ],
    );
  }
}
