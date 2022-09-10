import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'dart:async';

class Cam extends StatefulWidget {
  //List<CameraDescription> cameras;
  //Cam(this.cameras)
  //Cam(super.key, required this.camera) : super(key: key);

  @override
  State<Cam> createState() => _CamState();
}

class _CamState extends State<Cam> {
  late CameraController controller;
  late Future<void> _initializeControllerFuture;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //controller =
    //  new CameraController(widget.cameras.first, ResolutionPreset.medium);
    /*controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }*/
    _initializeControllerFuture = controller.initialize();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return Container();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Camera"),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(controller);
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
