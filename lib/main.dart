import 'package:flutter/material.dart';
import 'package:q_dev_app/view/home_screen.dart';
import 'package:q_dev_app/view/login_screen.dart';
import 'package:q_dev_app/view/register_screen.dart';
import 'package:q_dev_app/view/tabs_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QDev Application',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: TabsScreen()
    );
  }
}