import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:q_dev_app/viewModel/user_viewmodel.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController aboutMeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final userVM = Provider.of<UserViewmodel>(context);
    return Scaffold(
      backgroundColor: Color(0xFFF0F7FF),
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: BackButton(color: Colors.white,),
        centerTitle: true,
        title: Text('Edit Profile', style: GoogleFonts.ubuntu(
          fontWeight: FontWeight.w400,
          color: Colors.white
        ),),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 18,),
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(200),
                  child: Image.asset('assets/images/logo.jpg', width: 120, height: 120,)
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(150, 0, 0, 0),
                      borderRadius: BorderRadius.circular(100)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Icon(Icons.photo_camera_outlined, color: Colors.white,),
                    ),
                  )
                )
              ],
            ),
            SizedBox(height: 28,),
            Divider(height: 0, thickness: 1.5,),
            SizedBox(height: 18,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: MyTextField(controller: nameController, label: 'Marshmello', header: 'Full name', maxLine: 1,),
            ),
            SizedBox(height: 12,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: MyTextField(controller: aboutMeController, label: 'Something about you...', header: 'About me', maxLine: 4,),
            ),
            SizedBox(height: 18,)
          ],
        )
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.fromLTRB(14, 0, 14, 20),
        child: GestureDetector(
          onTap: () async {
            await userVM.userEditProfile(nameController.text, aboutMeController.text);
            if (!context.mounted) return;

            if (userVM.errorMessage != null) {
              // Add error message to user
            } else {
              Navigator.pop(context);
            }
          },
          child: Container(
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(9)
            ),
            child: Center(
              child: userVM.isLoading ? 
              CircularProgressIndicator(color: Colors.white,) :
              Text('Save', style: GoogleFonts.ubuntu(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: Colors.white
              ),),
            ),
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