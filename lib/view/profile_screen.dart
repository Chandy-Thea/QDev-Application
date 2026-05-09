import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Column(
          children: [
            Container(
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
                      child: Image.asset('assets/images/logo.jpg', width: 90, height: 90,),
                    ),
                    Text('Marshemllo', style: GoogleFonts.ubuntu(
                      fontSize: 22,
                      fontWeight: FontWeight.w500
                    ),),
                    Text('realtheachandy@gmail.com', style: GoogleFonts.ubuntu(
                      fontSize: 16,
                      fontWeight: FontWeight.w400
                    ),)
                  ],
                ),
              ),
            ),
            SizedBox(height: 17,),
            Container(
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
                        child: Text('30% coffee, 70% unanswered emails. I’m basically a urban legend: '
                        'occasionally spotted in the wild at 2 AM near a snack aisle, but mostly just '
                        'a series of funny Slack messages. If found, please return to the nearest quiet library.',
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
                  Divider(color: Colors.white, thickness: 1.2,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
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
                  Divider(color: Colors.white, thickness: 1.2,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
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
                            Text('Delete my account', style: GoogleFonts.ubuntu(
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
                  Divider(color: Colors.white, thickness: 1.2,),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, bottom: 10),
                    child: Text('Logout', style: GoogleFonts.ubuntu(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFFFF4444)
                    ),),
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