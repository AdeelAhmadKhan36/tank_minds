import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart'; // Import the file_picker package

class AdminPanel extends StatefulWidget {
  @override
  _AdminPanelState createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Law Firm Admin Panel'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Date Slider (You can use a package like `carousel_slider` for this)
            // ...

            // Case Details Form
            Container(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  // Case Title
                  TextField(
                    decoration: InputDecoration(labelText: 'Case Title'),
                  ),
                  // Court Name
                  TextField(
                    decoration: InputDecoration(labelText: 'Court Name'),
                  ),
                  // Current Proceeding
                  TextField(
                    decoration: InputDecoration(labelText: 'Current Proceeding'),
                  ),
                  // Lawyer Name
                  TextField(
                    decoration: InputDecoration(labelText: 'Lawyer Name'),
                  ),
                  // File Upload Button
                  ElevatedButton(
                    onPressed: _uploadFile,
                    child: Text('Upload File'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // File Upload Function
  Future<void> _uploadFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      // Handle the selected file (e.g., upload to server or store locally)
      // ...
    }
  }
}
