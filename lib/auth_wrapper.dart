import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:q_dev_app/view/register_screen.dart';
import 'package:q_dev_app/view/tabs_screen.dart';
import 'package:q_dev_app/viewModel/user_viewmodel.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final userVM = Provider.of<UserViewmodel>(context);
    //Add splash screen while fetch user info
    return userVM.user != null ? TabsScreen() : RegisterScreen();
  }
}