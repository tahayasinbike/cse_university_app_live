import 'dart:async';
import 'package:cse_university_app/pages/main_page/main_page.dart';
import 'package:cse_university_app/utils/custom_colors.dart';
import 'package:cse_university_app/widgets/custom_sizedBox.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';

class VerifyPage extends StatefulWidget {
  const VerifyPage({super.key});

  @override
  State<VerifyPage> createState() => _VerifyPageState();
}

class _VerifyPageState extends State<VerifyPage> {
  bool isEmailVerified = false;
  bool canResendEmail = false;
  Timer? timer;
  @override
  void initState() {
    super.initState();
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    if (!isEmailVerified) {
      sendVerificationEmail();
      timer = Timer.periodic(
        Duration(seconds: 3),
        (_) => checkEmailVerified(),
      );
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });
    if (isEmailVerified) timer?.cancel();
  }

  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();

      setState(() => canResendEmail = false);
      await Future.delayed(Duration(seconds: 5));
      setState(() => canResendEmail = true);
    } catch (e) {
      /* Utils.showSnackBar(e.toString()); */
    }
  }

  @override
  Widget build(BuildContext context) => isEmailVerified
      ? MainPage()
      : Scaffold(
          appBar: AppBar(
            title: Text(
              "Emailinizi Onaylayın",
              style: Theme.of(context).textTheme.displayLarge,
            ),
          ),
          body: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Email Onay Mesajı Gönderildi",
                  style: TextStyle(fontSize: 20, color: CustomColors.mintGreen),
                ),
                customSizedBox(10),
                ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size.fromHeight(50)),
                    onPressed: canResendEmail ? sendVerificationEmail : null,
                    icon: Icon(UniconsLine.envelope_upload),
                    label: Text(
                      "Tekrar Gönder",
                      style: TextStyle(fontSize: 24),
                    )),
                customSizedBox(5),
                TextButton(
                    onPressed: () => FirebaseAuth.instance.signOut(),
                    child: Text(
                      "Kapat",
                      style: TextStyle(color: CustomColors.grey, fontSize: 24),
                    ))
              ],
            ),
          ),
        );
}
