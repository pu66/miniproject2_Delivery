import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<bool> uploadTocloud(FilePickerResult? filePickerResult) async {
  if (filePickerResult == null || filePickerResult.files.isEmpty) {
    print("no file selected!");
    return false;
  }
  File file = File(filePickerResult.files.single.path!);
  String cloundName = dotenv.env['CLOUDINARY_CLOUD_NAME'] ?? '';
  var uri = Uri.parse("https://api.cloudinary.com/v1_1/$cloundName/raw/upload");
  var request = http.MultipartRequest("POST", uri);
  var fileByte = await file.readAsBytes();
  var multipartFile = http.MultipartFile.fromBytes(
    'file',
    fileByte,
    filename: file.path.split("/").last,
  );
  request.files.add(multipartFile);
  request.fields['upload_preset'] = "profile_upload";
  // request.fields['upload_preset'] = "res";
  var response = await request.send();
  var responseBody = await response.stream.bytesToString();

  print(responseBody);

  if (response.statusCode == 200) {
    print("Upload successful");
    return true;
  } else {
    print("Upload faild with status: ${response.statusCode}");
    return false;
  }
}
