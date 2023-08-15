import 'package:flutter/material.dart';
class Comments_Screen extends StatefulWidget {
  const Comments_Screen({super.key});

  @override
  State<Comments_Screen> createState() => _Comments_ScreenState();
}

class _Comments_ScreenState extends State<Comments_Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Comments_Screen'),),
    );
  }
}
