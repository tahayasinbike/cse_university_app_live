import 'package:cse_university_app/pages/auth/forgot_pass.dart';
import 'package:cse_university_app/pages/auth/widgets/auth_widgets.dart';
import 'package:cse_university_app/state/state.dart';
import 'package:cse_university_app/utils/custom_colors.dart';
import 'package:cse_university_app/widgets/custom_sizedBox.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback onClickedSignUp;

  const LoginPage({
    Key? key,
    required this.onClickedSignUp,
  }) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final ceng = Uri.parse("https://www.istunceng.com/");
  final AuthWidgets authWidgets = AuthWidgets();
  String errorMessage = "";
  bool isLogin = true;

  final StateManage vm = StateManage();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String topImage = "assets/login.png";
    String bottomImage = "assets/cseist.png";

    return PopScope(
      canPop: false,
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
                        authWidgets
                            .greyTitle("Lütfen devam etmek için giriş yapın."),
                        customSizedBox(10),
                        authWidgets.emailField(
                            emailController: _emailController),
                        customSizedBox(5),
                        passwordField(passwordController: _passwordController),
                        customSizedBox(10),
                        SignIn(
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
                    Column(
                      children: [
                        RichText(
                            text: TextSpan(
                                style: TextStyle(
                                    color: CustomColors.grey, fontSize: 15),
                                text: "Hesabın yok mu?",
                                children: [
                              TextSpan(
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = widget.onClickedSignUp,
                                  text: " Kayıt Ol",
                                  style: TextStyle(
                                      color: CustomColors.yellow, fontSize: 15))
                            ])),
                        customSizedBox(5),
                        GestureDetector(
                            child: Text(
                              "Şifremi Unuttum",
                              style: TextStyle(
                                  color: CustomColors.red, fontSize: 15),
                            ),
                            onTap: () =>
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ForgotPasswordPage(),
                                ))),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
