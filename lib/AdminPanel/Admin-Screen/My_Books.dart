import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:tank_minds/AdminPanel/PDFView/pdf-viewer.dart';
import 'package:url_launcher/url_launcher.dart';

class BookScreen extends StatefulWidget {
  @override
  _BookScreenState createState() => _BookScreenState();
}
class _BookScreenState extends State<BookScreen> {
  List<String> pdfFiles = [];

  @override
  void initState() {
    super.initState();
    fetchPDFFiles();
  }

  Future<void> fetchPDFFiles() async {
    // Assuming you have a reference to your Firebase Storage books directory
    Reference storageRef = FirebaseStorage.instance.ref().child('uploads/');

    // Fetch the list of files from Firebase Storage
    ListResult result = await storageRef.listAll();

    setState(() {
      pdfFiles = result.items.map((item) => item.name).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Screen'),
      ),
      body:ListView.builder(
        itemCount: pdfFiles.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.picture_as_pdf),
            title: Text(pdfFiles[index]),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PDFViewPage(pdfUrl: pdfFiles[index]),
                ),
              );
            },
          );
        },
      ),



    );
  }
}




