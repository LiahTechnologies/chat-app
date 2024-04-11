import 'dart:async';
import 'dart:io';

import 'package:image_picker/image_picker.dart';

import '../../../features/authentication/presentation/bloc/auth_event.dart';

class UploadBlocFiles {
  final imgSource;

  final userStreamController = StreamController<File>();

  StreamSink<File> get userSink => userStreamController.sink;
  Stream<File> get userStream => userStreamController.stream;

  UploadBlocFiles({required this.imgSource});
  final eventStreamcontroller = StreamController<AuthEvent>();

  // this will handle
  StreamSink<AuthEvent> get inputEvent => eventStreamcontroller.sink;

  // this will handle the output from the input
  Stream<AuthEvent> get outputEvent => eventStreamcontroller.stream;

  late File pickedImage;
  uploadEvent() {
    outputEvent.listen((event) async {
      if (event == OnPickFile) {
        final image_picker = ImagePicker();
        XFile? image;

        // await Permission.photos.request();

        // var checkPhotoPermission = await Permission.photos.status;

        // if (checkPhotoPermission.isGranted) {
          image = await image_picker.pickImage(
              source: imgSource == "gallery"
                  ? ImageSource.gallery
                  : ImageSource.camera);

          var file = File(image!.path);

          if (image != null) {
            pickedImage = file;

            userSink.add(file);
          }
        // }
      } else {}
    });

    // return pickedImage;
  }
}
