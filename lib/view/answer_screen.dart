import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AnswerScreen extends StatelessWidget {
  const AnswerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFFF0F7FF),
      appBar: AppBar(
        leading: BackButton(color: Colors.white,),
        backgroundColor: Color(0xFF4C9FFF),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: Image.asset('assets/images/logo.jpg', width: 45, height: 45,)
                        ),
                        SizedBox(width: 10,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Marshmello', style: GoogleFonts.ubuntu(
                              fontSize: 17,
                              fontWeight: FontWeight.w500
                            ),),
                            Text('#General #IT #ITE #Tech', style: GoogleFonts.ubuntu(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF075594)
                            ),)
                          ],
                        ),
                      ],
                    ),
                    Text('4h ago', style: GoogleFonts.ubuntu(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF5B5B5B)
                    ),)
                  ],
                ),
                SizedBox(height: 5,),
                Text('What is the difference between Computer Science and Information Technology Engineering?', style: GoogleFonts.ubuntu(
                  fontSize: 19,
                  fontWeight: FontWeight.w400,
                ),),
                SizedBox(height: 5,),
                Row(
                  children: [
                    Icon(Icons.thumb_up_outlined,),
                    SizedBox(width: 3,),
                    Text('10 Likes', style: GoogleFonts.ubuntu(
                      fontSize: 15,
                      fontWeight: FontWeight.w400
                    ),),
                    SizedBox(width: 20,),
                    Icon(Icons.comment_outlined,),
                    SizedBox(width: 3,),
                    Text('3 answer', style: GoogleFonts.ubuntu(
                      fontSize: 15,
                      fontWeight: FontWeight.w400
                    ),),
                  ],
                ),
              ],
            ),
          ),
          Divider(height: 0,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: Column(
              children: [
                Text('Answer', style: GoogleFonts.ubuntu(
                  fontSize: 19,
                  fontWeight: FontWeight.w500
                )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: Image.asset('assets/images/logo.jpg', width: 40, height: 40,)
                        ),
                        SizedBox(width: 10,),
                        Text('Marshmello', style: GoogleFonts.ubuntu(
                          fontSize: 17,
                          fontWeight: FontWeight.w500
                        ),),
                      ],
                    ),
                    Text('4h ago', style: GoogleFonts.ubuntu(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF5B5B5B)
                    ),)
                  ],
                ),
                SizedBox(height: 5,),
                Text('What is the difference between Computer Science and Information Technology Engineering?', style: GoogleFonts.ubuntu(
                  fontSize: 19,
                  fontWeight: FontWeight.w400,
                ),),
              ],
            ),
          ),
        ],
      ),
    );
  }
}