import 'package:flutter/material.dart';
class MyAppBar extends StatelessWidget {
  const MyAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text(""),
      backgroundColor: Color(0xFFF06B20),
    );
  }
}
