import 'package:cse_university_app/utils/custom_colors.dart';
import 'package:flutter/material.dart';

final ThemeData myTheme = ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    useMaterial3: true,
    primaryTextTheme:
        const TextTheme(titleMedium: TextStyle(color: Colors.white)),
    iconButtonTheme: IconButtonThemeData(
      style: ButtonStyle(
        iconColor: WidgetStateProperty.resolveWith<Color?>((states) {
          // Durumları inceleyerek farklı renkler döndürebilirsiniz.
          if (states.contains(WidgetState.pressed)) {
            return Colors.blue; // Basıldığında renk
          }
          return const Color(0xffa5d7e8); // Varsayılan renk
        }),
      ),
    ),
    iconTheme: const IconThemeData(color: Color(0xffa5d7e8)),
    drawerTheme: const DrawerThemeData(
        backgroundColor: CustomColors.darkPurple,
        shadowColor: Color(0xffa5d7e8)),
    appBarTheme: const AppBarTheme(
      color: Color(0xff19376D),
    ),
    scaffoldBackgroundColor: CustomColors.darkPurple,
    primaryColor: const Color(0xff19376D),
    secondaryHeaderColor: const Color(0xff576CBC),
    textTheme: const TextTheme(
        bodyMedium: TextStyle(
          color: Color(0xff19376D),
          fontSize: 18,
        ),
        displayLarge: TextStyle(
            color: Color.fromARGB(255, 236, 242, 244),
            fontWeight: FontWeight.bold,
            fontSize: 24,
            shadows: [
              BoxShadow(blurRadius: 6, offset: Offset(0, 1), spreadRadius: 2)
            ]),
        displayMedium:
            TextStyle(fontSize: 18, color: Color(0xffa5d7e8), shadows: [
          BoxShadow(
              color: Colors.black,
              blurRadius: 10,
              offset: Offset(0, 1),
              spreadRadius: 5)
        ]),
        displaySmall:
            TextStyle(fontSize: 13, color: Color(0xffa5d7e8), shadows: [
          BoxShadow(
              color: Colors.black,
              blurRadius: 10,
              offset: Offset(0, 1),
              spreadRadius: 5)
        ])));
