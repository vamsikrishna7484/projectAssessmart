import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_work/models/usermodel.dart';
import 'package:my_work/screens/home.dart';

import '../models/Information.dart';

class AttendanceStats extends StatefulWidget {
  AttendanceStats({Key? key}) : super(key: key);

  @override
  State<AttendanceStats> createState() => _AttendanceStatsState();
}

class _AttendanceStatsState extends State<AttendanceStats> {
  String? year, dept, subject, section;
  TextEditingController DayController = new TextEditingController();
  TextEditingController YearController = new TextEditingController();
  TextEditingController MonthController = new TextEditingController();
  @override
  build(BuildContext context) {
    DateTime? pickedDate;
    return Scaffold(
      appBar: AppBar(
        title: Text("Attendance Statistics"),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: Column(
          //mainAxisSize: MainAxisSize.min,
          children: [
            DecoratedBox(
              decoration: BoxDecoration(border: Border.all(width: 2.0)),
              child: DropdownButton(
                  dropdownColor: Colors.tealAccent,
                  value: year,
                  isExpanded: true,
                  iconEnabledColor: Colors.redAccent,
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  underline: Container(),
                  alignment: Alignment.topCenter,
                  menuMaxHeight: 150.0,
                  hint: Text("--  Academic Year  --"),
                  items: sampleData.AcYear.map((itemsname) {
                    return (DropdownMenuItem(
                      child: SizedBox(
                        width: 100.0,
                        child: Text(
                          itemsname,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      value: itemsname,
                    ));
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      year = newValue!;
                    });
                  }),
            ),
            SizedBox(
              height: 40,
            ),
            DecoratedBox(
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
                      child: SizedBox(
                        width: 100.0,
                        child: Text(
                          itemsname,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      value: itemsname,
                    ));
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      dept = newValue!;
                    });
                  }),
            ),
            SizedBox(
              height: 40,
            ),
            SizedBox(
              height: 30,
              child: Row(
                children: [
                  SizedBox(
                    width: 70,
                    child: TextField(
                      controller: DayController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        label: Text("Day"),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 70,
                    child: TextField(
                      controller: MonthController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        label: Text("Month"),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 70,
                    child: TextField(
                      controller: YearController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        label: Text("Year"),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 40,
            ),
            DecoratedBox(
              decoration: BoxDecoration(border: Border.all(width: 2.0)),
              child: DropdownButton(
                  dropdownColor: Colors.tealAccent,
                  value: subject,
                  isExpanded: true,
                  iconEnabledColor: Colors.redAccent,
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  underline: Container(),
                  alignment: Alignment.topCenter,
                  menuMaxHeight: 150.0,
                  hint: Text("--  Subject  --"),
                  items: sampleData.Subjects.map((itemsname) {
                    return (DropdownMenuItem(
                      child: SizedBox(
                        width: 100.0,
                        child: Text(
                          itemsname,
                          textAlign: TextAlign.center,
                        ),
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
            SizedBox(
              height: 40,
            ),
            DecoratedBox(
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
                      child: SizedBox(
                        width: 100.0,
                        child: Text(
                          itemsname,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      value: itemsname,
                    ));
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      section = newValue!;
                    });
                  }),
            ),
            SizedBox(
              height: 40,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SubmittedIds(
                              key: null,
                              date:
                                  '${DayController.text}-${int.parse(MonthController.text)}-${YearController.text}',
                              Subject: subject!,
                              Section: section!,
                              Department: dept!)));
                },
                child: Text("View Attendance"))
          ],
        ),
      ),
    );
  }
}

class SubmittedIds extends StatefulWidget {
  SubmittedIds(
      {Key? key,
      required this.date,
      required this.Subject,
      required this.Section,
      required this.Department});
  final String date;
  final String Subject;
  final String Section;
  final String Department;

  @override
  State<SubmittedIds> createState() => _SubmittedIdsState();
}

class _SubmittedIdsState extends State<SubmittedIds> {
  QuerySnapshot? qt;
  List<String> Ids = [];
  List<String> Periods = [];
  List<String> timestamps = [];
  DocumentReference? user_db;
  void initState() {
    super.initState();
  }

  UserModel loggedinuser = new UserModel();
  Future getData() async {
    /*user_db = FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid);
    await user_db!.get().then((value) {
      this.loggedinuser = UserModel.fromMap(value.data());
    });*/
    print(widget.Department);
    print(widget.Section);
    print(widget.date);
    print(widget.Subject);
    print(Ids);
    await FirebaseFirestore.instance
        .collection(widget.Department)
        .doc("E3")
        .collection("Sections")
        .doc(widget.Section)
        .collection("Subjects")
        .doc(widget.Subject)
        .collection('Attendance')
        .doc(widget.date)
        .collection("submissions")
        .get()
        .then((value) {
      value.docs.forEach((element) {
        Ids.add(element["Id"]);
        Periods.add(element["Period"]);
        timestamps.add(element["timeStamp"]);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Submitted Members"),
        leading: Text("date:${widget.date}"),
        bottom: PreferredSize(
            child: Text(
                "Department:${widget.Department}  Section:${widget.Section} Subject:${widget.Subject}"),
            preferredSize: Size(double.infinity, 20)),
        centerTitle: true,
        backgroundColor: Colors.blueAccent.shade400,
      ),
      body: FutureBuilder(
          future: getData(),
          builder: (context, snapshot) {
            return ListView.builder(
                itemCount: Ids.length,
                itemBuilder: (BuildContext context, index) {
                  return Center(
                    child: Card(
                      child: Row(
                        children: [
                          Container(
                            child: Text(
                              "Id:-${Ids[index]}\t Period:-${Periods[index]}\t ${timestamps[index]}",
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                });
          }),
    );
  }
}
