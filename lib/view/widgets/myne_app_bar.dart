import 'package:flutter/material.dart';

class MYNEappBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const MYNEappBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: TextStyle(
            fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      centerTitle: true,
      backgroundColor: Theme.of(context).primaryColor,
      elevation: 4,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
