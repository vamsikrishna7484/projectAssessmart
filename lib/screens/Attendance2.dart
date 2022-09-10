import 'dart:ui';
import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_work/models/Information.dart';
import 'package:flutter/material.dart';

class Attendance2 extends StatefulWidget {
  Attendance2({Key? key}) : super(key: key);

  @override
  State<Attendance2> createState() => _Attendance2State();
}

class _Attendance2State extends State<Attendance2> {
  String? dept, subject, year, sem, period, section, acyear;
  int? Otp;
  int min = 1000, max = 9999;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Attendance"),
          centerTitle: true,
          backgroundColor: Colors.teal,
        ),
        body: Container(
          padding: EdgeInsets.all(15.0),
          child: Column(
            //direction: Axis.vertical,
            children: [
              Row(children: [
                Flexible(
                  flex: 1,
                  child: DecoratedBox(
                    decoration: BoxDecoration(border: Border.all(width: 2.0)),
                    child: DropdownButton(
                        dropdownColor: Colors.tealAccent,
                        value: dept,
                        isExpanded: true,
                        iconEnabledColor: Colors.redAccent,
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        underline: Container(),
                        alignment: Alignment.topCenter,
                        menuMaxHeight: 150.0,
                        hint: Text("--  Department  --"),
                        items: sampleData.Departments.map((itemsname) {
                          return (DropdownMenuItem(
                            child: Text(itemsname),
                            value: itemsname,
                          ));
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            dept = newValue!;
                          });
                        }),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Flexible(
                  flex: 1,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                        width: 2.0,
                      ),
                    ),
                    child: DropdownButton(
                        style: TextStyle(backgroundColor: Colors.blueGrey),
                        dropdownColor: Colors.tealAccent,
                        value: subject,
                        isExpanded: true,
                        iconEnabledColor: Colors.redAccent,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8.0)),
                        underline: Container(),
                        alignment: Alignment.topCenter,
                        menuMaxHeight: 150.0,
                        hint: const Text("-- SUBJECTS   --"),
                        items: sampleData.Subjects.map((itemsname) {
                          return (DropdownMenuItem(
                            child: Text(
                              itemsname,
                              textAlign: TextAlign.center,
                            ),
                            value: itemsname,
                          ));
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            subject = newValue!;
                          });
                        }),
                  ),
                ),
              ]),
              SizedBox(
                height: 15.0,
              ),
              Row(children: [
                Flexible(
                  flex: 1,
                  child: DecoratedBox(
                    decoration: BoxDecoration(border: Border.all(width: 2.0)),
                    child: DropdownButton(
                        dropdownColor: Colors.tealAccent,
                        value: section,
                        isExpanded: true,
                        iconEnabledColor: Colors.redAccent,
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        underline: Container(),
                        alignment: Alignment.topCenter,
                        menuMaxHeight: 150.0,
                        hint: Text("--  Section  --"),
                        items: sampleData.Sections.map((itemsname) {
                          return (DropdownMenuItem(
                            child: Text(itemsname),
                            value: itemsname,
                          ));
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            section = newValue!;
                          });
                        }),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Flexible(
                  flex: 1,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                        width: 2.0,
                      ),
                    ),
                    child: DropdownButton(
                        dropdownColor: Colors.tealAccent,
                        value: period,
                        isExpanded: true,
                        iconEnabledColor: Colors.redAccent,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8.0)),
                        underline: Container(),
                        alignment: Alignment.topCenter,
                        menuMaxHeight: 150.0,
                        hint: const Text("-- Period   --"),
                        items: sampleData.Periods.map((itemsname) {
                          return (DropdownMenuItem(
                            child: Text(itemsname),
                            value: itemsname,
                          ));
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            period = newValue!;
                          });
                        }),
                  ),
                ),
              ]),
              SizedBox(
                height: 25.0,
              ),
              Row(children: [
                Flexible(
                  flex: 1,
                  child: DecoratedBox(
                    decoration: BoxDecoration(border: Border.all(width: 2.0)),
                    child: DropdownButton(
                        dropdownColor: Colors.tealAccent,
                        value: acyear,
                        isExpanded: true,
                        iconEnabledColor: Colors.redAccent,
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        underline: Container(),
                        alignment: Alignment.topCenter,
                        menuMaxHeight: 150.0,
                        hint: Text("--  Academic Year  --"),
                        items: sampleData.AcYear.map((itemsname) {
                          return (DropdownMenuItem(
                            child: Text(itemsname),
                            value: itemsname,
                          ));
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            acyear = newValue!;
                          });
                        }),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Flexible(
                  flex: 1,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                        width: 2.0,
                      ),
                    ),
                    child: DropdownButton(
                        dropdownColor: Colors.tealAccent,
                        value: sem,
                        isExpanded: true,
                        iconEnabledColor: Colors.redAccent,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8.0)),
                        underline: Container(),
                        alignment: Alignment.topCenter,
                        menuMaxHeight: 150.0,
                        hint: const Text("-- semester   --"),
                        items: sampleData.Semester.map((itemsname) {
                          return (DropdownMenuItem(
                            child: Text(itemsname),
                            value: itemsname,
                          ));
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            sem = newValue!;
                          });
                        }),
                  ),
                ),
              ]),
              SizedBox(
                height: 25.0,
              ),
              Row(children: [
                Flexible(
                  flex: 1,
                  child: DropdownButton(
                      dropdownColor: Colors.tealAccent,
                      value: year,
                      isExpanded: true,
                      iconEnabledColor: Colors.redAccent,
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      underline: Container(),
                      alignment: Alignment.topCenter,
                      menuMaxHeight: 150.0,
                      hint: Text("--  Year  --"),
                      items: sampleData.Year.map((itemsname) {
                        return (DropdownMenuItem(
                          child: Text(itemsname),
                          value: itemsname,
                        ));
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          year = newValue!;
                        });
                      }),
                ),
              ]),
              Row(children: [
                Flexible(
                  flex: 1,
                  child: DecoratedBox(
                      decoration: BoxDecoration(border: Border.all(width: 1.0)),
                      child: TextField(
                        keyboardType: TextInputType.number,
                        readOnly: true,
                        decoration: InputDecoration(hintText: Otp.toString()),
                      )),
                ),
                const SizedBox(
                  width: 15,
                ),
                Flexible(
                  flex: 1,
                  child: Container(
                    child: Row(
                      children: [
                        ElevatedButton(
                            onPressed: () async {
                              Timestamp now = Timestamp.now();
                              DateTime dateNow = now.toDate();
                              setState(() {
                                Otp = min + Random().nextInt(max - min);
                              });
                              CollectionReference temp = FirebaseFirestore
                                  .instance
                                  .collection(dept!)
                                  .doc(year)
                                  .collection("Sections")
                                  .doc(section)
                                  .collection("Subjects");
                              temp
                                  .doc(subject)
                                  .collection('Attendance')
                                  .doc(
                                      '${dateNow.day}-${dateNow.month}-${dateNow.year}')
                                  .set({
                                "OTP": Otp,
                                "Section": section,
                                "Period": period,
                                "Department": dept,
                                "Academic year": acyear,
                                "Sem": sem,
                                "Subject": subject,
                                "Time":
                                    '${dateNow.hour}:${dateNow.minute}:${dateNow.second}',
                                "fId": FirebaseAuth.instance.currentUser!.uid
                              });
                            },
                            child: Text("Generate OTP")),
                        SizedBox(
                          width: 15.0,
                        ),
                      ],
                    ),
                  ),
                ),
              ]),
            ],
          ),
        ));
  }
}
