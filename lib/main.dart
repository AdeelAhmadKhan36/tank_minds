import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:tank_minds/AdminPanel/Admin-Screen/Notes_Board.dart';

import 'AdminPanel/Admin-Screen/Cases_Datils.dart';
import 'AdminPanel/Admin_Home.dart';
import 'AdminPanel/Users/Admin.dart';


void main()async{


  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return   MaterialApp(
      debugShowCheckedModeBanner: false,

      home:Admin_home(),
    );
  }
}
