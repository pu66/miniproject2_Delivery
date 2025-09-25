// import 'dart:typed_data';
// import 'dart:developer' as developer;

// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:form_field_validator/form_field_validator.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:test_databse/firebase_options.dart';
// import 'package:test_databse/model/profile.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:test_databse/screens/home.dart';
// import 'package:image_picker/image_picker.dart';

// class Register extends StatefulWidget {
//   const Register({super.key});

//   @override
//   State<Register> createState() => _RegisterPageState();
// }

// class _RegisterPageState extends State<Register> {
//   final _formKey = GlobalKey<FormState>();
//   Profile profile = Profile(email: '', password: '');
//   late final Future<FirebaseApp> _firebaseInit;
//   Uint8List? _image;
//   @override
//   void initState() {
//     super.initState();
//     _firebaseInit = Firebase.initializeApp(
//       options: DefaultFirebaseOptions.currentPlatform,
//     );
//   }

//   Future<Uint8List?> selectImage(ImageSource source) async {
//     // ขอ permission ก่อน
//     if (source == ImageSource.camera) {
//       var status = await Permission.camera.request();
//       if (!status.isGranted) return null;
//     } else {
//       var status = await Permission.photos.request(); // Android 13+
//       if (!status.isGranted) return null;
//     }

//     final ImagePicker picker = ImagePicker();
//     XFile? file = await picker.pickImage(source: source);
//     if (file != null) {
//       return await file.readAsBytes();
//     }
//     return null;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//       future: _firebaseInit,
//       builder: (context, snapshot) {
//         if (snapshot.hasError) {
//           return Scaffold(
//             appBar: AppBar(title: const Text("Error")),
//             body: Center(child: Text(snapshot.error.toString())),
//           );
//         }

//         if (snapshot.connectionState == ConnectionState.done) {
//           return Scaffold(
//             appBar: AppBar(title: const Text("สร้างบัญชี")),
//             body: Padding(
//               padding: const EdgeInsets.all(20),
//               child: Form(
//                 key: _formKey,
//                 child: SingleChildScrollView(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Stack(
//                         alignment: Alignment.bottomRight,
//                         children: [
//                           CircleAvatar(
//                             radius: 64,
//                             backgroundColor: Colors.grey[300],
//                             backgroundImage: _image != null
//                                 ? MemoryImage(_image!)
//                                 : null,
//                             child: _image == null
//                                 ? Icon(
//                                     Icons.person,
//                                     size: 64,
//                                     color: Colors.white,
//                                   )
//                                 : null,
//                           ),
//                           IconButton(
//                             onPressed: () async {
//                               print("กดเลือกภาพแล้ว");
//                               Uint8List? img = await selectImage(
//                                 ImageSource.gallery,
//                               );
//                               print("img: $img");
//                               if (img != null) {
//                                 setState(() {
//                                   _image = img;
//                                 });
//                                 print("อัปเดตรูปแล้ว");
//                               }
//                             },
//                             icon: Icon(Icons.add_a_photo),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 20),
//                       const Text("อีเมล", style: TextStyle(fontSize: 20)),
//                       TextFormField(
//                         keyboardType: TextInputType.emailAddress,
//                         validator: MultiValidator([
//                           RequiredValidator(errorText: "กรุณาป้อนอีเมล"),
//                           EmailValidator(errorText: "รูปแบบอีเมลไม่ถูกต้อง"),
//                         ]),
//                         onSaved: (value) => profile.email = value ?? '',
//                       ),
//                       const SizedBox(height: 20),
//                       const Text("รหัสผ่าน", style: TextStyle(fontSize: 20)),
//                       TextFormField(
//                         obscureText: true,
//                         validator: RequiredValidator(
//                           errorText: "กรุณาป้อนรหัสผ่าน",
//                         ),
//                         onSaved: (value) => profile.password = value ?? '',
//                       ),
//                       const SizedBox(height: 20),
//                       SizedBox(
//                         width: double.infinity,
//                         child: ElevatedButton(
//                           onPressed: () async {
//                             if (_formKey.currentState!.validate()) {
//                               _formKey.currentState!.save();
//                               try {
//                                 print(
//                                   "Calling FirebaseAuth.createUserWithEmailAndPassword...",
//                                 );

//                                 UserCredential userCredential =
//                                     await FirebaseAuth.instance
//                                         .createUserWithEmailAndPassword(
//                                           email: profile.email,
//                                           password: profile.password,
//                                         );

//                                 _formKey.currentState?.reset();
//                                 Fluttertoast.showToast(
//                                   msg: "สร้างบัญชีผู้ใช้เรียบร้อยแล้ว",
//                                   toastLength: Toast.LENGTH_LONG,
//                                   gravity: ToastGravity.TOP,
//                                   backgroundColor: Colors.green, // สีพื้นหลัง
//                                   textColor: Colors.white, // สีตัวอักษร
//                                   fontSize: 16.0,
//                                   timeInSecForIosWeb: 2,
//                                   webPosition: "center",
//                                   webBgColor:
//                                       "linear-gradient(to right, #00b09b, #96c93d)",
//                                 );
//                                 Navigator.pushReplacement(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (context) {
//                                       return Homescreen();
//                                     },
//                                   ),
//                                 );
//                               } on FirebaseAuthException catch (e) {
//                                 String message;
//                                 print(e.code);
//                                 if (e.code == 'email-already-in-use') {
//                                   message =
//                                       "มีอีเมลนี้ในระบบแล้ว กรุณาใช้อีเมลอื่น";
//                                 }
//                                 Fluttertoast.showToast(
//                                   msg: e.message!,
//                                   toastLength: Toast.LENGTH_LONG,
//                                   gravity: ToastGravity.TOP,
//                                   backgroundColor: Colors.green, // สีพื้นหลัง
//                                   textColor: Colors.white, // สีตัวอักษร
//                                   fontSize: 16.0,
//                                   timeInSecForIosWeb: 2,
//                                   webPosition: "center",
//                                   webBgColor:
//                                       "linear-gradient(to right, #00b09b, #96c93d)",
//                                 );
//                               }
//                             }
//                           },
//                           child: const Text(
//                             "ลงทะเบียน",
//                             style: TextStyle(fontSize: 20),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           );
//         }

//         return const Scaffold(body: Center(child: CircularProgressIndicator()));
//       },
//     );
//   }
// }
