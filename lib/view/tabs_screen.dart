import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:q_dev_app/view/all_question_screen.dart';
import 'package:q_dev_app/view/home_screen.dart';
import 'package:q_dev_app/view/my_question_screen.dart';
import 'package:q_dev_app/view/profile_screen.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int currentPage = 0;
  final pages = [
    HomeScreen(),
    AllQuestionScreen(),
    MyQuestionScreen(),
    ProfileScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFFF0F7FF),
      body: IndexedStack(
        index: currentPage,
        children: pages,
      ),
      bottomNavigationBar: CurvedNavigationBar(
        color: Color(0xFF4A90E2),
        backgroundColor: Colors.transparent,
        onTap: (value) {
          setState(() {
            currentPage = value;
          });
        },
        items: [
          Icon(Icons.home_outlined, size: 30, color: Colors.white,),
          Icon(Icons.menu_book_outlined, size: 30, color: Colors.white,),
          Icon(Icons.assignment_add, size: 30, color: Colors.white,),
          Icon(Icons.person_2_outlined, size: 30, color: Colors.white,)
        ]
      ),
    );
  }
}