import 'dart:ui';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_work/models/Information.dart';
import 'package:my_work/models/UserAttendanceModel.dart';
import 'package:my_work/models/usermodel.dart';
import 'package:my_work/screens/takepicturescreen.dart';

class Attendance extends StatefulWidget {
  const Attendance({
    key,
    required this.img,
  });
  final XFile? img;
  @override
  State<Attendance> createState() => _AttendanceState();
}

class _AttendanceState extends State<Attendance> {
  String? subj, Period;
  final OtpController = TextEditingController();
  User? user = FirebaseAuth.instance.currentUser;
  UserAttendanceModel usr_record = UserAttendanceModel();
  DocumentReference? user_db;
  UserModel loggedinuser = new UserModel();
  late List<String> times = [];

  @override
  void initState() {
    super.initState();
    user_db = FirebaseFirestore.instance.collection("users").doc(user!.uid);

    user_db!.get().then((value) {
      this.loggedinuser = UserModel.fromMap(value.data());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Attendance"),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Container(
        decoration: BoxDecoration(color: Color.fromARGB(255, 96, 96, 96)),
        child: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            Flexible(
                flex: 4,
                child: (widget.img == null)
                    ? Container(
                        margin: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            color: Colors.white),
                        padding: const EdgeInsets.all(20.0),
                        child: Center(
                            child: IconButton(
                          color: Colors.teal,
                          hoverColor: Colors.blueGrey,
                          onPressed: () async {
                            WidgetsFlutterBinding.ensureInitialized();
                            // Obtain a list of the available cameras on the device.
                            final cameras = await availableCameras();
                            // Get a specific camera from the list of available cameras.
                            late CameraDescription firstCamera;
                            if (cameras.length >= 2) {
                              firstCamera = cameras[1];
                            } else {
                              firstCamera = cameras[0];
                            }
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => TakePictureScreen(
                                        key: null, camera: firstCamera)));
                          },
                          icon: Icon(Icons.camera_alt),
                          iconSize: 40,
                        )),
                      )
                    : Container(
                        child: Image.file(File(widget.img!.path)),
                      )),
            Flexible(
              flex: 1,
              child: Container(
                margin: EdgeInsets.all(15.0),
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.white),
                child: DropdownButton(
                    dropdownColor: Colors.blueGrey,
                    value: subj,
                    style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold),
                    elevation: 15,
                    borderRadius: BorderRadius.circular(10.0),
                    isExpanded: true,
                    iconEnabledColor: Color.fromARGB(255, 69, 58, 58),
                    //borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    underline: Container(),
                    alignment: Alignment.topCenter,
                    menuMaxHeight: 150.0,
                    hint: Text(
                      "--  subject  --",
                      style: TextStyle(color: Colors.black),
                    ),
                    items: sampleData.Subjects.map((itemsname) {
                      return (DropdownMenuItem(
                        child: Text(
                          itemsname,
                          style: TextStyle(color: Colors.blue),
                        ),
                        value: itemsname,
                      ));
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        subj = newValue!;
                      });
                    }),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Flexible(
              flex: 1,
              child: Container(
                margin: EdgeInsets.all(15.0),
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.white),
                child: DropdownButton(
                    dropdownColor: Colors.blueGrey,
                    value: Period,
                    style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold),
                    elevation: 15,
                    borderRadius: BorderRadius.circular(10.0),
                    isExpanded: true,
                    iconEnabledColor: Color.fromARGB(255, 69, 58, 58),
                    underline: Container(),
                    alignment: Alignment.topCenter,
                    menuMaxHeight: 150.0,
                    hint: Text(
                      "--  Period  --",
                      style: TextStyle(color: Colors.black),
                    ),
                    items: sampleData.Periods.map((itemsname) {
                      return (DropdownMenuItem(
                        child: Text(
                          itemsname,
                          style: TextStyle(color: Colors.blue),
                        ),
                        value: itemsname,
                      ));
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        Period = newValue!;
                      });
                    }),
              ),
            ),
            SizedBox(
              width: 40,
            ),
            Flexible(
                flex: 1,
                child: Container(
                  margin: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                    color: Colors.white,
                  ),
                  child: TextField(
                    controller: OtpController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      label: Text("OTP"),
                    ),
                  ),
                )),
            Flexible(
                flex: 1,
                child: ElevatedButton(
                    onPressed: () async {
                      Timestamp now = Timestamp.now();
                      DateTime dateNow = now.toDate();
                      String? OTP, fID, fname;
                      user_db = FirebaseFirestore.instance
                          .collection("users")
                          .doc(user!.uid);
                      await user_db!.get().then((value) {
                        loggedinuser = UserModel.fromMap(value.data());
                      });
                      print(loggedinuser.department);
                      print(loggedinuser.section);
                      print(subj);
                      await FirebaseFirestore.instance
                          .collection(loggedinuser.department!)
                          .doc("E3")
                          .collection("Sections")
                          .doc(loggedinuser.section)
                          .collection("Subjects")
                          .doc(subj!)
                          .collection('Attendance')
                          .doc(
                              '${dateNow.day}-${dateNow.month}-${dateNow.year}')
                          .get()
                          .then((value) {
                        OTP = value["OTP"].toString();
                        print(OTP);
                        fID = value['fId'];
                        print(fID);
                        String time = value['Time'];
                        print(time);
                        times = time.split(':');
                        print(times);
                      });
                      print(OTP);
                      print(OtpController.text);
                      if (OTP == OtpController.text) {
                        if (validateTime(dateNow, times)) {
                          print("hello");
                          await FirebaseFirestore.instance
                              .collection("faculty")
                              .doc(fID)
                              .collection("Subjects")
                              .doc(subj)
                              .collection("Sections")
                              .doc(loggedinuser.section)
                              .collection("Attendance")
                              .doc(loggedinuser.userId)
                              .set({
                            "name": loggedinuser.userName,
                            "timestamp": now,
                            "date":
                                '${dateNow.day}-${dateNow.month}-${dateNow.year}'
                          });
                          AttendStore(Period!, subj!, OtpController.text);
                          AttendStore_faculty();
                          Fluttertoast.showToast(
                              msg: "Attendance Submitted Successfully");
                        } else {
                          Fluttertoast.showToast(msg: "Otp TimeOut");
                        }
                        Fluttertoast.showToast(
                            msg: "Incorrect Otp Check Details");
                      }
                    },
                    child: Text("Submit Attendance"))),
          ],
        ),
      ),
    );
  }

  void AttendStore(String? _period, String? _subject, String? _otp) async {
    DateTime now = new DateTime.now();
    String date = new DateTime(now.day, now.month, now.year).toString();
    usr_record.date = date;
    usr_record.Period = _period;
    usr_record.UserId = loggedinuser.userId;
    usr_record.UserName = loggedinuser.userName;
    usr_record.Section = loggedinuser.section;
    usr_record.Subject = _subject;
    usr_record.department = loggedinuser.department;
    usr_record.AId = "hello";
    await user_db!.collection("Attendance-History").add(usr_record.toMap());
  }

  void AttendStore_faculty() async {
    DateTime now = new DateTime.now();
    String ts = now.toString();
    await FirebaseFirestore.instance
        .collection(loggedinuser.department!)
        .doc("E3")
        .collection("Sections")
        .doc(loggedinuser.section)
        .collection("Subjects")
        .doc(subj!)
        .collection('Attendance')
        .doc('${now.day}-${now.month}-${now.year}')
        .collection("submissions")
        .doc(loggedinuser.userId)
        .set({
      "name": loggedinuser.userName,
      "Id": loggedinuser.userId,
      "timeStamp": ts,
      "Period": Period,
      "Subject": subj
    });
  }

  bool validateTime(DateTime userTime, List<String> facultyTime) {
    if ((userTime.hour == int.parse(facultyTime[0])) &&
        (userTime.minute == int.parse(facultyTime[1]))) {
      return true;
    } else if ((userTime.hour == int.parse(facultyTime[0])) &&
        (userTime.minute == int.parse(facultyTime[1]) + 1)) {
      if (userTime.second < int.parse(facultyTime[2])) {
        return true;
      } else {
        return false;
      }
    } else if ((userTime.hour == int.parse(facultyTime[0]) + 1) &&
        (userTime.minute == 00)) {
      if (userTime.second < int.parse(facultyTime[2])) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }
}
