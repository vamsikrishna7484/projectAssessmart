import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_work/models/usermodel.dart';
//import 'package:my_work/screens/home_screen.dart';
import 'dart:math';

import 'package:my_work/screens/login.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text("SIGN UP for SmartAccess"),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: const BoxConstraints(),
          child: const Padding(
            padding: EdgeInsets.all(30),
            child: RegistrationForm(),
          ),
        ),
      ),
    );
  }
}

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({key});

  @override
  RegistrationFormState createState() {
    return RegistrationFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class RegistrationFormState extends State<RegistrationForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  String? errorMessage;
  bool _isObscure = true;
  //editing controller
  final userId = new TextEditingController();
  final password = new TextEditingController();
  final userName = new TextEditingController();
  String department = "CSE";
  final email = new TextEditingController();
  String SECTION = "Section 1";
  String? role, section = 'Section 1', dept = 'CSE';
  @override
  Widget build(BuildContext context) {
    var wth = MediaQuery.of(context).size.width;
    // Build a Form widget using the _formKey created above.
    return Center(
      child: SizedBox(
        width: min(400, wth),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  icon: Icon(Icons.person),
                  hintText: 'Enter your Username/ID',
                  labelText: 'Username/ID *',
                ),
                // onSaved: (String? value) {
                //   userId.text = value!;
                // },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Username/ID is required';
                  }
                  userId.text = value;
                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                obscureText: _isObscure,
                decoration: InputDecoration(
                  icon: const Icon(Icons.password),
                  hintText: 'Enter your Password',
                  labelText: 'Password *',
                  suffixIcon: IconButton(
                      icon: Icon(
                          _isObscure ? Icons.visibility : Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          _isObscure = !_isObscure;
                        });
                      }),
                ),
                // onSaved: (String? value) {
                //   password.text = value!;
                // },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Password is required';
                  }
                  password.text = value;
                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  icon: Icon(Icons.person),
                  hintText: 'Enter your Name',
                  labelText: 'Name *',
                ),
                // onSaved: (String? value) {
                //   userName.text = value!;
                // },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Name is required';
                  }
                  userName.text = value;
                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Expanded(child: Text('Section :')),
                  const SizedBox(width: 10),
                  Expanded(
                    child: DropdownButton(
                      value: section,
                      borderRadius: BorderRadius.circular(8.0),
                      icon: const Icon(Icons.keyboard_arrow_down),
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                      underline: Container(
                        height: 2,
                        color: Colors.black26,
                      ),
                      items: <String>[
                        'Section 1',
                        'Section 2',
                        'Section 3',
                        'Section 4',
                        'Section 5',
                        'Section 6'
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Center(
                            child: Text(
                              value,
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          section = newValue!;
                        });
                      },
                      isExpanded: true,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  icon: Icon(Icons.email),
                  hintText: 'Enter your Email',
                  labelText: 'Email *',
                ),
                // onSaved: (String? value) {
                //   email.text = value!;
                // },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email is required';
                  }
                  if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                      .hasMatch(value)) {
                    return ("Please Enter a valid email");
                  }
                  email.text = value;
                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Expanded(child: Text('Select Department')),
                  const SizedBox(width: 10),
                  Expanded(
                    child: DropdownButton(
                      value: dept,
                      borderRadius: BorderRadius.circular(8.0),
                      icon: const Icon(Icons.keyboard_arrow_down),
                      style: const TextStyle(color: Colors.black),
                      underline: Container(
                        height: 2,
                        color: Colors.black26,
                      ),
                      items: <String>[
                        'CSE',
                        'ECE',
                        'MECH',
                        'CHE',
                        'CIVIL',
                        'MME',
                        'Mathemathics',
                        'Physics',
                        'Chemistry',
                        'Management'
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Center(
                              child: Text(
                            value,
                            style: TextStyle(color: Colors.blue),
                          )),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          dept = newValue!;
                        });
                      },
                      isExpanded: true,
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Center(
                  child: SizedBox(
                    height: 35,
                    width: 200,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.indigo),
                      onPressed: () {
                        // Validate returns true if the form is valid, or false otherwise.
                        if (_formKey.currentState!.validate()) {
                          // If the form is valid, display a snackbar. In the real world,
                          // you'd often call a server or save the information in a database.
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Processing Data')),
                          );
                        }
                        signUp(email.text, password.text);
                      },
                      child: const Text('Sign Up'),
                    ),
                  ),
                ),
              ),
              Center(
                child: RichText(
                  text: TextSpan(children: [
                    const TextSpan(
                      text: 'Already have account? ',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    TextSpan(
                        text: 'Login',
                        style: const TextStyle(
                          color: Colors.blue,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            // Navigator.pushNamed(context, '/login');
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Login()));
                          }),
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void signUp(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((value) => {postDetailsToFirestore()})
            .catchError((e) {
          Fluttertoast.showToast(msg: e!.message);
        });
      } on FirebaseAuthException catch (error) {
        switch (error.code) {
          case "invalid-email":
            errorMessage = "Your email address appears to be malformed.";
            break;
          case "wrong-password":
            errorMessage = "Your password is wrong.";
            break;
          case "user-not-found":
            errorMessage = "User with this email doesn't exist.";
            break;
          case "user-disabled":
            errorMessage = "User with this email has been disabled.";
            break;
          case "too-many-requests":
            errorMessage = "Too many requests";
            break;
          case "operation-not-allowed":
            errorMessage = "Signing in with Email and Password is not enabled.";
            break;
          default:
            errorMessage = "An undefined Error happened.";
        }
        Fluttertoast.showToast(msg: errorMessage!);
        print(error.code);
      }
    }
  }

  postDetailsToFirestore() async {
    // calling our firestore
    // calling our user model
    // sedning these values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserModel userModel = UserModel();

    // writing all the values
    userModel.email = user!.email;
    userModel.userId = userId.text;
    userModel.password = password.text;
    userModel.userName = userName.text;
    userModel.department = dept;
    userModel.email = email.text;
    userModel.section = section;
    userModel.uId = user.uid;
    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: "Account created successfully :) ");

    Navigator.pushAndRemoveUntil(
        (context),
        MaterialPageRoute(builder: (context) => const Login()),
        (route) => false);
  }
}
