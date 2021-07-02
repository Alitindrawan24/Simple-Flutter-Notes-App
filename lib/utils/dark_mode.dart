import 'package:flutter/material.dart';

class DarkMode extends StatefulWidget {
  const DarkMode({Key? key}) : super(key: key);

  @override
  _DarkModeState createState() => _DarkModeState();
}

class _DarkModeState extends State<DarkMode> {
  bool isDark = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 0, 16.0, 0),
      child: IconButton(
        icon: Icon(isDark ? Icons.dark_mode : Icons.light_mode),
        onPressed: () {
          isDark = !isDark;
          setState(() {});
        },
      ),
    );
  }
}
