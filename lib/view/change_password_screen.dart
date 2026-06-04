import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  TextEditingController currentPassController = TextEditingController();
  TextEditingController newPassController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF0F7FF),
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: BackButton(color: Colors.white,),
        centerTitle: true,
        title: Text('Change Password', style: GoogleFonts.ubuntu(
          fontWeight: FontWeight.w400,
          color: Colors.white
        ),),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Column(
            children: [
              SizedBox(height: 16,),
              Text('To change your password, ensure your new password is at least 8 characters '
              'long to meet our security standards.', style: GoogleFonts.ubuntu(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Color(0xFF595959)
              ),),
              SizedBox(height: 16,),
              MyTextField(controller: currentPassController, label: '**************', header: 'Current Password', maxLine: 1),
              SizedBox(height: 10,),
              MyTextField(controller: newPassController, label: '**************', header: 'New Password', maxLine: 1),
            ],
          ),
        )
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.fromLTRB(14, 0, 14, 20),
        child: Container(
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(9)
          ),
          child: Center(
            child: Text('Save', style: GoogleFonts.ubuntu(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: Colors.white
            ),),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}


class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String header;
  final int maxLine;
  const MyTextField({super.key, required this.controller, required this.label, required this.header, required this.maxLine});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(header, style: GoogleFonts.ubuntu(
            fontSize: 17, color: Colors.black
          ),)
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              width: 1.5, color: Colors.grey
            )
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 16),
            child: TextField(
              controller: controller,
              maxLines: maxLine,
              style: GoogleFonts.ubuntu(
                fontSize: 16,
                color: Colors.black
              ),
              decoration: InputDecoration(
                hintText: label,
                hintStyle: GoogleFonts.ubuntu(
                fontSize: 18,
                color: Color(0xFF666666)
              ),
                border: InputBorder.none
              ),
            ),
          ),
        )
      ],
    );
  }
}