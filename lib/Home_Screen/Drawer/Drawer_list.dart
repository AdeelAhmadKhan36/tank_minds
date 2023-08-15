import 'package:flutter/material.dart';
class DrawerList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child:
        ListView(
          children: [
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                // Handle home navigation here
              },
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('About'),
              onTap: () {
                // Handle about navigation here
              },
            ),
            ListTile(
              leading: Icon(Icons.mail),
              title: Text('Contact'),
              onTap: () {
                // Handle contact navigation here
              },
            ),
            ListTile(
              leading: Icon(Icons.login),
              title: Text('Login'),
              onTap: () {
                // Handle login navigation here
              },
            ),
          ],

      ),
    );
  }
}
