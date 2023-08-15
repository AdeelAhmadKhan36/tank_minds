import 'package:flutter/material.dart';
class Dairy_Screen extends StatefulWidget {
  const Dairy_Screen({super.key});

  @override
  State<Dairy_Screen> createState() => _Dairy_ScreenState();
}

class _Dairy_ScreenState extends State<Dairy_Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Dairy Home'),),
    );
  }
}
