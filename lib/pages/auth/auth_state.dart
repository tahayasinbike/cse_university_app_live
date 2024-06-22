import 'package:cse_university_app/pages/auth/login_page.dart';
import 'package:cse_university_app/pages/auth/register_page.dart';
import 'package:flutter/material.dart';

class AuthState extends StatefulWidget {
  const AuthState({super.key});

  @override
  State<AuthState> createState() => _AuthStateState();
}

class _AuthStateState extends State<AuthState> {
  bool isLogin = true;

  @override
  Widget build(BuildContext context) => isLogin
      ? LoginPage(onClickedSignUp: toggle)
      : SignUpPage(onClickedSignIn: toggle);
  void toggle() => setState(() => isLogin = !isLogin);
}
