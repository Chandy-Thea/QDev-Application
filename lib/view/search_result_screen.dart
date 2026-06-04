import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:q_dev_app/view/answer_screen.dart';

class SearchResultScreen extends StatelessWidget {
  const SearchResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFFF0F7FF),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            toolbarHeight: 62,
            automaticallyImplyLeading: false, 
            backgroundColor: Colors.blue,
            flexibleSpace: FlexibleSpaceBar(
              background: MySearchBar(title: 'Search'),
            ),
          ),
          SliverList.builder(
            itemCount: 7,
            itemBuilder: (context, index){
              return GestureDetector(
                behavior: HitTestBehavior.opaque, //Use this to get the whole raw tappable
                onTap: () => Navigator.push(context, MaterialPageRoute(builder:(context) => AnswerScreen(),)),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(14, 10, 14, 0),
                      child: QuestionBox(name: 'Marshmello', quesText: 'What is the difference between Computer Science and Information Technology and Why?', likeNum: 10, answerNum: 3, time: '4h', imageUrl: 'assets/images/logo.jpg'),
                    ),
                    SizedBox(height: 10,),
                    Divider(height: 0, thickness: 1.5,)
                  ],
                ),
              );
          }),
        ],
      ),
    );
  }
}

class MySearchBar extends StatefulWidget {
  final String title;
  const MySearchBar({super.key, required this.title});

  @override
  State<MySearchBar> createState() => _MySearchBarState();
}

class _MySearchBarState extends State<MySearchBar> {
  TextEditingController searchController = TextEditingController();
  bool onSearch = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(right: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BackButton(color: Colors.white,),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 1.5, color: Color(0xFFFFFFFF))
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: TextField(
                    controller: searchController,
                    onChanged: (value) {
                      // Handle flexible icon when user on search
                      if(value.isNotEmpty){
                        // Not update again and again when user already on search
                        if(!onSearch){
                          setState(() {
                            onSearch = true;
                            print(onSearch);
                          });
                        }
                      }else {
                        setState(() {
                          onSearch = false;
                        });
                        print(onSearch);
                      }
                    },
                    style: GoogleFonts.ubuntu(
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                      color: Colors.white
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: widget.title,
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
            // Flexible search button
            onSearch ? SizedBox(width: 10,) : SizedBox(width: 6,),
            onSearch ? GestureDetector(
              onTap: () {
                // Reload data
              },
              child: Text('Search', style: GoogleFonts.ubuntu(
                fontSize: 17,
                fontWeight: FontWeight.w400,
                color: Colors.white
              ),),
            ) : SizedBox()
          ],
        ),
      ),
    );
  }
}

class QuestionBox extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String quesText;
  final int likeNum;
  final int answerNum;
  final String time;
  const QuestionBox({super.key, required this.name, required this.quesText, required this.likeNum, required this.answerNum, required this.time, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Column(
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
            Text('$time ago', style: GoogleFonts.ubuntu(
              fontSize: 15,
              fontWeight: FontWeight.w400
            ),)
          ],
        ),
        Text(quesText,
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
                Text('$likeNum Likes', style: GoogleFonts.ubuntu(
                  fontSize: 15,
                  fontWeight: FontWeight.w400
                ),),
                SizedBox(width: 20,),
                Icon(Icons.comment_outlined,),
                SizedBox(width: 3,),
                Text('$answerNum answer', style: GoogleFonts.ubuntu(
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
    );
  }
}