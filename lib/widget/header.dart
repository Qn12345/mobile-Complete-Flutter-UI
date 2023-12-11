import 'package:flutter/material.dart';

class AppHeader extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        'Your App Name',
        /*style: TextStyle(
          color: const Color.black, // Customize text color
        ),*/
      ),
      backgroundColor: Colors.orange, // Customize background color
      elevation: 0, // Remove shadow
      // You can add more customization properties as needed
      // such as actions, icons, etc.
    );
  }
}
