import 'package:flutter/material.dart';
import 'package:my_work/models/Information.dart';
import 'package:my_work/models/lab_data.dart';

class Lab_Home extends StatefulWidget {
  Lab_Home({Key? key}) : super(key: key);

  @override
  State<Lab_Home> createState() => _Lab_HomeState();
}

// ignore: camel_case_types
class _Lab_HomeState extends State<Lab_Home> {
  String? year, dept, subject;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lab Verfication"),
        centerTitle: true,
        backgroundColor: Colors.purple,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              flex: 1,
              child: DecoratedBox(
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
            ),
            SizedBox(
              height: 40,
            ),
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
            ),
            SizedBox(
              height: 40,
            ),
            Flexible(
              flex: 1,
              child: DecoratedBox(
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
            ),
            SizedBox(
              height: 40,
            ),
            Flexible(
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => viewLabs()));
                    },
                    child: Text("View Labs")))
          ],
        ),
      ),
    );
  }
}

class viewLabs extends StatefulWidget {
  viewLabs({Key? key}) : super(key: key);

  @override
  State<viewLabs> createState() => _viewLabsState();
}

class _viewLabsState extends State<viewLabs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List of Labs"),
        centerTitle: true,
        backgroundColor: Colors.brown,
      ),
      body: ListView.builder(
          itemCount: 5,
          itemBuilder: (BuildContext context, index) {
            return Center(
              child: Card(
                child: ListTile(
                  title: Text(
                    "Lab - $index",
                  ),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LabId()));
                  },
                ),
              ),
            );
          }),
      floatingActionButton: IconButton(
          iconSize: 50,
          color: Colors.black,
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => LabCreation()));
          },
          icon: Icon(
            Icons.add_task_rounded,
            color: Colors.brown,
          )),
    );
  }
}

class LabId extends StatefulWidget {
  const LabId({Key? key}) : super(key: key);

  @override
  State<LabId> createState() => _LabIdState();
}

class _LabIdState extends State<LabId> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Submitted Members"),
        centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: TestData.ID.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                title: Text(TestData.ID[index]),
                trailing: Icon(Icons.verified),
              ),
            );
          }),
    );
  }
}

class LabCreation extends StatefulWidget {
  const LabCreation({Key? key}) : super(key: key);

  @override
  State<LabCreation> createState() => _LabCreationState();
}

class _LabCreationState extends State<LabCreation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lab Creation "),
        centerTitle: true,
        backgroundColor: Colors.amberAccent,
      ),
      body: Column(
        children: [
          Text(
            "Enter the title of the Lab Assignment",
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(width: 4.0),
                  borderRadius: BorderRadius.circular(8.0)),
              child: TextFormField(
                maxLines: 1,
              ),
            ),
          ),
          Text(
            "Enter the title of the Lab Assignment Description",
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(width: 4.0),
                  borderRadius: BorderRadius.circular(8.0)),
              child: TextFormField(
                minLines: 8,
                maxLines: 12,
              ),
            ),
          ),
          Container(
            decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(100.0)),
            child: Card(
              child: ListTile(
                tileColor: Colors.amberAccent,
                leading: Icon(Icons.assignment),
                title: Text(
                  "Assign Lab",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                onTap: () {},
              ),
            ),
          )
        ],
      ),
    );
  }
}
