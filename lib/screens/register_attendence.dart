import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'dart:async';
import 'dart:io';
import 'package:camera/camera.dart';

class RegisterAttendence extends StatefulWidget {
  const RegisterAttendence({Key? key}) : super(key: key);

  @override
  State<RegisterAttendence> createState() => _RegisterAttendenceState();
}

class _RegisterAttendenceState extends State<RegisterAttendence> {
  late final List<CameraDescription> cameras;
  late CameraDescription firstCamera;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: const Text("Attendence Registration"),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Center(
          child: ElevatedButton(
            onPressed: () async {
              WidgetsFlutterBinding.ensureInitialized();
              // Obtain a list of the available cameras on the device.
              cameras = await availableCameras();
              // Get a specific camera from the list of available cameras.
              firstCamera = cameras.first;
              if (mounted) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => TakePictureScreen(
                      camera: firstCamera,
                    ),
                  ),
                );
              }
            },
            child: const Text("READY"),
          ),
        ),
      ),
    );
  }
}

// A screen that allows users to take a picture using a given camera.
class TakePictureScreen extends StatefulWidget {
  const TakePictureScreen({
    key,
    required this.camera,
  });

  final CameraDescription camera;
  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  final PageController _pageController = PageController();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lime,
        title: const Text("ATTENDENCE REGISTRATION"),
        centerTitle: true,
      ),
      body: Center(
        child: SizedBox(
          width: 600,
          child: Column(
            children: <Widget>[
              Expanded(
                child: PageView(
                  controller: _pageController,
                  children: <Widget>[
                    CameraScreen(camera: widget.camera),
                    CameraScreen(camera: widget.camera),
                    CameraScreen(camera: widget.camera),
                    CameraScreen(camera: widget.camera),
                    CameraScreen(camera: widget.camera),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 10.0),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_pageController.hasClients) {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeInOut,
                        );
                      }
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const <Widget>[
                        Text('Next'),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(Icons.navigate_next),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CameraScreen extends StatefulWidget {
  const CameraScreen({
    key,
    required this.camera,
  });
  final CameraDescription camera;
  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  @override
  void initState() {
    super.initState();
    // To display the current output from the Camera,
    // create a CameraController.
    _controller = CameraController(
      // Get a specific camera from the list of available cameras.
      widget.camera,
      // Define the resolution to use.
      ResolutionPreset.medium,
    );
    // Next, initialize the controller. This returns a Future.
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  XFile? img;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Flexible(
          flex: 5,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.green,
                width: 1,
              ),
            ),
            child: img != null
                ? Image.network(img!.path)
                : FutureBuilder<void>(
                    future: _initializeControllerFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        // If the Future is complete, display the preview.
                        return CameraPreview(_controller);
                      } else {
                        // Otherwise, display a loading indicator.
                        return const Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
          ),
        ),
        Flexible(
          flex: 1,
          child: Padding(
              padding: const EdgeInsets.all(5),
              child: FloatingActionButton(
                elevation: 1,
                // Provide an onPressed callback.
                onPressed: () async {
                  // Take the Picture in a try / catch block. If anything goes wrong,
                  // catch the error.
                  try {
                    // Ensure that the camera is initialized.
                    await _initializeControllerFuture;

                    // Attempt to take a picture and get the file `image`
                    // where it was saved.
                    img = await _controller.takePicture();

                    if (!mounted) return;

                    // If the picture was taken, display it on a new screen.

                    img = await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => DisplayPictureScreen(
                          // Pass the automatically generated path to
                          // the DisplayPictureScreen widget.
                          image: img,
                        ),
                      ),
                    );
                  } catch (e) {
                    // If an error occurs, log the error to the console.
                    //print(e);
                  } finally {
                    setState(() {});
                  }
                },
                child: const Icon(Icons.camera_alt),
              )),
        ),
      ],
    );
  }
}

class DisplayPictureScreen extends StatelessWidget {
  final XFile? image;

  const DisplayPictureScreen({key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lime,
        title: const Text("ATTENDENCE REGISTRATION"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(4),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.center, //Center Column contents vertically,
          children: <Widget>[
            Flexible(
              flex: 5,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.green,
                    width: 1,
                  ),
                ),
                width: 600,
                child: kIsWeb
                    ? Image.network(image!.path)
                    : Image.file(File(image!.path)),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Flexible(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FloatingActionButton(
                    // Provide an onPressed callback.
                    heroTag: 'retake',
                    onPressed: () {
                      Navigator.pop(context, null);
                    },
                    backgroundColor: Colors.purple,
                    child: const Icon(
                      Icons.refresh_sharp,
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  FloatingActionButton(
                    // Provide an onPressed callback.
                    heroTag: 'done',
                    onPressed: () {
                      Navigator.pop(context, image);
                    },
                    backgroundColor: Colors.green,
                    child: const Icon(
                      Icons.check,
                    ),
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
