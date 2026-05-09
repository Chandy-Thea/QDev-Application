import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:q_dev_app/view/answer_screen.dart';

class MyQuestionScreen extends StatefulWidget {
  const MyQuestionScreen({super.key});

  @override
  State<MyQuestionScreen> createState() => _MyQuestionScreenState();
}

class _MyQuestionScreenState extends State<MyQuestionScreen> {
  TextEditingController quesController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: true,
          toolbarHeight: 62,
          backgroundColor: Colors.blue,
          flexibleSpace: FlexibleSpaceBar(
            background: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(width: 1.5, color: Color(0xFFFFFFFF))
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 12),
                          child: TextField(
                            style: GoogleFonts.ubuntu(
                              fontSize: 17,
                              fontWeight: FontWeight.w400,
                              color: Colors.white
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Search',
                              hintStyle: GoogleFonts.ubuntu(
                                fontSize: 17,
                                fontWeight: FontWeight.w400,
                                color: Colors.white
                              ),
                              icon: Icon(Icons.search, color: Colors.white, size: 20,)
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 16,),
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(width: 2, color: Color(0xFF8FC3FF))
                      ),
                      child: Icon(Icons.notifications_none_outlined, color: Colors.white,),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(child: SizedBox(height: 12,)),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Any question?', style: GoogleFonts.ubuntu(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                      color: Colors.black
                    ),),
                    Text('Create your new question', style: GoogleFonts.ubuntu(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.black
                    ))
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context, 
                      builder: (context){
                        return AlertDialog(
                          backgroundColor: Color(0xFFEBF4FF),
                          title: Text('Create question', style: GoogleFonts.ubuntu(
                            fontSize: 23,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF003E85)
                          ),),
                          shape: RoundedRectangleBorder(
                           borderRadius: BorderRadius.circular(16),
                          ),
                          content: SizedBox(
                            width: double.maxFinite,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                MyTextField(controller: quesController, label: 'Enter your question', header: 'Question'),
                                SizedBox(height: 7,),
                                Text('Add tags', style: GoogleFonts.ubuntu(
                                  fontSize: 17, color: Colors.black
                                )),
                                SizedBox(height: 7,),
                                SizedBox(
                                  height: 40,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: 5,
                                    itemBuilder: (context, index){
                                      return Container(
                                        margin: EdgeInsets.only(right: 8),
                                        decoration: BoxDecoration(
                                          color: Color(0xFF0076FF),
                                          borderRadius: BorderRadius.circular(8)
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                                          child: Text('Computer Science', style: GoogleFonts.ubuntu(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.white
                                          ),),
                                        ),
                                      );
                                    }
                                  ),
                                ),
                              ],
                            ),
                          ),
                          actions: [
                            GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0xFF4C9FFF),
                                  borderRadius: BorderRadius.circular(6)
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                                  child: Text('Create question', style: GoogleFonts.ubuntu(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white
                                  ),),
                                ),
                              ),
                            )
                          ],
                        );
                      }
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFF4C9FFF),
                      borderRadius: BorderRadius.circular(5)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Center(child: Text('Create question', style: GoogleFonts.ubuntu(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.white
                      ),)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(child: SizedBox(height: 10,),),
        SliverToBoxAdapter(
          child: Divider()
        ),
        SliverList.builder(
          itemCount: 7,
          itemBuilder: (context, index){
            return GestureDetector(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder:(context) => AnswerScreen(),)),
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                decoration: BoxDecoration(
                  color: Color(0xFFDFE4E9),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(width: 1.5, color: Color(0xFFBCBCBC))
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 13),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(25),
                                child: Image.asset('assets/images/logo.jpg', width: 30, height: 30,)
                              ),
                              SizedBox(width: 7,),
                              Text('Marshmello', style: GoogleFonts.ubuntu(
                                fontSize: 15,
                                fontWeight: FontWeight.w400
                              ),)
                            ],
                          ),
                          Text('4h ago', style: GoogleFonts.ubuntu(
                            fontSize: 15,
                            fontWeight: FontWeight.w400
                          ),)
                        ],
                      ),
                      Text('What is the difference between Computer Science and Information Technology and Why?',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: GoogleFonts.ubuntu(
                        fontSize: 17, 
                        fontWeight: FontWeight.w500
                      ),),
                      SizedBox(height: 4,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
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
                          Row(
                            children: [
                              Text('View ques', style: GoogleFonts.ubuntu(
                                fontSize: 15,
                                fontWeight: FontWeight.w400
                              ),),
                              SizedBox(width: 5,),
                              Icon(Icons.arrow_forward_rounded, size: 20,)
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
        }),
      ],
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
            fontSize: 17, color: Colors.black
          ),)
        ),
        SizedBox(height: 4,),
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
                fontSize: 17,
                color: Colors.black
              ),
              decoration: InputDecoration(
                hintText: label,
                hintStyle: GoogleFonts.ubuntu(
                fontSize: 17,
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