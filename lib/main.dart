import 'package:assessmart/pages/attendence.dart';
import 'package:assessmart/pages/coding_lab.dart';
import 'package:assessmart/pages/register_attendence.dart';
import 'package:flutter/material.dart';
import 'package:assessmart/pages/home.dart';
import 'package:assessmart/pages/register.dart';
import 'package:assessmart/pages/login.dart';
import 'package:camera/camera.dart';
//import 'Attendace.dart';

Future<void> main() async {
  // Ensure that plugin services are initialized so that `availableCameras()`
  // can be called before `runApp()`
  WidgetsFlutterBinding.ensureInitialized();

  // Obtain a list of the available cameras on the device.
  final cameras = await availableCameras();

  // Get a specific camera from the list of available cameras.
  final firstCamera = cameras.first;

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      //theme: ThemeData.dark(),
      routes: {
        '/': (context) => const Home(),
        '/home': (context) => const Home(),
        '/register': (context) => const Register(),
        '/login': (context) => const Login(),
        '/coding_lab': (context) => const CodingLab(),
        '/attendance': (context) => const Attendance(img: null),
        '/register_attendence': (context) => const RegisterAttendence(),
      },
    ),
  );
}
