import 'package:flutter/material.dart';

class Contact extends StatefulWidget {
  Contact({Key? key}) : super(key: key);

  @override
  State<Contact> createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contact"),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              child: const CircleAvatar(
                foregroundImage: AssetImage('assets/kksir.jpg'),
                radius: 100,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Krishna Kumar Singh",
              style: TextStyle(
                  color: Colors.red, fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Assistant Professor",
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Email : krishnasingh@rguktn.ac.in",
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Ph no : 9542095063",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Feedback()));
              },
              child: const Hero(
                child: Icon(
                  Icons.feedback,
                  size: 50,
                ),
                tag: "feedBack",
              ),
            ),
            const Text(
              "FeedBack",
              style: TextStyle(fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}

class Feedback extends StatefulWidget {
  Feedback({Key? key}) : super(key: key);

  @override
  State<Feedback> createState() => _FeedbackState();
}

class _FeedbackState extends State<Feedback> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Feedback"),
          centerTitle: true,
          backgroundColor: Colors.redAccent,
        ),
        body: Column(
          children: [
            Row(
              children: [
                const Hero(
                  tag: "feedBack",
                  child: Icon(
                    Icons.feedback,
                    size: 70,
                  ),
                ),
                Text(
                  "Submit Your Feed Back Below",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                )
              ],
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
                  maxLines: 6,
                  minLines: 4,
                ),
              ),
            ),
            ElevatedButton(onPressed: () {}, child: Text("Submit"))
          ],
        ));
  }
}
