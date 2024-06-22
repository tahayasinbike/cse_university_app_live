import 'package:cse_university_app/pages/auth/widgets/auth_widgets.dart';
import 'package:cse_university_app/utils/custom_colors.dart';
import 'package:cse_university_app/widgets/custom_sizedBox.dart';
import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final AuthWidgets authWidgets = AuthWidgets();
  final formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: CustomColors.darkPurple,
          body: SafeArea(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(flex: 7, child: customSizedBox(5)),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: authWidgets.emailField(
                          emailController: _emailController),
                    ),
                  ),
                  customSizedBox(20),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: ForgotPassword(emailController: _emailController),
                    ),
                  ),
                  Expanded(flex: 7, child: customSizedBox(5)),
                  Expanded(
                      flex: 1,
                      child: IconButton(
                          onPressed: () => Navigator.of(context).pop(),
                          icon: Icon(
                            UniconsLine.multiply,
                            color: CustomColors.white,
                          ))),
                  Expanded(flex: 1, child: customSizedBox(5)),
                  /* TextFormField(
                controller: _emailController,
                cursorColor: CustomColors.white,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(labelText: "Email"),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (email) => 
                email != null 
                 ? "Geçerli Mail Giriniz"
                 : null
              ), */
                ],
              ),
            ),
          )),
    );
  }
}
