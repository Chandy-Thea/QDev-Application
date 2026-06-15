import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:q_dev_app/auth_wrapper.dart';
import 'package:q_dev_app/view/edit_profile_screen.dart';
import 'package:q_dev_app/view/forgot_password_screen.dart';
import 'package:q_dev_app/view/home_screen.dart';
import 'package:q_dev_app/view/login_screen.dart';
import 'package:q_dev_app/view/profile_screen.dart';
import 'package:q_dev_app/view/register_screen.dart';
import 'package:q_dev_app/view/search_screen.dart';
import 'package:q_dev_app/view/tabs_screen.dart';
import 'package:q_dev_app/viewModel/question_viewmodel.dart';
import 'package:q_dev_app/viewModel/user_viewmodel.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserViewmodel()..fetchUser()),
        ChangeNotifierProvider(create: (_) => QuestionViewmodel()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QDev Application',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: AuthWrapper()
    );
  }
}