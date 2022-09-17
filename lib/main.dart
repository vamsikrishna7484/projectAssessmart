import 'dart:async';
import 'dart:io';
import 'package:my_work/Attendace.dart';
import 'package:my_work/screens/HomePage.dart';
import 'package:my_work/screens/Menu.dart';
import 'package:my_work/screens/coding_lab.dart';
import 'package:my_work/screens/create_lab.dart';
import 'package:my_work/screens/dashboard.dart';
import 'package:my_work/screens/flogin.dart';
import 'package:my_work/screens/home.dart';
import 'package:my_work/screens/login.dart';
import 'package:my_work/screens/register.dart';
import 'package:my_work/screens/register_attendence.dart';
import 'package:my_work/screens/subjectRegister.dart';
import 'package:path_provider/path_provider.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:my_work/screens/takepicturescreen.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';
//import 'Attendace.dart';

Future<void> main() async {
  // Ensure that plugin services are initialized so that `availableCameras()`
  // can be called before `runApp()`
  WidgetsFlutterBinding.ensureInitialized();

  // Obtain a list of the available cameras on the device.
  final cameras = await availableCameras();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

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
        '/create_lab': (context) => const CreateLab(),
        '/attendance': (context) => const Attendance(img: null),
        '/register_attendence': (context) => const RegisterAttendence(),
        '/flogin': (context) => const FLogin(),
        '/fhome': (context) => Menu(),
      },
    ),
  );
}
