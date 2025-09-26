import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:test_databse/service/clouddinary_service.dart';

class UploadArea extends StatefulWidget {
  const UploadArea({super.key});

  @override
  State<UploadArea> createState() => _UploadAreaState();
}

class _UploadAreaState extends State<UploadArea> {
  @override
  Widget build(BuildContext context) {
    final selectedFile =
        ModalRoute.of(context)!.settings.arguments as FilePickerResult;
    return Scaffold(
      appBar: AppBar(title: Text("upload")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              readOnly: true,
              initialValue: selectedFile.files.first.name,
              decoration: InputDecoration(label: Text("Name")),
            ),
            TextFormField(
              readOnly: true,
              initialValue: selectedFile.files.first.extension,
              decoration: InputDecoration(label: Text("extension")),
            ),
            TextFormField(
              readOnly: true,
              initialValue: "${selectedFile.files.first.size}bytes.",
              decoration: InputDecoration(label: Text("size")),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                ElevatedButton(onPressed: () {}, child: Text("Cancel")),

                ElevatedButton(
                  onPressed: () async {
                    final result = await uploadTocloud(selectedFile);

                    if (result) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("File Upload Successully")),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("File cannot Upload ")),
                      );
                    }
                  },
                  child: Text("upload"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
