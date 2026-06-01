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
              background: MySearchBar(title: 'Search'),
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
                      child: MyQuestionBox(imageUrl: 'assets/images/logo.jpg', name: 'Marshmello', 
                      time: '4', question: 'What is the difference between Computer Sience and Infomation Technology and ...?', like: 5, answer: 3)
                    );
                }),
                ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: 3,
                  itemBuilder: (context, index){
                    return GestureDetector(
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder:(context) => AnswerScreen(),)),
                      child:  MyQuestionBox(imageUrl: 'assets/images/logo.jpg', name: 'Marshmello', 
                        time: '4', question: 'What is the difference between Computer Sience and Infomation Technology and ...?', like: 10, answer: 1)
                    );
                }),
                ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: 4,
                  itemBuilder: (context, index){
                    return GestureDetector(
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder:(context) => AnswerScreen(),)),
                      child:  MyQuestionBox(imageUrl: 'assets/images/logo.jpg', name: 'Marshmello', 
                      time: '4', question: 'What is the difference between Computer Sience and Infomation Technology and ...?', like: 4, answer: 0)
                    );
                }),
            ]),
          ),
        ],
      ),
    );
  }
}

class MySearchBar extends StatelessWidget {
  final String title;
  const MySearchBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                      hintText: title,
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
    );
  }
}

class MyQuestionBox extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String time;
  final String question;
  final int like;
  final int answer;
  const MyQuestionBox({super.key, required this.imageUrl, required this.name, required this.time, required this.question, required this.like, required this.answer});

  @override
  Widget build(BuildContext context) {
    return Container(
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
                      child: Image.asset(imageUrl, width: 30, height: 30,)
                    ),
                    SizedBox(width: 7,),
                    Text(name, style: GoogleFonts.ubuntu(
                      fontSize: 15,
                      fontWeight: FontWeight.w400
                    ),)
                  ],
                ),
                Text('${time}h ago', style: GoogleFonts.ubuntu(
                  fontSize: 15,
                  fontWeight: FontWeight.w400
                ),)
              ],
            ),
            Text(question,
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
                    Text('$like Likes', style: GoogleFonts.ubuntu(
                      fontSize: 15,
                      fontWeight: FontWeight.w400
                    ),),
                    SizedBox(width: 20,),
                    Icon(Icons.comment_outlined,),
                    SizedBox(width: 3,),
                    Text('$answer answer', style: GoogleFonts.ubuntu(
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
    );
  }
}