// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:q_dev_app/view/change_password_screen.dart';
import 'package:q_dev_app/view/edit_profile_screen.dart';
import 'package:q_dev_app/view/register_screen.dart';
import 'package:q_dev_app/viewModel/user_viewmodel.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userVM = Provider.of<UserViewmodel>(context);
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Column(
          children: [
            //Use Consumer whenever data changing inside viewModel and it'll only build these specific area
            Consumer<UserViewmodel>(
              builder: (context, viewModel, child){
                final user = viewModel.user;
                return Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color(0xFF71B3FF),
                    borderRadius: BorderRadius.circular(16)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 17),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          // We'll update soon
                          child: Image.asset('assets/images/logo.jpg', width: 90, height: 90,),
                        ),
                        Text(user?.name ?? 'Loading...', maxLines: 1, overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.ubuntu(
                          fontSize: 22,
                          fontWeight: FontWeight.w500
                        ),),
                        Text(user?.email ?? 'Loading...', maxLines: 1, overflow: TextOverflow.ellipsis, 
                        style: GoogleFonts.ubuntu(
                          fontSize: 16,
                          fontWeight: FontWeight.w400
                        ),)
                      ],
                    ),
                  ),
                );
              }
            ),
            SizedBox(height: 17,),
            Consumer<UserViewmodel>(
              builder: (context, viewModel, child){
                final user = viewModel.user;
                return Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color(0xFF71B3FF),
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15, right: 14, bottom: 15, top: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('About me', style: GoogleFonts.ubuntu(
                          fontSize: 19,
                          fontWeight: FontWeight.w500
                        ),),
                        SizedBox(height: 6,),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Color(0xFFBCDBFF),
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(width: 1.5, color: Color(0xFFF5F5F5))
                          ),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(7, 5, 3, 5),
                            child: Text(user?.aboutMe ?? 'Descript anything about you here.',
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.ubuntu(
                              fontSize: 12,
                              fontWeight: FontWeight.w400
                            ),),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }
            ),
            SizedBox(height: 17,),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xFF71B3FF),
                borderRadius: BorderRadius.circular(10)
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    child: Text('Settings', style: GoogleFonts.ubuntu(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.white
                    ),),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque, //Use this to get the whole raw tappable
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder:(context) => EditProfileScreen(),)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(25)
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(Icons.person_2_outlined),
                                ),
                              ),
                              SizedBox(width: 15,),
                              Text('Edit Profile', style: GoogleFonts.ubuntu(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.white
                              ),)
                            ],
                          ),
                          Icon(Icons.arrow_forward_ios_outlined, size: 17, color: Colors.white,)
                        ],
                      ),
                    ),
                  ),
                  Divider(color: Colors.white, thickness: 1.2,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque, //Use this to get the whole raw tappable
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder:(context) => ChangePasswordScreen(),)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(25)
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(Icons.lock_outline_rounded),
                                ),
                              ),
                              SizedBox(width: 15,),
                              Text('Change password', style: GoogleFonts.ubuntu(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.white
                              ),)
                            ],
                          ),
                          Icon(Icons.arrow_forward_ios_outlined, size: 17, color: Colors.white,)
                        ],
                      ),
                    ),
                  ),
                  Divider(color: Colors.white, thickness: 1.2,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque, //Use this to get the whole raw tappable
                      onTap: (){
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              backgroundColor: Color(0xFFD9D9D9),
                              content: SizedBox(
                                width: double.maxFinite,
                                child: MyDeleteAlertContent(title: 'Delete Account?', content: 'This is permanent and cannot be undone. All your data will be lost.',
                                onTap: () async {
                                  final bool status = await userVM.deleteAccount();
                                  if(status == true){
                                    //Add success message to user
                                    print(status);
                                    if(!context.mounted) return;
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(builder: (context) => const RegisterScreen()),
                                      (route) => false, // This removes all previous screens from the memory stack
                                    );
                                  }else {
                                    //Add error message to user
                                    print(userVM.errorMessage);
                                  }
                                },
                                ),
                              ));
                          },
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(25)
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(Icons.close),
                                ),
                              ),
                              SizedBox(width: 15,),
                              Text('Delete account', style: GoogleFonts.ubuntu(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.white
                              ),)
                            ],
                          ),
                          Icon(Icons.arrow_forward_ios_outlined, size: 17, color: Colors.white,)
                        ],
                      ),
                    ),
                  ),
                  Divider(color: Colors.white, thickness: 1.2,),
                  GestureDetector(
                    onTap: () async {
                      final bool status = await userVM.logout();
                      if(status == true){
                        if(!context.mounted) return;
                        Navigator.pushAndRemoveUntil(context,
                          MaterialPageRoute(builder: (context) => RegisterScreen()),
                          (route) => false, // This removes all previous screens from the memory stack
                        );
                      }else {
                        //Give error message to user
                        print('Failed logout!!!');
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15, bottom: 10),
                      child: Text('Logout', style: GoogleFonts.ubuntu(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFFFF4444)
                      ),),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyDeleteAlertContent extends StatelessWidget {
  final String? uid;
  final String? noteId;
  final String title;
  final String content;
  final Function onTap;
  const MyDeleteAlertContent({super.key, required this.title, required this.content, this.uid, this.noteId, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final userVM = Provider.of<UserViewmodel>(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(title, style: GoogleFonts.ubuntu(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.black
        ),),
        SizedBox(height: 2,),
        Text(content, textAlign: TextAlign.center, style: GoogleFonts.ubuntu(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: Colors.black
        ),),
        SizedBox(height: 13,),
        InkWell(
          onTap: () => onTap(),
          child: Container(
            height: 40,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(7)
            ),
            child: Center(
              child: userVM.isLoading ?
              CircularProgressIndicator(color: Colors.white,) :
              Text('Delete', style: GoogleFonts.ubuntu(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.white
              ),),
            ),
          ),
        ),
        SizedBox(height: 7,),
        InkWell(
          onTap: () => Navigator.pop(context),
          child: Container(
            height: 40,
            decoration: BoxDecoration(
              color: const Color.fromARGB(39, 33, 149, 243),
              borderRadius: BorderRadius.circular(7)
            ),
            child: Center(child: Text('Cancel', style: GoogleFonts.ubuntu(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Colors.blue
            ),),),
          ),
        ),
      ],
    );
  }
}