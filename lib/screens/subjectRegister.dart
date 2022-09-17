import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_work/models/facultymodel.dart';
import 'package:my_work/screens/dashboard.dart';

class subjectRegister extends StatefulWidget {
  const subjectRegister({Key? key}) : super(key: key);

  @override
  State<subjectRegister> createState() => _subjectRegisterState();
}

class _subjectRegisterState extends State<subjectRegister> {
  List typeofregister = ["Theory", "Lab"];
  User? _auth = FirebaseAuth.instance.currentUser;
  String? fname;
  List<FacultyModel?> teacher = [];
  CollectionReference? Subjectcollection, facultycollection;
  int x = 0;
  void initState() {
    super.initState();
  }

  Future<void> assignTeacher() async {
    _auth = FirebaseAuth.instance.currentUser;
    await facultycollection!.where('email', isEqualTo: _auth?.email).get().then(
      (value) {
        value.docs.forEach((element) {
          teacher.add(FacultyModel.fromMap(element));
          print(teacher[0]!.name);
        });
      },
    );
  }

  String? _groupValue;
  @override
  String? section = 'Section 1', Branch = 'CSE', Subject = 'DIP', year = 'E3';
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("Subject Registration"),
        backgroundColor: Colors.deepOrange,
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.home)),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Expanded(child: Text('year :')),
              const SizedBox(width: 5),
              Expanded(
                child: DropdownButton(
                  value: year,
                  borderRadius: BorderRadius.circular(8.0),
                  icon: const Icon(Icons.keyboard_arrow_down),
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                  underline: Container(
                    height: 2,
                    color: Colors.black26,
                  ),
                  items: <String>['PUC1', 'PUC2', 'E1', 'E2', 'E3', 'E4']
                      .map<DropdownMenuItem<String>>((String value) {
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
                      year = newValue!;
                    });
                  },
                  isExpanded: true,
                ),
              )
            ],
          ),
          SizedBox(
            height: height / 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Expanded(child: Text('Branch :')),
              const SizedBox(width: 5),
              Expanded(
                child: DropdownButton(
                  value: Branch,
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
                    'CSE',
                    'ECE',
                    'EEE',
                    'Mech',
                    'Chem',
                    'CIVIL',
                    'MME'
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
                      Branch = newValue!;
                    });
                  },
                  isExpanded: true,
                ),
              )
            ],
          ),
          SizedBox(
            height: height / 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Expanded(child: Text('Section :')),
              const SizedBox(width: 5),
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
          SizedBox(
            height: height / 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Expanded(child: Text('Subject :')),
              const SizedBox(width: 5),
              Expanded(
                child: DropdownButton(
                  value: Subject,
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
                    'DIP',
                    'CDC',
                    'CNS',
                    'Data Science',
                    'Matrix Algebra',
                    'ST',
                    'Telugu'
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
                      Subject = newValue!;
                    });
                  },
                  isExpanded: true,
                ),
              )
            ],
          ),
          SizedBox(
            height: height / 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Expanded(child: Text('Subject :')),
              const SizedBox(width: 5),
              Expanded(
                child: DropdownButton(
                  value: _groupValue,
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
                    'Theory',
                    'Lab',
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
                      _groupValue = newValue!;
                    });
                  },
                  isExpanded: true,
                ),
              )
            ],
          ),
          SizedBox(
            height: height / 10,
          ),
          ElevatedButton(
            child: Text("Register Subject"),
            onPressed: () {
              showConfirmDialog(context);
            },
          )
        ],
      ),
    );
  }

  void showConfirmDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Are you sure you want to register for the subject?"),
            actions: [
              TextButton(
                  onPressed: () async {
                    print(Branch);
                    print(year);
                    Subjectcollection =
                        FirebaseFirestore.instance.collection(Branch!);
                    _auth = FirebaseAuth.instance.currentUser;
                    facultycollection =
                        FirebaseFirestore.instance.collection("faculty");
                    await facultycollection!
                        .where('email', isEqualTo: _auth?.email)
                        .get()
                        .then(
                      (value) {
                        value.docs.forEach((element) {
                          teacher.add(FacultyModel.fromMap(element));
                          print(teacher[0]!.name);
                        });
                      },
                    );
                    await Subjectcollection!
                        .doc(year)
                        .collection("Sections")
                        .doc(section)
                        .collection("Subjects")
                        .doc(Subject)
                        .set({
                      "Year": year,
                      "Section": section,
                      "Subject": Subject,
                      "facultyID": teacher[0]!.fId,
                      "facultyName": teacher[0]!.name,
                      "type": _groupValue
                    });
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  child: Text("Yes")),
              TextButton(
                onPressed: () {
                  //FirebaseFirestore.instance.collection(Branch!).doc(section).collection(Subject)
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: Text("No"),
              )
            ],
          );
        });
  }
}
