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
  final TextEditingController _answerController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<QuestionViewmodel>(context, listen: false).fetchAnswer(widget.id);
    });
  }

  // Remember to dispose of the controller to prevent memory leaks
  @override
  void dispose() {
    _answerController.dispose();
    super.dispose();
  }

  // Handle submission logic
  void _submitAnswer(QuestionViewmodel questionVM) async {
    final text = _answerController.text.trim();
    
    if (text.isNotEmpty) {
      await questionVM.postAnswer(widget.id, text);
      await questionVM.fetchAnswer(widget.id);
      
      _answerController.clear();
      if(!mounted) return;
      FocusScope.of(context).unfocus(); // Closes the keyboard
    }
  }

  @override
  Widget build(BuildContext context) {
    final questionVM = Provider.of<QuestionViewmodel>(context);
    
    return Scaffold(
      resizeToAvoidBottomInset: true, 
      backgroundColor:  Color(0xFFF0F7FF),
      appBar: AppBar(
        leading:  BackButton(color: Colors.white,),
        backgroundColor:  Color(0xFF4C9FFF),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus(); // Closes the keyboard
        },
        child: questionVM.isLoading 
          ?  Center(child: CircularProgressIndicator(color: Colors.black,),)
          : questionVM.selectedQuestion == null
          ?  Center(child: Text('Something went wrong!!!'))
          : Column(
          children: [
          Expanded(
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 15, vertical: 15),
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
                                    Text(questionVM.selectedQuestion!.tags.map((tag) => '#$tag').join(' '), maxLines: 1, overflow: TextOverflow.ellipsis, style: GoogleFonts.ubuntu(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                      color:  Color(0xFF075594)
                                    ),)
                                  ],
                                ),
                              ],
                            ),
                            Text('4h ago', style: GoogleFonts.ubuntu(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color:  Color(0xFF5B5B5B)
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
                    padding:  EdgeInsets.only(top: 10, bottom: 5),
                    child: Center(
                      child: Text('Answer', style: GoogleFonts.ubuntu(
                        fontSize: 19,
                        fontWeight: FontWeight.w500
                      )),
                    ),
                  ),
                  
                  // Answers list inside the scrollable view
                  Consumer<QuestionViewmodel>(
                    builder: (context, questionVM, child) { 
                      if (questionVM.isLoading) {
                        return  Center(child: CircularProgressIndicator());
                      }
                      if (questionVM.errorMessage != null) {
                        return Center(
                          child: Text(
                            questionVM.errorMessage!,
                            style:  TextStyle(color: Colors.red, fontSize: 16),
                          ),
                        );
                      }
                      if (questionVM.selectedQuestion!.answers.isEmpty) {
                        return Padding(
                          padding:  EdgeInsets.symmetric(vertical: 30),
                          child: Center(
                            child: Text(
                              'There is no answer yet.',
                              style: GoogleFonts.ubuntu(fontSize: 16),
                            ),
                          ),
                        );
                      }
                      return ListView.builder(
                        shrinkWrap: true, // Crucial for nested scrolling layouts
                        physics:  NeverScrollableScrollPhysics(), // Passes scroll gestures up to parent
                        itemCount: questionVM.selectedQuestion!.answers.length,
                        padding:  EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                        itemBuilder: (context, index) {
                          final currentAnswer = questionVM.selectedQuestion!.answers[index];
                          return Padding(
                            padding:  EdgeInsets.only(bottom: 15.0),
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
                                    color:  Color(0xFF5B5B5B)
                                  ),)
                                ],),
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
                                        color:  Color(0xFF075594)
                                      ),
                                      readLessText: 'Read less',
                                    ),
                                  ),
                                  Icon(Icons.thumb_up_alt_outlined)
                                ],)
                            ],),
                          );
                        },
                      );
                    },
                  )
                ],
              ),),
            ),
            // Answer Box
            Container(
              padding:  EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(34, 0, 0, 0),
                    offset:  Offset(0, -2),
                    blurRadius: 4,
                  ),
                ],
              ),
              child: SafeArea(
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _answerController,
                        minLines: 1,
                        maxLines: 4,
                        textCapitalization: TextCapitalization.sentences,
                        style: GoogleFonts.ubuntu(fontSize: 16),
                        decoration: InputDecoration(
                          hintText: 'Write an answer...',
                          hintStyle: GoogleFonts.ubuntu(color: Colors.grey[400]),
                          contentPadding:  EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 10.0,
                          ),
                          filled: true,
                          fillColor:  Color(0xFFF0F7FF),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(24.0),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 8.0),
                    IconButton(
                      icon:  Icon(Icons.send_rounded),
                      color:  Color(0xFF4C9FFF),
                      onPressed: () => _submitAnswer(questionVM),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}