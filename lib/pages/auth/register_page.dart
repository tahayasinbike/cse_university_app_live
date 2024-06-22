import 'package:cse_university_app/pages/auth/widgets/auth_widgets.dart';
import 'package:cse_university_app/state/state.dart';
import 'package:cse_university_app/utils/custom_colors.dart';
import 'package:cse_university_app/widgets/custom_sizedBox.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  final VoidCallback onClickedSignIn;

  const SignUpPage({
    Key? key,
    required this.onClickedSignIn,
  }) : super(key: key);

  @override
  State<SignUpPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<SignUpPage> {
  final formKey = GlobalKey<FormState>();
  final AuthWidgets authWidgets = AuthWidgets();
  String errorMessage = "";
  bool isLogin = true;

  final StateManage vm = StateManage();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final ceng = Uri.parse("https://www.istunceng.com/");
    String topImage = "assets/login.png";
    String bottomImage = "assets/cseist.png";

    return PopScope(
      canPop: false,
      child: Form(
        key: formKey,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: CustomColors.darkPurple,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    flex: 2,
                    child: authWidgets.topImageContainer(topImage),
                  ),
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          authWidgets.loginTitle("Hoş Geldiniz"),
                          customSizedBox(5),
                          authWidgets.greyTitle(
                              "Lütfen devam etmek için giriş yapın."),
                          customSizedBox(20),
                          authWidgets.emailField(
                              emailController: _emailController),
                          customSizedBox(5),
                          passwordField(
                              passwordController: _passwordController),
                          customSizedBox(10),
                          SignUp(
                            passwordController: _passwordController,
                            emailController: _emailController,
                          ),
                          customSizedBox(5),
                          Expanded(
                            flex: 1,
                            child: authWidgets.bottomImageContainerLink(
                                bottomImage, ceng),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      RichText(
                          text: TextSpan(
                              style: TextStyle(
                                  color: CustomColors.grey, fontSize: 15),
                              text: "Zaten Hesabın Var Mı?",
                              children: [
                            TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = widget.onClickedSignIn,
                              text: " Giriş Yap",
                              style: TextStyle(
                                  color: CustomColors.yellow, fontSize: 15),
                            )
                          ])),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
