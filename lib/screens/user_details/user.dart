import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_svg/flutter_svg.dart';
import '../../widget/header.dart';
import 'add_user_form.dart';
import 'edit_user_form.dart';

class User {
  final String userId;
  final String userName;
  final String userGuid;

  User({
    required this.userId,
    required this.userName,
    required this.userGuid,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['user_id']  ?? '',
      userName: json['user_name'] ?? '',
      //userPassword: json['user_password'],
      userGuid: json['user_guid'] ?? '',
      //dpid: json['dp_id'],
    );
  }
}

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  late List<User> userList;

  @override
  void initState() {
    super.initState();
    userList = [];
    fetchUsers();
  }

  void refreshPage() {
    setState(() {
      fetchUsers();
    });
  }

  Future<void> fetchUsers() async {
    final response = await http.get(
        Uri.parse('http://office.panda-eco.com:18243/rest_b2b/index.php/B2b_trigger/Display'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      userList = data.map((json) => User.fromJson(json)).toList();
      setState(() {});
    } else {
      throw Exception('Failed to load users');
    }
  }

  void _showDeleteSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Successful'),
          content: const Text('The operation has been successfully completed.'),
          actions: <Widget>[
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

  Future<void> deleteUser(String userId) async {
    final response = await http.post(
      Uri.parse('http://office.panda-eco.com:18243/rest_b2b/index.php/B2b_trigger/Delete'),
      body: {'user_id': userId},
    );
    var data = json.decode(response.body);
    if (data['status']=='true') {
      _showDeleteSuccessDialog();
      fetchUsers();
    } else {
      print('Failed to delete user');
    }
  }

  void _showEditUserForm(User user) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return EditUserForm(
            initialUserId: user.userId,
            initialUserName: user.userName,
            //initialUserPassword: user.userPassword,
            initialUserGuid: user.userGuid,
            //initialDpId: user.dpid,
            editUserCallback: (userId, userName, userGuid) {
              _editUser(user.userId, userName, userGuid);
            },
          );
        },
      );
    }

  Future<void> _editUser(
    String userId,
    String userName,
    //String userPassword,
    String userGuid,
    //String dpId,
  ) async {
    final response = await http.post(
      Uri.parse('http://office.panda-eco.com:18243/rest_b2b/index.php/B2b_trigger/Update'),
      body: {
        'user_id': userId,
        'user_name': userName,
        //'user_password': userPassword,
        'user_guid': userGuid,
        //'dp_id': dpId,
      },
    );
    var data = json.decode(response.body);
    if (data['status']=='true') {
      _showEditSuccessDialog();
      fetchUsers();
    } else {
      _showEditFailedDialog();
    }
  }

  void _showEditSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Successful'),
          content: const Text('The user has been successfully edited.'),
          actions: <Widget>[
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

  void _showEditFailedDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Failed to Edit'),
          content: const Text('Failed to Edit'),
          actions: <Widget>[
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppHeader(),
      body: userList.isNotEmpty
          ? ListView.builder(
              itemCount: userList.length,
              itemBuilder: (context, index) {
                User user = userList[index];
                return Card(
                  margin: const EdgeInsets.all(8.0),
                  color: Colors.orange[100],
                  child: ListTile(
                    title: Text('User ID: ${user.userId ?? 'N/A'}'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('User Name: ${user.userName ?? 'N/A'}'),
                        //Text('User Password: ${user.userPassword}'),
                        Text('User Guid: ${user.userGuid ?? 'N/A'}'),
                        //Text('DP id: ${user.dpid}'),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {
                                _showEditUserForm(user);
                              },
                          icon: SvgPicture.asset(
                            'assets/icons/Settings.svg',
                            height: 24,
                            width: 24,
                            color: Colors.blue,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            deleteUser(user.userId);
                          },
                          icon: SvgPicture.asset(
                            'assets/icons/Trash.svg',
                            height: 24,
                            width: 24,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AddUserForm(
                refreshCallback: refreshPage,
              );
            },
          );
        },
        backgroundColor: Colors.orange,
        child: SvgPicture.asset(
          'assets/icons/Plus Icon.svg',
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
