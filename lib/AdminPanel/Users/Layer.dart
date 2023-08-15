import 'package:flutter/material.dart';
class LayerScreen extends StatefulWidget {
  const LayerScreen({super.key});

  @override
  State<LayerScreen> createState() => _LayerScreenState();
}

class _LayerScreenState extends State<LayerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lawyer Screen'),
      ),
    );
  }
}
