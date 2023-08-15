import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tank_minds/Home_Screen/Drawer/Header_drawer.dart';
import 'package:tank_minds/Home_Screen/ListPages/about.dart';
import 'package:tank_minds/Home_Screen/ListPages/contact.dart';
import 'package:tank_minds/Home_Screen/ListPages/login.dart';
import 'package:tank_minds/Home_Screen/Adeel.dart';



class Home_Screen extends StatefulWidget {
  @override
  _Home_ScreenState createState() => _Home_ScreenState();
}

class _Home_ScreenState extends State<Home_Screen> {
  @override

  double _sliderValue = 0.5; // Initial value for the slider
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    Timer.periodic(Duration(seconds: 3), (timer) {
      if (_scrollController.positions.isNotEmpty) {
        // If the scroll controller has positions, meaning the ListView is built
        double currentOffset = _scrollController.offset;
        double itemExtent =280; // The width of each container in the ListView
        double newOffset = currentOffset + itemExtent;

        if (newOffset >= _scrollController.position.maxScrollExtent) {
          newOffset = 0.0; // Reset the scroll to the beginning when it reaches the end
        }

        _scrollController.animateTo(
          newOffset,
          duration: Duration(milliseconds: 500),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }


  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[700],
        title: Text("Home Screen"),
        actions: [
          TextButton(onPressed:(){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
          }, child: Text('Login',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)),
          IconButton(onPressed:(){}, icon: Icon(Icons.notification_important_rounded),),
        ],

      ),
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Column(
            children: [
              MyHeaderDrawer(),
              SizedBox(height: 10),

              ListTile(
                leading: Icon(Icons.home),
                title: Text('Home'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.info),
                title: Text('About'),
                onTap: () {
                  Navigator.push(context,MaterialPageRoute(builder: (context)=>About()));
                },
              ),
              ListTile(
                leading: Icon(Icons.contact_page_outlined),
                title: Text('Contact'),
                onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Contact_Us()));
                },
              ),
              ListTile(
                leading: Icon(Icons.login),
                title: Text('Login'),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
                },
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: 200,

          padding: EdgeInsets.all(20),
          child: ListView.builder(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              itemBuilder: (BuildContext,int index){
                return Container(
                    width: 260,
                    margin: EdgeInsets.symmetric(horizontal: 10.0),
                
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Center(
                child: Text(
                'Item $index',
                style: TextStyle(color: Colors.white, fontSize: 20.0),
                ),
                ),

                );


          }),
        ),
      ),

    );
  }
}
