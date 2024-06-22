import 'package:cse_university_app/pages/auth/auth_state.dart';
import 'package:cse_university_app/pages/verify/verify_page.dart';
import 'package:cse_university_app/service/auth_service.dart';
import 'package:flutter/material.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({super.key});

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: AuthService().authStateChange,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text("Bir şeyler ters gitti..."));
        } else if (snapshot.hasData) {
          return const VerifyPage();
        } else {
          return const AuthState();
        }
      },
    );
  }
}
