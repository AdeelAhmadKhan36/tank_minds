import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore package

import '../Widgets/Rounfbutton.dart';

class Cases_Screen extends StatefulWidget {
  const Cases_Screen({super.key});

  @override
  State<Cases_Screen> createState() => _Cases_ScreenState();
}

class _Cases_ScreenState extends State<Cases_Screen> {
  final _formKey = GlobalKey<FormState>();
  bool Loading = false;

  // Firestore instance
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Controllers for text form fields
  TextEditingController previousDateController = TextEditingController();
  TextEditingController caseTitleController = TextEditingController();
  TextEditingController proceedingController = TextEditingController();
  TextEditingController courteController = TextEditingController();
  TextEditingController comingProceedingController = TextEditingController();
  TextEditingController lawyerNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cases_Screen'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormFieldWithLabel(label: 'Previous Date', controller: previousDateController),
                TextFormFieldWithLabel(label: 'Case Title', controller: caseTitleController),
                TextFormFieldWithLabel(label: 'Proceeding', controller: proceedingController),
                TextFormFieldWithLabel(label: 'Courte', controller: courteController),
                TextFormFieldWithLabel(label: 'Coming Proceeding', controller: comingProceedingController),
                TextFormFieldWithLabel(label: 'Lawyer Name', controller: lawyerNameController),
                SizedBox(height: 20),
                SizedBox(height: 20),
                RoundButton(
                  title: 'Submit',
                  loading: Loading,
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      // Form is valid, save data to Firestore
                      setState(() {
                        Loading = true;
                      });

                      try {
                        // Create a new document in the "Admin-Data" collection with a unique ID
                        DocumentReference documentRef = firestore.collection('Admin-Data').doc();

                        // Set data in the document using the controllers
                        await documentRef.set({
                          'Previous Date': previousDateController.text,
                          'Case Title': caseTitleController.text,
                          'Proceeding': proceedingController.text,
                          'Courte': courteController.text,
                          'Coming Proceeding': comingProceedingController.text,
                          'Lawyer Name': lawyerNameController.text,
                        });

                        setState(() {
                          Loading = false;
                        });

                        // Navigate or show a success message
                      } catch (e) {
                        setState(() {
                          Loading = false;
                        });
                        // Handle the error
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Dispose the controllers
    previousDateController.dispose();
    caseTitleController.dispose();
    proceedingController.dispose();
    courteController.dispose();
    comingProceedingController.dispose();
    lawyerNameController.dispose();

    super.dispose();
  }
}

class TextFormFieldWithLabel extends StatelessWidget {
  final String label;
  final TextEditingController controller;

  TextFormFieldWithLabel({required this.label, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        TextFormField(
          controller: controller,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter some text';
            }
            return null;
          },
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
