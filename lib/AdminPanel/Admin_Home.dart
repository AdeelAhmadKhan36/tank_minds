import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:tank_minds/AdminPanel/Admin-Screen/Cases_Datils.dart';
import 'package:tank_minds/AdminPanel/Admin-Screen/Dairy_Screen.dart';
import 'package:tank_minds/AdminPanel/Admin-Screen/File_Upload.dart';
import 'package:tank_minds/AdminPanel/Admin-Screen/My_Books.dart';
import 'package:tank_minds/AdminPanel/Admin-Screen/Notes_Board.dart';
import 'package:tank_minds/Utilities/utils.dart';

class Admin_home extends StatefulWidget {
  const Admin_home({super.key});

  @override
  State<Admin_home> createState() => _Admin_homeState();
}

class _Admin_homeState extends State<Admin_home> {
  bool loading = false;
  final _picker = ImagePicker();
  final _storage = FirebaseStorage.instance;

  Future<void> _pickAndUploadFile(BuildContext context, ImageSource source, {String? fileType}) async {
    PlatformFile? result;

    if (fileType == 'pdf') {
      result = (await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      ))?.files.first;
    } else {
      final pickedFile = await _picker.pickImage(source: source);
      if (pickedFile != null) {
        result = PlatformFile(
          path: pickedFile.path,
          name: path.basename(pickedFile.path),
          size: await pickedFile.length(), // Use lengthSync() to get the file size.
        );
      }
    }

    if (result != null) {
      final file = File(result.path!); // Use the ! operator to indicate non-nullability.

      final fileName = path.basename(file.path);
      final Reference storageRef = _storage.ref().child('uploads/$fileName');
      final UploadTask uploadTask = storageRef.putFile(file);

      try {
        await uploadTask.whenComplete(() {
          print('File uploaded successfully');
        });
        Utils().toastmessage('File Uploaded Successfully');
        Navigator.pop(context);
      } catch (error) {
        Utils().toastmessage('File upload failed: $error');
      }
    }
  }



  Future<void> _uploadFile(BuildContext context) async {
    setState(() {
      loading = true;
    });

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select File Type'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // ElevatedButton(
              //   onPressed: () {
              //     Navigator.pop(context);
              //     _pickAndUploadFile(context, ImageSource.gallery);
              //   },
              //   child: Text('Upload Image'),
              // ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  _pickAndUploadFile(context, ImageSource.gallery,
                      fileType: 'pdf');
                },
                child: Text('Upload PDF'),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(80),
              ),
            ),
            child: Column(
              children: [
                const SizedBox(height: 50),
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 30),
                  title: Text('Dashboard!', style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Colors.white
                  )),
                  subtitle: Text('Welcome to Admin Panel', style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.white54
                  )),
                  trailing: const CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('Assets/Images/splashlogo.png'),
                  ),
                ),
                const SizedBox(height: 30)
              ],
            ),
          ),
          Container(
            color: Theme.of(context).primaryColor,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(200)
                  )
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 30,top: 20),
                child: GridView.count(
                  shrinkWrap: true,
                  physics:  NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: 40,
                  mainAxisSpacing: 30,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Dairy_Screen()));
                      },
                      child: itemDashboard('My Dairy', CupertinoIcons.book_circle, Colors.deepOrange),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Cases_Screen()));
                      },
                      child:  itemDashboard('Cases Details', CupertinoIcons.person_2, Colors.purple),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) =>NotificationScreen()));
                      },
                      child: itemDashboard('Notes Board', CupertinoIcons.chat_bubble_2, Colors.brown),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) =>BookScreen()));
                      },
                      child:  itemDashboard('Books', CupertinoIcons.book_circle, Colors.indigo),
                    ),
                    GestureDetector(
                      onTap: () async{
                        setState(() {
                          loading = false;
                        });
                        Navigator.pop(context);
                        _uploadFile(context);
                      },
                      child:  itemDashboard('Upload', CupertinoIcons.add_circled, Colors.teal),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) =>File_Upload()));
                      },
                      child:  itemDashboard('Comments', CupertinoIcons.chat_bubble_2, Colors.blue),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 70)
        ],
      ),
    );
  }

  itemDashboard(String title, IconData iconData, Color background) => Container(
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
              offset: const Offset(0, 5),
              color: Theme.of(context).primaryColor.withOpacity(.2),
              spreadRadius: 2,
              blurRadius: 5
          )
        ]
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: background,
              shape: BoxShape.circle,
            ),
            child: Icon(iconData, color: Colors.white)
        ),
        const SizedBox(height: 8),
        Text(title.toUpperCase(), style: Theme.of(context).textTheme.headline6)
      ],
    ),
  );
}
