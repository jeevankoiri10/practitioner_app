// Floating action button for editing
import 'package:flutter/material.dart';

class EditButton extends StatelessWidget {
  final VoidCallback onPressed;

  EditButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 50,
      child: FloatingActionButton(
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.edit),
            SizedBox(width: 8),
            Text('Edit', style: TextStyle(fontSize: 16)),
          ],
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }
}
