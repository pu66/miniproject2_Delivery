import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_databse/model/profile.dart';
import 'package:test_databse/screens/select_register_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  // Controller ของ textfield
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _isPressedRider = false;

  Widget _buildButton({
    required String text,
    required Color color,
    required Color textColor,
    required bool isPressed,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressedRider = true),
      onTapUp: (_) {
        setState(() => _isPressedRider = false);
        Future.delayed(const Duration(milliseconds: 150), onTap);
      },
      onTapCancel: () => setState(() => _isPressedRider = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(30),
          boxShadow: isPressed
              ? []
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.17),
                    offset: const Offset(1, 10),
                    blurRadius: 6,
                  ),
                ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(width: 8),
            Text(
              text,
              style: GoogleFonts.prompt(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // ถ้าฟอร์มถูกต้อง
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("เข้าสู่ระบบเรียบร้อย")));

      print("Email: ${emailController.text}");

      print("Password: ${passwordController.text}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),

          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Form(
              key: _formKey, // ใส่ formKey ตรงนี้
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 80),

                  Text(
                    "เข้าสู่ระบบ",
                    style: GoogleFonts.prompt(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Email
                  TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: MultiValidator([
                      RequiredValidator(errorText: "กรุณาป้อนอีเมล"),
                      EmailValidator(errorText: "รูปแบบอีเมลไม่ถูกต้อง"),
                    ]),
                    decoration: const InputDecoration(
                      icon: Icon(Icons.email),
                      labelText: 'Email',
                      hintText: 'example@gmail.com',
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Password
                  TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    validator: MinLengthValidator(
                      8,
                      errorText: "รหัสผ่านต้องอย่างน้อย 8 ตัว",
                    ),
                    decoration: const InputDecoration(
                      icon: Icon(Icons.lock),
                      labelText: 'Password',
                      hintText: 'At least 8 characters',
                    ),
                  ),
                  const SizedBox(height: 50),

                  // Button
                  _buildButton(
                    text: "เข้าสู่ระบบ",
                    color: Colors.green.shade700,
                    textColor: Colors.white,
                    isPressed: _isPressedRider,
                    onTap: _submitForm,
                  ),
                  const SizedBox(height: 30),

                  Center(
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => RegisterTypePage()),
                        );
                      },
                      child: Text("สมัครสมาชิก"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
