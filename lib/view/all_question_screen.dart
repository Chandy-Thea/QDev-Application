import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:q_dev_app/view/answer_screen.dart';

class AllQuestionScreen extends StatefulWidget {
  const AllQuestionScreen({super.key});

  @override
  State<AllQuestionScreen> createState() => _AllQuestionScreenState();
}

class _AllQuestionScreenState extends State<AllQuestionScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            toolbarHeight: 52,
            backgroundColor: Colors.blue,
            flexibleSpace: FlexibleSpaceBar(
              background: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
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
            bottom: TabBar(
              labelColor: Colors.white,
              indicatorColor: Colors.white,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorWeight: 3,
              tabs: [
                Text('Popular', style: GoogleFonts.ubuntu(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white
                ),),
                Text('Newest', style: GoogleFonts.ubuntu(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white
                ),),
                Text('Oldest', style: GoogleFonts.ubuntu(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white
                ),)
              ]
            ),
          ),
          SliverFillRemaining(
            child: TabBarView(
              children: [
                ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: 7,
                  itemBuilder: (context, index){
                    return GestureDetector(
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder:(context) => AnswerScreen(),)),
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                        decoration: BoxDecoration(
                          color: Color(0xFFE8F3FF),
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
                ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: 7,
                  itemBuilder: (context, index){
                    return GestureDetector(
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder:(context) => AnswerScreen(),)),
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                        decoration: BoxDecoration(
                          color: Color(0xFFE8F3FF),
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
                ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: 7,
                  itemBuilder: (context, index){
                    return GestureDetector(
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder:(context) => AnswerScreen(),)),
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                        decoration: BoxDecoration(
                          color: Color(0xFFE8F3FF),
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
            ]),
          ),
        ],
      ),
    );
  }
}