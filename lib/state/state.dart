import 'package:cse_university_app/main.dart';
import 'package:cse_university_app/service/auth_service.dart';
import 'package:cse_university_app/utils/custom_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
part 'state.g.dart';

class StateManage = _StateManageBase with _$StateManage;

abstract class _StateManageBase with Store {
  @observable
  String name = "tb";
  @observable
  bool obscureText = true;
  @observable
  bool isLogin = true;
  @observable
  String? errorMessage = "";
  @observable
  bool isIstunEmail = false;
  @action
  void showHide() {
    obscureText = !obscureText;
  }

  @action
  Future<void> signOut() async {
    await AuthService().signOut();
  }

  @action
  void checkEmail({required emailController}) {
    String email = emailController.text;
    RegExp regex = RegExp(r"@istun\.edu\.tr$");
    if (regex.hasMatch(email)) {
      isIstunEmail = true;
    } else {
      isIstunEmail = false;
    }
  }

  @action
  Future resetPassword(
      {required emailController, required BuildContext context}) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(
              child: CircularProgressIndicator(),
            ));
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text);
      Utils.showSnackBar("Şifre Sıfırlama Maili Gönderildi");
      Navigator.of(context).popUntil((route) => route.isFirst);
    } on FirebaseAuthException catch (e) {
      print(e);
      Utils.showSnackBar(e.message);
      Navigator.of(context).pop();
    }
  }

  @action
  Future<void> signInWithEmailAndPassword(
      {required emailController, required passwordController}) async {
    print("login button pressed");
    try {
      await AuthService().signIn(
          email: emailController.text, password: passwordController.text);
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'user-not-found':
          errorMessage = 'Kullanıcı bulunamadı';
          break;
        case 'wrong-password':
          errorMessage = 'Hatalı şifre';
          break;
        default:
          errorMessage = 'Giriş yapılırken bir sorun oluştu';
      }
      print(errorMessage);
      Utils.showSnackBar(errorMessage);
    }
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }

  @action
  Future<void> createUserWithEmailAndPassword(
      {required emailController,
      required passwordController,
      required BuildContext context}) async {
    print("create button pressed");
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(
              child: CircularProgressIndicator(),
            ));
    try {
      await AuthService().signUp(
          email: emailController.text, password: passwordController.text);
    } on FirebaseAuthException catch (e) {
      errorMessage = e.message!;
      print(errorMessage);
      Utils.showSnackBar(errorMessage);
    }
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
  ///////////////////////////
}

class Utils {
  static final messengerKey = GlobalKey<ScaffoldMessengerState>();
  static showSnackBar(String? text) {
    if (text == null) return;

    final snackBar = SnackBar(
      content: Text(text),
      backgroundColor: CustomColors.red,
    );

    messengerKey.currentState!
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}
