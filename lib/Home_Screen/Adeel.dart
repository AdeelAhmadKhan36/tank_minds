import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tank_minds/AdminPanel/Users/Client.dart';
import 'package:tank_minds/AdminPanel/Users/Layer.dart';
import 'package:tank_minds/AdminPanel/Users/Admin.dart';
import 'package:tank_minds/Utilities/utils.dart';





class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isObscure3 = true;
  bool visible = false;
  bool loading = false;
  bool _hasError = false;
  final _formkey = GlobalKey<FormState>();
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();


  List<String> categories = ['Admin', 'Lawyer', 'Client'];
  String selectedCategory = 'Client'; // Default selected category


  void _login() async {
    setState(() {
      loading = true; // Set loading to true before async operations
    });
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );


      // Check user role and navigate to corresponding page
      String userEmail = userCredential.user!.email ?? "";
      String selectedCategoryLowerCase = selectedCategory.toLowerCase();
      if (selectedCategoryLowerCase == "admin") {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AdminPanel()),).then((value) =>
        {
          Utils().toastmessage('Admin Logged in Sucessfully'),
          setState(() {
            loading = false;
          })
        }).onError((error, stackTrace) =>
        {
          Utils().toastmessage(error.toString()),

          setState(() {
            loading = false;
          })
        });
      } else if (selectedCategoryLowerCase == "lawyer") {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LayerScreen()),
        );
      } else if (selectedCategoryLowerCase == "client") {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ClientView()),
        );
      }
    } catch (e) {
      setState(() {
        loading = false; // Set loading to false if an error occurs
      });
      print("Error during login: $e");
      // Handle login errors here
    }
  }



    final _auth = FirebaseAuth.instance;
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                color: Colors.orangeAccent[700],
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                height: MediaQuery
                    .of(context)
                    .size
                    .height * 0.70,
                child: Center(
                  child: Container(
                    margin: EdgeInsets.all(12),
                    child: Form(
                      key: _formkey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            "Login",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 40,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: emailController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Email',
                              enabled: true,
                              contentPadding: const EdgeInsets.only(
                                  left: 14.0, bottom: 8.0, top: 8.0),
                              focusedBorder: OutlineInputBorder(
                                borderSide: new BorderSide(color: Colors.white),
                                borderRadius: new BorderRadius.circular(10),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: new BorderSide(color: Colors.white),
                                borderRadius: new BorderRadius.circular(10),
                              ),
                            ),
                            validator: (value) {
                              if (value!.length == 0) {
                                return "Email cannot be empty";
                              }
                              if (!RegExp(
                                  "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                  .hasMatch(value)) {
                                return ("Please enter a valid email");
                              } else {
                                return null;
                              }
                            },
                            onSaved: (value) {
                              emailController.text = value!;
                            },
                            keyboardType: TextInputType.emailAddress,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: passwordController,
                            obscureText: _isObscure3,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                  icon: Icon(_isObscure3
                                      ? Icons.visibility
                                      : Icons.visibility_off),
                                  onPressed: () {
                                    setState(() {
                                      _isObscure3 = !_isObscure3;
                                    });
                                  }),
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Password',
                              enabled: true,
                              contentPadding: const EdgeInsets.only(
                                  left: 14.0, bottom: 8.0, top: 15.0),
                              focusedBorder: OutlineInputBorder(
                                borderSide: new BorderSide(color: Colors.white),
                                borderRadius: new BorderRadius.circular(10),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: new BorderSide(color: Colors.white),
                                borderRadius: new BorderRadius.circular(10),
                              ),
                            ),
                            validator: (value) {
                              RegExp regex = new RegExp(r'^.{6,}$');
                              if (value!.isEmpty) {
                                return "Password cannot be empty";
                              }
                              if (!regex.hasMatch(value)) {
                                return ("please enter valid password min. 6 character");
                              } else {
                                return null;
                              }
                            },
                            onSaved: (value) {
                              passwordController.text = value!;
                            },
                            keyboardType: TextInputType.emailAddress,
                          ),
                          //Here is Text form field
                          SizedBox(height: 40),

                          DropdownButtonFormField<String>(
                            value: selectedCategory,
                            items: categories.map((category) {
                              return DropdownMenuItem<String>(
                                value: category,
                                child: Text(category),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedCategory = value!;
                              });
                            },
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Select Category',
                              enabled: true,
                              contentPadding: const EdgeInsets.only(
                                  left: 14.0, bottom: 8.0, top: 15.0),
                              focusedBorder: OutlineInputBorder(
                                borderSide: new BorderSide(color: Colors.white),
                                borderRadius: new BorderRadius.circular(10),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: new BorderSide(color: Colors.white),
                                borderRadius: new BorderRadius.circular(10),
                              ),
                            ),
                          ),

                          SizedBox(
                            height: 20,
                          ),
                          MaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(20.0))),
                            elevation: 5.0,
                            height: 40,
                            onPressed: () {
                              setState(() {
                                visible = true;
                              });
                              signIn(
                                  emailController.text,
                                  passwordController.text);
                            },
                            child: Text(
                              "Login here",
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            color: Colors.white,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Visibility(
                              maintainSize: true,
                              maintainAnimation: true,
                              maintainState: true,
                              // visible: visible,
                              child: Container(
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ))),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

            ],
          ),
        ),
      );
    }
//RouteCopy
//   void route() {
//
//     User? user = FirebaseAuth.instance.currentUser;
//     var kk = FirebaseFirestore.instance
//         .collection('users')
//         .doc(user!.uid)
//         .get()
//         .then((DocumentSnapshot documentSnapshot) {
//       if (documentSnapshot.exists) {
//
//         print("Hello ${documentSnapshot.toString()}");
//         print("Hell0 ${documentSnapshot.get("Admin")}");
//
//         if (documentSnapshot.get('rool') == "Lawyer") {
//           Navigator.push(context,MaterialPageRoute(builder: (context)=>LayerScreen()));
//
//         }else{
//          Navigator.push(context,MaterialPageRoute(builder: (context)=>ClientView()));
//         }
//       } else {
//         print('Document does not exist on the database');
//       }
//     });
//   }

    void route_login(BuildContext context) {
      // Pass the 'context' as a parameter
      User? user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        // Handle the case where the user is not authenticated
        // return;
      }

      print("Helle collectionName 1 ${user!.uid}");

      String collectionName = user.uid == 'adminlogin' ? 'Admin' : 'users';

      print("Helle collectionName 2 ${collectionName}");

      FirebaseFirestore.instance
          .collection(collectionName)
          .doc(user.uid)
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          String role = documentSnapshot.get('role');

          if (role == 'Admin') {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => AdminPanel()));
          } else if (role == 'Lawyer') { // Corrected 'rool' to 'role'
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LayerScreen()));
          } else {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => ClientView()));
          }
        } else {
          print('Document does not exist');
        }
      });
    }


    void signIn(String email, String password) async {
      if (_formkey.currentState!.validate()) {
        try {
          UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: email,
            password: password,
          );
          // Call _login instead of route
          _login(); // Directly navigate after successful login
        } on FirebaseAuthException catch (e) {
          Utils().toastmessage("Something goes wrong");

          setState(() {
            loading = false; // Set loading to false if an error occurs
          });
          if (e.code == 'user-not-found') {
            print('No user found for that email.');
          } else if (e.code == 'wrong-password') {
            print('Wrong password provided for that user.');
          }
        }
      }
    }
  }


