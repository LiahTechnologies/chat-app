import 'dart:io';

import 'package:image_picker/image_picker.dart';

Future<File> openCamera({method}) async {
  // File imageFile;
  final ImagePicker picker = ImagePicker();
  var source;
  method == "Camera"
      ? source = ImageSource.camera
      : source = ImageSource.gallery;

  final XFile? image = await picker.pickImage(source: source);

  File cameraImage = File(image!.path);
  return  cameraImage;

  
}
