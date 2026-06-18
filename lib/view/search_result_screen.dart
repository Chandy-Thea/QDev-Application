import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:q_dev_app/view/answer_screen.dart';
import 'package:q_dev_app/view/home_screen.dart';
import 'package:q_dev_app/viewModel/question_viewmodel.dart';

class SearchResultScreen extends StatelessWidget {
  final String defaultText;
  const SearchResultScreen({super.key, required this.defaultText});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFFF0F7FF),
      body: Consumer<QuestionViewmodel>(
        builder: (context, questionVM, child) {
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: true,
                toolbarHeight: 62,
                automaticallyImplyLeading: false, 
                backgroundColor: Colors.blue,
                flexibleSpace: FlexibleSpaceBar(
                  background: MySearchBar(title: 'Search', defaultText: defaultText,),
                ),
              ),

              if (questionVM.isLoading)
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: CircularProgressIndicator(color: Colors.blue),
                  ),
                )

              else if (questionVM.errorMessage != null)
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: Text(
                      questionVM.errorMessage!,
                      style: TextStyle(color: Colors.red, fontSize: 16),
                    ),
                  ),
                )

              else if (questionVM.searchResults.isEmpty)
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: Text(
                      'No questions match your search parameters.', 
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                )

              else
                SliverList.builder(
                  itemCount: questionVM.searchResults.length,
                  itemBuilder: (context, index) {
                    final currentQuestion = questionVM.searchResults[index];
                    
                    return GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AnswerScreen(id: currentQuestion.id),
                          ),
                        );
                      },
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(14, 10, 14, 0),
                            child: QuestionBox(
                              name: currentQuestion.user?.name ?? 'Anonymous', 
                              quesText: currentQuestion.content ?? 'No content provided', 
                              likeNum: currentQuestion.likesCount, 
                              answerNum: currentQuestion.answersCount, 
                              time: '4h', 
                              imageUrl: 'assets/images/logo.jpg',
                            ),
                          ),
                          SizedBox(height: 10),
                          Divider(height: 0, thickness: 1.5),
                        ],
                      ),
                    );
                  },
                ),
            ],
          );
        },
      ),
    );
  }
}

class MySearchBar extends StatefulWidget {
  final String title;
  final String defaultText;
  const MySearchBar({super.key, required this.title, required this.defaultText});

  @override
  State<MySearchBar> createState() => _MySearchBarState();
}

class _MySearchBarState extends State<MySearchBar> {
  TextEditingController searchController = TextEditingController();
  bool onSearch = false;
  // Update defualt text to search bar
  @override
  void initState() {
    super.initState();
    // ✅ Initialize the field with the search term from the previous screen
    searchController = TextEditingController(text: widget.defaultText);
    onSearch = widget.defaultText.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    final questionVM = Provider.of<QuestionViewmodel>(context, listen: false);

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(right: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BackButton(
              onPressed: () => Navigator.popUntil(context, (route) => route.isFirst),
              color: Colors.white
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 1.5, color: Color(0xFFFFFFFF)),
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: 12),
                  child: TextField(
                    controller: searchController,
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        if (!onSearch) {
                          setState(() {
                            onSearch = true;
                          });
                        }
                      } else {
                        setState(() {
                          onSearch = false;
                        });
                      }
                    },
                    style: GoogleFonts.ubuntu(
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: widget.title,
                      hintStyle: GoogleFonts.ubuntu(
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                      icon: Icon(Icons.search, color: Colors.white, size: 20),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: onSearch ? 10 : 6),
            if (onSearch)
              GestureDetector(
                onTap: () async {
                  await questionVM.searchQuery(searchController.text);
                },
                child: Text( 'Search', style: GoogleFonts.ubuntu(
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
              )
            else
              SizedBox()
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
  
  const QuestionBox({
    super.key, 
    required this.name, 
    required this.quesText, 
    required this.likeNum, 
    required this.answerNum, 
    required this.time, 
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: Image.asset(imageUrl, width: 30, height: 30),
                ),
                SizedBox(width: 7),
                Text(name, style: GoogleFonts.ubuntu(fontSize: 15, fontWeight: FontWeight.w400)),
              ],
            ),
            Text('$time ago', style: GoogleFonts.ubuntu(fontSize: 15, fontWeight: FontWeight.w400)),
          ],
        ),
        SizedBox(height: 6),
        Text(quesText, overflow: TextOverflow.ellipsis, maxLines: 2, 
          style: GoogleFonts.ubuntu(fontSize: 17, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(Icons.thumb_up_outlined, size: 20),
                SizedBox(width: 3),
                Text('$likeNum Likes', style: GoogleFonts.ubuntu(fontSize: 14, fontWeight: FontWeight.w400)),
                SizedBox(width: 20),
                Icon(Icons.comment_outlined, size: 20),
                SizedBox(width: 3),
                Text('$answerNum answers', style: GoogleFonts.ubuntu(fontSize: 14, fontWeight: FontWeight.w400)),
              ],
            ),
            Row(
              children: [
                Text('View ques', style: GoogleFonts.ubuntu(fontSize: 14, fontWeight: FontWeight.w400)),
                SizedBox(width: 5),
                Icon(Icons.arrow_forward_rounded, size: 18),
              ],
            )
          ],
        ),
      ],
    );
  }
}