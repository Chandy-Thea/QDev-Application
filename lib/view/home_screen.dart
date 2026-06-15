import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:q_dev_app/view/answer_screen.dart';
import 'package:q_dev_app/view/search_screen.dart';
import 'package:q_dev_app/viewModel/question_viewmodel.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

// 1. Keep HomeScreen alive (running) avoid refetch Questions
class _HomeScreenState extends State<HomeScreen> with AutomaticKeepAliveClientMixin {
  PageController pageController = PageController();

// 2. We also need this
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    // This runs exactly ONCE when the user navigates to this screen.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<QuestionViewmodel>(context, listen: false).fetchQuestions('popular');
    });
  }

  @override
  Widget build(BuildContext context) {
    // 3. And this
    super.build(context);
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          backgroundColor: Color(0xFFF0F7FF),
          expandedHeight: 60,
          toolbarHeight: 60,
          pinned: true,
          floating: true,
          flexibleSpace: FlexibleSpaceBar(
            background: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Header(title: 'Hi Marshmello', description: 'Welcome back, Look up something?')
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(child: SizedBox(height: 10,)),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SizedBox(
              height: 165,
              child: PageView.builder(
                scrollDirection: Axis.horizontal,
                controller: pageController,
                itemCount: 3,
                itemBuilder: (context, index){
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset('assets/images/ad.png', fit: BoxFit.cover,)
                  );
              })
            ),
          ),
        ),
        SliverToBoxAdapter(child: SizedBox(height: 5,)),
        SliverToBoxAdapter(
          child: Align(
            alignment: Alignment.center,
            child: SmoothPageIndicator(
              controller: pageController, 
              count: 3,
              effect: ExpandingDotsEffect(
                dotColor:  Color(0xFFC4C4C4),
                activeDotColor: Color(0xFF4A90E2),
                dotHeight: 6,
                dotWidth: 6,
                spacing: 4,
                expansionFactor: 4
              ),
            ),
          )
        ),
        SliverToBoxAdapter(child: SizedBox(height: 10,)),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Text('Questions for today', style: GoogleFonts.ubuntu(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1A2B48),
              decoration: TextDecoration.underline,
              decorationColor: Color(0xFF3E4A5F),
              decorationThickness: 4
            ),),
          ),
        ),
        SliverToBoxAdapter(child: SizedBox(height: 10,)),
        Consumer<QuestionViewmodel>(builder: (context, questionVM, child) {
          // 1. Show a loading spinner while API is working
          if (questionVM.isLoading) {
            return SliverToBoxAdapter(child: const Center(child: CircularProgressIndicator()));
          }

          // 2. Display a friendly error banner if the backend fails
          if (questionVM.errorMessage != null) {
            return SliverToBoxAdapter(
              child: Center(
                child: Text(
                  questionVM.errorMessage!,
                  style: const TextStyle(color: Colors.red, fontSize: 16),
                ),
              ),
            );
          }

          // 3. Fallback if the array comes back completely empty
          if (questionVM.question == null || questionVM.question!.isEmpty) {
            return SliverToBoxAdapter(child: const Center(child: Text('No questions found.')));
          }

          return SliverList.builder(
            itemCount: questionVM.question!.length,
            itemBuilder: (context, index){
              final currentQuestion = questionVM.question![index];
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
                    child: QuestionBox(name: currentQuestion.user!.name, quesText: currentQuestion.content ?? 'No content provided', 
                    likeNum: currentQuestion.likesCount, answerNum: currentQuestion.answersCount, time: '4h', imageUrl: 'assets/images/logo.jpg')
                  ),
                ),
              );
          });
        })
        // SliverFillRemaining(),
      ],
    );
  }
}

class Header extends StatelessWidget {
  final String title;
  final String description;
  const Header({super.key, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Image.asset('assets/icons/waving_hand.png', height: 36, width: 36,),
            SizedBox(width: 9,),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: GoogleFonts.ubuntu(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1A2B48)
                ),),
                Text(description, style: GoogleFonts.ubuntu(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF4F4F4F)
                ),)
              ],
            ),
          ],
        ),
        Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Color(0xFF4A90E2),
                borderRadius: BorderRadius.circular(5)
              ),
              child: Padding(
                padding: const EdgeInsets.all(7.5),
                child: Icon(Icons.notifications_none_outlined, color: Colors.white,),
              ),
            ),
            SizedBox(width: 10,),
            GestureDetector(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder:(context) => SearchScreen(),)),
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFF4A90E2),
                  borderRadius: BorderRadius.circular(5)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(7.5),
                  child: Icon(Icons.search, color: Colors.white,),
                ),
              ),
            )
          ],
        )
      ],
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