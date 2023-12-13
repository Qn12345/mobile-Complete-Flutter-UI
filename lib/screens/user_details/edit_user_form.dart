import 'package:flutter/material.dart';

class EditUserForm extends StatefulWidget {
  final String initialUserId;
  final String initialUserName;
  final String initialUserGuid;
  final Function(String, String, String) editUserCallback;

  const EditUserForm({
    super.key,
    required this.initialUserId,
    required this.initialUserName,
    required this.initialUserGuid,
    required this.editUserCallback,
  });

  @override
  _EditUserFormState createState() => _EditUserFormState();
}

class _EditUserFormState extends State<EditUserForm> {
  late TextEditingController userNameController;
  late TextEditingController userPasswordController;
  late TextEditingController userGuidController;

  @override
  void initState() {
    super.initState();
    userNameController = TextEditingController(text: widget.initialUserName);
    userGuidController = TextEditingController(text: widget.initialUserGuid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit User'),
        backgroundColor: Colors.orange, // Customize background color
      elevation: 0,
      ),
      body: SafeArea(
        //width: MediaQuery.of(context).size.width * 0.8, // Adjust the width as needed
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: TextField(
                  controller: TextEditingController(text: widget.initialUserId),
                  enabled: false,
                  decoration: const InputDecoration(
                    labelText: 'User ID (Email)',
                    labelStyle: TextStyle(fontSize: 20.0), // Adjust the font size as needed
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
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            Spacer(),
            TextButton(
              onPressed: () {
                widget.editUserCallback(
                  widget.initialUserId,
                  userNameController.text,
                  userGuidController.text,
                );
                Navigator.of(context).pop();
              },
              child: const Text('Update'),
            ),
          ],
        ),
      ),
    );
  }
}
