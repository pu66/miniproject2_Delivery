import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

// ตรวจสอบ permission
Future<bool> checkPermissions() async {
  if (await Permission.photos.request().isGranted) {
    return true;
  }
  return false;
}

Future<File?> pickImage() async {
  final picker = ImagePicker();
  final picked = await picker.pickImage(source: ImageSource.gallery);
  if (picked != null) return File(picked.path);
  return null;
}
