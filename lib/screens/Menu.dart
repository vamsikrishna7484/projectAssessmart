import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_work/screens/Attendance2.dart';
import 'package:my_work/screens/Contact.dart';
import 'package:my_work/screens/lab_verfication.dart';
import 'package:my_work/screens/subjectRegister.dart';

class Menu extends StatefulWidget {
  Menu({Key? key}) : super(key: key);

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  String? fname;
  //CollectionReference? facultycollection;
  void initState() {
    super.initState();
  }

  @override
  build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Assessmart"),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: ListView(padding: EdgeInsets.zero, children: [
          const SizedBox(
            height: 70,
            child: DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.indigo,
                ),
                padding: EdgeInsets.all(20.0),
                child: Text(
                  'Assessmart',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                )),
          ),
          Card(
            child: ListTile(
              leading: const Icon(
                Icons.app_registration,
                color: Colors.red,
              ),
              title: const Text('Register Subject'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => subjectRegister()));
              },
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(
                Icons.logout,
                color: Colors.red,
              ),
              title: const Text('Logout'),
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pop(context);
                Navigator.pushNamed(context, '/home');
              },
            ),
          ),
        ]),
      ),
      body: Center(
        child: Column(
          children: [
            Text("Welcome "),
            Container(
              margin: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.blue),
              child: Column(
                children: [
                  Column(
                    children: [
                      IconButton(
                        iconSize: 130,
                        color: Colors.white,
                        splashColor: Colors.black,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Attendance2()));
                        },
                        icon: const Icon(
                          Icons.library_books,
                          semanticLabel: "Attendance",
                        ),
                      ),
                      const Text(
                        "Attendance",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.purple),
              child: Column(
                children: [
                  Column(
                    children: [
                      IconButton(
                        iconSize: 130,
                        color: Colors.white,
                        splashColor: Colors.black,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Lab_Home()));
                        },
                        icon: Icon(
                          Icons.keyboard,
                          semanticLabel: "Coding Lab",
                        ),
                      ),
                      Text(
                        "Coding Lab",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.blueGrey),
              child: Column(
                children: [
                  Column(
                    children: [
                      IconButton(
                        iconSize: 130,
                        color: Colors.white,
                        splashColor: Colors.black,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Contact()));
                        },
                        icon: Icon(
                          Icons.assignment_ind,
                          semanticLabel: "Contact",
                        ),
                      ),
                      Text(
                        "Contact",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
