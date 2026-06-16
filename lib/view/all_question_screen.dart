import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:q_dev_app/view/answer_screen.dart';
import 'package:q_dev_app/view/search_screen.dart';
import 'package:q_dev_app/viewModel/question_viewmodel.dart';

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
                QuestionTabContent(filter: 'popular'),
                QuestionTabContent(filter: 'newest'),
                QuestionTabContent(filter: 'oldest')
            ]),
          ),
        ],
      ),
    );
  }
}


class QuestionTabContent extends StatefulWidget {
  final String filter;

  const QuestionTabContent({super.key, required this.filter});

  @override
  State<QuestionTabContent> createState() => _QuestionTabContentState();
}

// Add AutomaticKeepAliveClientMixin so sliding between tabs doesn't destroy data!
class _QuestionTabContentState extends State<QuestionTabContent> with AutomaticKeepAliveClientMixin {
  
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    // This runs exactly ONCE when the user navigates to this screen.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<QuestionViewmodel>(context, listen: false).fetchQuestions(widget.filter);
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // Required by Mixin

    return Consumer<QuestionViewmodel>(
      builder: (context, questionVM, child) {
        if (questionVM.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (questionVM.errorMessage != null) {
          return Center(child: Text(questionVM.errorMessage!, style: const TextStyle(color: Colors.red)));
        }

        final categoryQuestions = questionVM.getQuestion(widget.filter);

        if (categoryQuestions == null || categoryQuestions.isEmpty) {
          return const Center(child: Text('No questions found.'));
        }

        return ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: categoryQuestions.length,
          itemBuilder: (context, index) {
            final currentQuestion = categoryQuestions[index];

            return GestureDetector(
              onTap: () => Navigator.push(
                context, 
                MaterialPageRoute(builder: (context) => AnswerScreen()),
              ),
              child: MyQuestionBox(
                imageUrl: currentQuestion.user?.profileUrl ?? 'assets/images/logo.jpg',
                name: currentQuestion.user?.name ?? 'Anonymous',
                time: '4',
                question: currentQuestion.content ?? 'No content provided',
                like: currentQuestion.likesCount,
                answer: currentQuestion.answersCount,
              ),
            );
          },
        );
      },
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
              child: GestureDetector(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder:(context) => SearchScreen(),)),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 1.5, color: Color(0xFFFFFFFF))
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: TextField(
                      readOnly: true,
                      enabled: false,
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
          crossAxisAlignment: CrossAxisAlignment.start,
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