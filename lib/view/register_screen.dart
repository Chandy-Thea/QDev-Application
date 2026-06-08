// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:q_dev_app/repository/user_repo.dart';
import 'package:q_dev_app/view/login_screen.dart';
import 'package:q_dev_app/view/tabs_screen.dart';
import 'package:q_dev_app/viewModel/user_viewmodel.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final userVM = Provider.of<UserViewmodel>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFFF0F7FF),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Spacer(flex: 2,),
            Text('Create an account', style: GoogleFonts.ubuntu(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black
            ),),
            Text('Enter your email to sign up for this app', style: GoogleFonts.ubuntu(
              fontSize: 14,
              color: Color(0xFF666666)
            ),),
            Spacer(flex: 1,),
            MyTextField(controller: nameController, label: 'Marshmello', header: 'Full name'),
            SizedBox(height: 10,),
            MyTextField(controller: emailController, label: 'example@gmail.com', header: 'Email Address'),
            SizedBox(height: 10,),
            MyTextField(controller: passwordController, label: '**************', header: 'Password'),
            Spacer(flex: 1,),
            GestureDetector(
              onTap: () async {
                final bool succcess = await UserRepo().register(nameController.text, emailController.text, passwordController.text, passwordController.text);
                // Check if success and we'll fetch user info
                if(succcess){
                  await userVM.fetchUser();
                  if(!mounted) return;
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const TabsScreen()),
                      (route) => false, // This removes all previous screens from the memory stack
                    );
                } else {
                  //Give error message to user
                  print('Failed register!!!');
                }
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: Color(0xFF4A90E2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text('Sign up', style: GoogleFonts.ubuntu(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                  ),),
                ),
              ),
            ),
            Spacer(flex: 1,),
            Row(
              children: [
                Expanded(child: Divider(color: Color(0xFF666666),)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text('Or', style: GoogleFonts.ubuntu(
                    fontSize: 14
                  ),),
                ),
                Expanded(child: Divider(color: Color(0xFF666666),))
              ],
            ),
            Spacer(flex: 1,),
            Container(
              height: 50,
              decoration: BoxDecoration(
                color: Color(0xFFEEEEEE),
                borderRadius: BorderRadius.circular(8)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/icons/google.png', width: 20, height: 20,),
                  SizedBox(width: 8,),
                  Text('Continue with Google', style: GoogleFonts.ubuntu(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF666666)
                  ),)
                ],
              ),
            ),
            SizedBox(height: 8,),
            Container(
              height: 50,
              decoration: BoxDecoration(
                color: Color(0xFFEEEEEE),
                borderRadius: BorderRadius.circular(8)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/icons/facebook.png', width: 20, height: 20,),
                  SizedBox(width: 8,),
                  Text('Continue with Facebook', style: GoogleFonts.ubuntu(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF666666)
                  ),)
                ],
              ),
            ),
            SizedBox(height: 16,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Already have an account?', style: GoogleFonts.ubuntu(
                  fontSize: 12,
                  color: Color(0xFF121212)
                ),),
                SizedBox(width: 6,),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder:(context) => LoginScreen(),));
                  },
                  child: Text('Sign in', style: GoogleFonts.ubuntu(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF121212)
                  ),),
                )
              ],
            ),
            Spacer(flex: 3,)
          ],
        ),
      ),
    );
  }
}


class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String header;
  const MyTextField({super.key, required this.controller, required this.label, required this.header});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(header, style: GoogleFonts.ubuntu(
            fontSize: 14, color: Colors.black
          ),)
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              width: 1, color: Color(0xFF666666)
            )
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 16),
            child: TextField(
              controller: controller,
              style: GoogleFonts.ubuntu(
                fontSize: 15,
                color: Colors.black
              ),
              decoration: InputDecoration(
                hintText: label,
                hintStyle: GoogleFonts.ubuntu(
                fontSize: 15,
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