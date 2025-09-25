import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_databse/model/profile.dart';

import 'package:test_databse/screens/rider_register_screen.dart';
import 'package:test_databse/screens/sending/send_home.dart';
import 'package:test_databse/screens/user_register_screen.dart';

// RegisterTypePage.dart
class RegisterTypePage extends StatefulWidget {
  const RegisterTypePage({super.key}); // ไม่ต้องมี userType

  @override
  State<RegisterTypePage> createState() => _RegisterTypePageState();
}

class _RegisterTypePageState extends State<RegisterTypePage> {
  bool _isPressedUser = false;
  bool _isPressedRider = false;

  void _navigate(BuildContext context, UserType userType) {
    if (userType == UserType.user) {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => UserRegisterPage(userType: userType)),
      );
    } else {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => RiderRegisterPage(userType: userType),
        ),
      );
    }
  }

  Widget _buildButton({
    required String text,
    required IconData icon,
    required Color color,
    required Color textColor,
    required bool isPressed,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTapDown: (_) => setState(() => isPressed = true),
      onTapUp: (_) {
        setState(() => isPressed = false);
        Future.delayed(const Duration(milliseconds: 150), onTap);
      },
      onTapCancel: () => setState(() => isPressed = false),
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
            Icon(icon, color: textColor),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "สมัครสมาชิก",
                style: GoogleFonts.prompt(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "โปรดเลือกประเภทบัญชี\nเพื่อลงทะเบียนการใช้งาน",
                textAlign: TextAlign.center,
                style: GoogleFonts.prompt(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 40),

              _buildButton(
                text: "ผู้ใช้",
                icon: Icons.person,
                color: Colors.white,
                textColor: Colors.green.shade700,
                isPressed: _isPressedUser,
                onTap: () => _navigate(context, UserType.user),
              ),
              const SizedBox(height: 40),

              _buildButton(
                text: "ไรเดอร์",
                icon: Icons.delivery_dining,
                color: Colors.green.shade700,
                textColor: Colors.white,
                isPressed: _isPressedRider,
                onTap: () => _navigate(context, UserType.rider),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
