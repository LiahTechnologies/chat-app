import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:njadia/src/core/chats%20functionality/screen/video_view.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'camara_view.dart';


late List<CameraDescription> camera;

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _cameraController;
  bool isRecording = false;
  late Future<void> cameraValue;
  String path = '';
  @override
  void initState() {
    _cameraController = CameraController(camera[0], ResolutionPreset.high);
    cameraValue = _cameraController.initialize();

    super.initState();
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FutureBuilder(
            future: cameraValue,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return CameraPreview(_cameraController);
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
        Positioned(
          bottom: 0.0,
          child: Container(
            width: MediaQuery.of(context).size.width,
            color: Colors.black,
            child: Column(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.flash_off,
                          color: Colors.white,
                          size: 28,
                        )),
                    GestureDetector(
                        onLongPress: () async {
                          path = join((await getTemporaryDirectory()).path,
                              '${DateTime.now()}.mp4');
                          await _cameraController.startVideoRecording();

                          setState(() {
                            isRecording = true;
                          });
                        },
                        onLongPressUp: () async {
                          await _cameraController.stopVideoRecording();
                          setState(() {
                            isRecording = false;
                          });

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      VideoViewPage(path: path)));
                        },
                        onTap: () {
                          if (!isRecording) takePhoto(context);
                        },
                        child: isRecording
                            ? Icon(
                                Icons.radio_button_on,
                                color: Colors.red,
                                size: 70,
                              )
                            : Icon(
                                Icons.panorama_fish_eye,
                                color: Colors.white,
                                size: 70,
                              )),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.flip_camera_ios,
                          color: Colors.white,
                          size: 20,
                        ))
                  ],
                ),
                SizedBox(
                  height: 4,
                ),
                const Text(
                  "Held for video tap for photo",
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  void takePhoto(BuildContext context) async {
    final path =
        join((await getTemporaryDirectory()).path, '${DateTime.now()}.png');
    await _cameraController.takePicture();
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CameraViewPage(
                  path: path,
                )));
  }
}
