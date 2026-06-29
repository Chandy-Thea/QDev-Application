import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:q_dev_app/view/answer_screen.dart';
import 'package:q_dev_app/view/search_screen.dart';
import 'package:q_dev_app/viewModel/question_viewmodel.dart';

class MyQuestionScreen extends StatefulWidget {
  const MyQuestionScreen({super.key});

  @override
  State<MyQuestionScreen> createState() => _MyQuestionScreenState();
}

class _MyQuestionScreenState extends State<MyQuestionScreen> {
  TextEditingController quesController = TextEditingController();
  List<String> selectedTags = [];

  @override
  void initState() {
    super.initState();
    // This runs exactly ONCE when the user navigates to this screen.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<QuestionViewmodel>(context, listen: false).fetchMyQuestions();
      Provider.of<QuestionViewmodel>(context, listen: false).fetchTags();
    });
  }


  // Handle submission logic
  void _submitQuestion(QuestionViewmodel questionVM) async {
    final text = quesController.text.trim();
    
    if (text.isNotEmpty) {
      await questionVM.postQuestion(text, selectedTags);
      await questionVM.fetchMyQuestions();
      await questionVM.fetchQuestions('popular');
      
      // Clear selections for next time
      quesController.clear();
      setState(() {
        selectedTags.clear();
      });
      if (mounted) Navigator.pop(context);
    }
  }
  
  @override
  Widget build(BuildContext context) {
    final questionVM = Provider.of<QuestionViewmodel>(context);
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
                      barrierDismissible: false,
                      context: context, 
                      builder: (context){
                        //Add stateful, Every update in this widget will make it rebuild to get response UI
                        return StatefulBuilder(
                          builder: (context, setState) {
                            return AlertDialog(
                              backgroundColor: Color(0xFFEBF4FF),
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
                                        itemCount: questionVM.tags.length,
                                        itemBuilder: (context, index){
                                          final nameTag = questionVM.tags[index];
                                          return InkWell(
                                            onTap: () {
                                              setState(() {
                                                //Check if already add
                                                if(selectedTags.contains(nameTag)) {
                                                  selectedTags.remove(nameTag);
                                                  print('Remove');
                                                }else {
                                                  selectedTags.add(nameTag);
                                                  print('Add');
                                                }
                                                for ( String name in selectedTags) {
                                                  print(name);
                                                }
                                              });
                                            },
                                            child: Container(
                                              margin: EdgeInsets.only(right: 8),
                                              decoration: BoxDecoration(
                                                border: Border.all(color: selectedTags.contains(nameTag) ?Colors.blue : Color(0xFFBCBCBC), width: 1.2),
                                                borderRadius: BorderRadius.circular(8)
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                                                child: Text(nameTag ?? 'Error tags.', style: GoogleFonts.ubuntu(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                  color: selectedTags.contains(nameTag) ? Colors.blue : Colors.black
                                                ),),
                                              ),
                                            ),
                                          );
                                        }
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              actions: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.pop(context);
                                        // Clear selections for next time
                                        quesController.clear();
                                        setState(() {
                                          selectedTags.clear();
                                        });
                                      },
                                      child: Container(
                                        height: 40,
                                        decoration: BoxDecoration(
                                          color: const Color.fromARGB(39, 33, 149, 243),
                                          borderRadius: BorderRadius.circular(7)
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                                          child: Center(child: Text('Cancel', style: GoogleFonts.ubuntu(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.blue
                                          ),),),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 15,),
                                    InkWell(
                                      onTap: () async {
                                        _submitQuestion(questionVM);
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.blue,
                                          borderRadius: BorderRadius.circular(7)
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                                          child: Center(child: questionVM.isLoading ? CircularProgressIndicator(color: Colors.white,) :
                                          Text('Add', style: GoogleFonts.ubuntu(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.white
                                            ),),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            );
                          },
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
        Consumer<QuestionViewmodel>(
          builder: (context, questionVM, child) {
            if (questionVM.isLoading) {
              return SliverToBoxAdapter(child: const Center(child: CircularProgressIndicator()));
            }
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
            if (questionVM.myQuestion == null || questionVM.myQuestion!.isEmpty) {
              return SliverToBoxAdapter(child: const Center(child: Text('No questions found.')));
            }
            return SliverList.builder(
            itemCount: questionVM.myQuestion!.length,
            itemBuilder: (context, index){
              final currentQuestions = questionVM.myQuestion![index];
              return GestureDetector(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder:(context) => AnswerScreen(id: currentQuestions.id,),)),
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(width: 1.5, color: Color(0xFFBCBCBC))
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 13),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(currentQuestions.content ?? 'No content provided',
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
                                Text('View ques', style: GoogleFonts.ubuntu(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400
                                ),),
                                SizedBox(width: 5,),
                                Icon(Icons.arrow_forward_rounded, size: 20,)
                              ],
                            ),
                            Text('4h ago', style: GoogleFonts.ubuntu(
                              fontSize: 15,
                              fontWeight: FontWeight.w400
                            ),),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
          });
        })
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
              maxLines: 3,
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