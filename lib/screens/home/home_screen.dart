import 'package:flutter/material.dart';
import '../../widget/header.dart';
import '../user_details/user.dart';

class HomeScreen extends StatelessWidget {
  static String routeName = "/home";

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppHeader(), // Use AppHeader as the app bar
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  // Navigate to the desired screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const UserScreen(),
                    ),
                  );
                },
                child: const Text('View Users'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}