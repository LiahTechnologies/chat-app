import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FaceDetectionScreen(),
    );
  }
}

class FaceDetectionScreen extends StatefulWidget {
  @override
  _FaceDetectionScreenState createState() => _FaceDetectionScreenState();
}

class _FaceDetectionScreenState extends State<FaceDetectionScreen> {
  late FaceDetector _faceDetector;
  List<Face> _faces = [];
  ImagePicker _imagePicker = ImagePicker();
  
  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    _faceDetector = GoogleMlKit.vision.faceDetector(
      FaceDetectorOptions(
        enableContours: true,
        enableLandmarks: true,
      ),
    );
  }

  Future<void> _detectFaces() async {
    final XFile? pickedFile =
        await _imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final inputImage = InputImage.fromFilePath(pickedFile.path);

      try {
        final List<Face> faces = await _faceDetector.processImage(inputImage);

        for (Face face in faces) {
          // if (face.landmarks[FaceLandmarkType.leftEye]?.position ==
          //     face.landmarks[FaceLandmarkType.rightEye]) {
            setState(() {
              _faces = faces;
            });
          // }

          print("THE IMAGE IS NOT CLEAR");

          // print('Bounding box: ${face.boundingBox}');
          // print('Left eye position: ${face.landmarks[FaceLandmarkType.leftEye]?.position}');
          // print('Right eye position: ${face.landmarks[FaceLandmarkType.rightEye]?.position}');
          // print('Left ear position: ${face.landmarks[FaceLandmarkType.leftEar]?.position}');
          // print('Right ear position: ${face.landmarks[FaceLandmarkType.rightEar]?.position}');
        }
      } catch (e) {
        print("Error detecting faces: $e");
      }
    }
  }

  @override
  void dispose() {
    _faceDetector.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Face Detection'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _detectFaces,
              child: Text('Detect Faces'),
            ),
            SizedBox(height: 20),
            // Display face detection results here
            Text('Detected ${_faces.length} face(s)'),
          ],
        ),
      ),
    );
  }
}
