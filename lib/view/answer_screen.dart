import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:q_dev_app/viewModel/question_viewmodel.dart';
import 'package:readmore_flutter/readmore_flutter.dart';

class AnswerScreen extends StatefulWidget {
  final int id;
  const AnswerScreen({super.key, required this.id});

  @override
  State<AnswerScreen> createState() => _AnswerScreenState();
}

class _AnswerScreenState extends State<AnswerScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Use a post-frame callback to safely look up your active Provider instance
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<QuestionViewmodel>(context, listen: false).fetchAnswer(widget.id);
    });
  }
  @override
  Widget build(BuildContext context) {
    final questionVM = Provider.of<QuestionViewmodel>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFFF0F7FF),
      appBar: AppBar(
        leading: BackButton(color: Colors.white,),
        backgroundColor: Color(0xFF4C9FFF),
      ),
      body: questionVM.isLoading ? Center(child: CircularProgressIndicator(color: Colors.black,),)
      : questionVM.selectedQuestion == null
      ? const Center(child: Text('Something went wrong!!!'))
      : Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                            Text(questionVM.selectedQuestion!.user?.name ?? 'Anonymous', style: GoogleFonts.ubuntu(
                              fontSize: 17,
                              fontWeight: FontWeight.w500
                            ),),
                            // Access to every tags
                            Text(questionVM.selectedQuestion!.tags.map((tag) => '#$tag').join(' '), maxLines: 1, overflow: TextOverflow.ellipsis, style: GoogleFonts.ubuntu(
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
                Text(questionVM.selectedQuestion!.content ?? 'No content provided', style: GoogleFonts.ubuntu(
                  fontSize: 19,
                  fontWeight: FontWeight.w400,
                ),),
                SizedBox(height: 5,),
                Row(
                  children: [
                    Icon(Icons.thumb_up_outlined,),
                    SizedBox(width: 3,),
                    Text('${questionVM.selectedQuestion!.likesCount} Likes', style: GoogleFonts.ubuntu(
                      fontSize: 15,
                      fontWeight: FontWeight.w400
                    ),),
                    SizedBox(width: 20,),
                    Icon(Icons.comment_outlined,),
                    SizedBox(width: 3,),
                    Text('${questionVM.selectedQuestion!.answersCount} answer', style: GoogleFonts.ubuntu(
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
            padding: const EdgeInsets.only(left: 15, right: 15, top: 5),
            child: Text('Answer', style: GoogleFonts.ubuntu(
              fontSize: 19,
              fontWeight: FontWeight.w500
            )),
          ),
          Consumer<QuestionViewmodel>(
            builder: (context, questionVM, child) { 
              if (questionVM.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (questionVM.errorMessage != null) {
                return Center(
                  child: Text(
                    questionVM.errorMessage!,
                    style: const TextStyle(color: Colors.red, fontSize: 16),
                  ),
                );
              }
              if (questionVM.selectedQuestion!.answers.isEmpty) {
                return Center(
                  child: Text(
                    'There is no answer yet.',
                    style: const TextStyle(fontSize: 16),
                  ),
                );
              }
              return Expanded(
              child: ListView.builder(
                itemCount: questionVM.selectedQuestion!.answers.length,
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                itemBuilder: (context, index) {
                final currentAnswer = questionVM.selectedQuestion!.answers[index];
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: Image.asset('assets/images/logo.jpg', width: 35, height: 35,)
                            ),
                            SizedBox(width: 8,),
                            Text(currentAnswer.user?.name ?? 'Anonymous', style: GoogleFonts.ubuntu(
                              fontSize: 16,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: ReadMore(currentAnswer.answerText,
                          minLines: 2,
                          style: GoogleFonts.ubuntu(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Colors.black
                          ),
                          readMoreText: 'Read more',
                          readMoreStyle: GoogleFonts.ubuntu(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF075594)
                          ),
                          readLessText: 'Read less',
                        ),),
                        Icon(Icons.thumb_up_alt_outlined)
                      ],
                    )
                  ],
                );
              }),
            );
          })
        ],
      ),
      
    );
  }
}