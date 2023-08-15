import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
      ),
      body: Center(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
            height: 50,
            decoration: BoxDecoration(
              color: Colors.deepPurple,
              borderRadius: BorderRadius.circular(10)),
                child: ListTile(

                    leading: Icon(Icons.notifications),
                  title: Text('Simple Notifications',style: TextStyle(color: Colors.white),),
                  onTap: () {

                  }
                ),
              ),
              SizedBox(height:30,),
              Container(
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.circular(10)),
                child: ListTile(
                  leading: Icon(Icons.schedule),
                  title: Text('Schedule Notifications',style: TextStyle(color: Colors.white)),
                  onTap: () {}

                ),
              ),
              SizedBox(height: 30,),
              Container(
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.circular(10)),
                child: ListTile(
                  leading: Icon(Icons.delete),
                  title: Text('Remove Notification',style: TextStyle(color: Colors.white)),
                  onTap: () {} // Replace with actual notification ID
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


