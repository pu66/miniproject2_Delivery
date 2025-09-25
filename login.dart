// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:form_field_validator/form_field_validator.dart';
// import 'package:test_databse/firebase_options.dart';
// import 'package:test_databse/model/profile.dart';
// import 'package:test_databse/screens/sending_screen.dart';

// class Login extends StatefulWidget {
//   const Login({super.key});

//   @override
//   State<Login> createState() => _LoginState();
// }

// class _LoginState extends State<Login> {
//   final _formKey = GlobalKey<FormState>();
//   Profile profile = Profile(email: '', password: '');
//   late final Future<FirebaseApp> _firebaseInit;

//   @override
//   void initState() {
//     super.initState();
//     _firebaseInit = Firebase.initializeApp(
//       options: DefaultFirebaseOptions.currentPlatform,
//     );
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
//             appBar: AppBar(title: const Text("ลงชื่อเข้าใช้")),
//             body: Padding(
//               padding: const EdgeInsets.all(20),
//               child: Form(
//                 key: _formKey,
//                 child: SingleChildScrollView(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
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
//                                         .signInWithEmailAndPassword(
//                                           email: profile.email,
//                                           password: profile.password,
//                                         );

//                                 _formKey.currentState?.reset();
//                                 Fluttertoast.showToast(
//                                   msg: "ลงชื่อเข้าใช้เรียบร้อยแล้ว",
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
//                                       return SendingScreen();
//                                     },
//                                   ),
//                                 );
//                               } on FirebaseAuthException catch (e) {
//                                 print(e.code);

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
//                             "ลงชื่อเข้าใช้",
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
