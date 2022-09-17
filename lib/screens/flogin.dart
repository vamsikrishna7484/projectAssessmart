import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FLogin extends StatefulWidget {
  const FLogin({Key? key}) : super(key: key);

  @override
  State<FLogin> createState() => _FLoginState();
}

class _FLoginState extends State<FLogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: const Text("Login to Your Account"),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: const BoxConstraints(),
          child: const Padding(
            padding: EdgeInsets.all(30),
            child: LoginForm(),
          ),
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({key});

  @override
  LoginFormState createState() {
    return LoginFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class LoginFormState extends State<LoginForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final emailController = new TextEditingController();
  final PasswordContoller = new TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isObscure = true;
  String? errorMessage;
  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    FirebaseAuth _auth = FirebaseAuth.instance;
    var wth = MediaQuery.of(context).size.width;
    return Center(
      child: SizedBox(
        width: min(400, wth),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  icon: Icon(Icons.person),
                  hintText: 'Enter your Username/ID',
                  labelText: 'Username/ID *',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Username/ID is required';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                obscureText: _isObscure,
                controller: PasswordContoller,
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
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Password is required';
                  }
                  return null;
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Center(
                  child: SizedBox(
                      height: 35,
                      width: 200,
                      child: ElevatedButton(
                        style:
                            ElevatedButton.styleFrom(primary: Colors.redAccent),
                        onPressed: () async {
                          // Validate returns true if the form is valid, or false otherwise.
                          if (_formKey.currentState!.validate()) {
                            // If the form is valid, display a snackbar. In the real world,
                            // you'd often call a server or save the information in a database.
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Processing Data')),
                            );
                            await FirebaseFirestore.instance
                                .collection("faculty")
                                .where('email', isEqualTo: emailController.text)
                                .get()
                                .then((value) async {
                              if (value.docs.length >= 1) {
                                try {
                                  await _auth.signInWithEmailAndPassword(
                                      email: emailController.text,
                                      password: PasswordContoller.text);
                                  Navigator.pushNamed(context, '/fhome');
                                } on FirebaseAuthException catch (error) {
                                  switch (error.code) {
                                    case "invalid-email":
                                      errorMessage =
                                          "Your email address appears to be malformed.";

                                      break;
                                    case "wrong-password":
                                      errorMessage = "Your password is wrong.";
                                      break;
                                    case "user-not-found":
                                      errorMessage =
                                          "User with this email doesn't exist.";
                                      break;
                                    case "user-disabled":
                                      errorMessage =
                                          "User with this email has been disabled.";
                                      break;
                                    case "too-many-requests":
                                      errorMessage = "Too many requests";
                                      break;
                                    case "operation-not-allowed":
                                      errorMessage =
                                          "Signing in with Email and Password is not enabled.";
                                      break;
                                    default:
                                      errorMessage =
                                          "An undefined Error happened.";
                                  }
                                  Fluttertoast.showToast(msg: errorMessage!);
                                }
                              }
                            });
                          }
                        },
                        child: const Text('Login'),
                      )),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 10.0),
                  child: Center(
                    child: SizedBox(
                      height: 35,
                      width: 200,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.grey,
                        ),
                        onPressed: () {},
                        child: const Text('Forgot Password'),
                      ),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
