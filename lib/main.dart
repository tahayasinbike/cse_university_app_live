//import 'dart:io';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:cse_university_app/firebase_options.dart';
import 'package:cse_university_app/state/state.dart';
import 'package:cse_university_app/theme/application_themes.dart';
import 'package:cse_university_app/utils/custom_colors.dart';
import 'package:cse_university_app/widget_tree.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<void> main() async {
  await WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      //saat kısmını beyaz yapıyor
      value: SystemUiOverlayStyle.light,
      child: MaterialApp(
        scaffoldMessengerKey: Utils.messengerKey,
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: myTheme,
        /* routes: {
            "/widgetTree" : (context) => const WidgetTree(),
            "/loginPage" :(context) => const LoginPage(),
            "/homePage" :(context) => const MainPage()
          }, */
        home: AnimatedSplashScreen(
            splash: Image.asset("assets/white.png"),
            duration: 1500,
            backgroundColor: CustomColors.darkPurple,
            splashTransition: SplashTransition.fadeTransition,
            nextScreen: const WidgetTree()),
      ),
    );
  }
}
