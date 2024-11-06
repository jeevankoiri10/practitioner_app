import 'package:flutter/material.dart';

abstract class BaseScreenPage extends StatelessWidget {
  static const Color primaryColor = Color(0xFF6200EE);
  static const Color secondaryColor = Color(0xFF03DAC6);
  static const Color backgroundColor = Colors.white;
  static const Color cardColor = Color(0xFFF5F5F5);
  static const Color textColor = Colors.black;
  static const Color subtitleColor = Colors.grey;

  static const TextStyle titleStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: textColor,
  );

  static const TextStyle subtitleStyle = TextStyle(
    fontSize: 16,
    color: subtitleColor,
  );

  static const TextStyle priceStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Colors.green,
  );

  String getTitle(); // Abstract method to get the title
  List<Widget> getActions(
      BuildContext context); // Abstract method for actions in the AppBar

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        getTitle(),
        style: titleStyle,
      ),
      centerTitle: true,
      backgroundColor: primaryColor,
      elevation: 4,
      actions: getActions(context),
    );
  }
}
