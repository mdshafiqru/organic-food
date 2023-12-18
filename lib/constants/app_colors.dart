// ignore_for_file: unnecessary_const

import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

//   --gray-nurse: #e3ebe3;
// --goblin: #3f8743;
// --mantis: #75b54b;
// --bottle-green: #0e4f2b;
// --sushi: #8dc448;
// --jewel: #178543;
// --apple: #62ac47;
// --envy: #94ab94;
// --viridian-green: #64846c;

  static const kBackgroundColor = Color(0xFFFFFFFF);
  static const kBaseColor = Color(0xFF2ba070);
  static const kSecondaryColor = Color(0xFF2a2b31);
  static const kPrimaryColor = Color(0xFF2a2b31);

  static const textColor1 = Color(0xFF3f3f3f);
  static const hintColor = Color(0xFFaeafb2);
  static const textColor2 = Color(0xFF5f605f);
  static const textColor3 = Color(0xFF737773);
  static const textColor4 = Color(0xFF9c9c9c);
  static const cardColor1 = Color.fromARGB(255, 36, 41, 49);
  static const textGreenColor = Color(0xFF2ba070);
  // static const textGreenColor2 = Color(0xFF2e9156);
  static const kButtonColor = Color(0xFF2ba070); // 36bb91
  static const kButtonTextColor = Colors.white;
  static const textHeadingColor1 = Color(0xFFffffff);
  static const textHeadingColor2 = Color(0xFFE3E4E5);
  static const textFieldColor = Color(0xFF1c222b);
  static const appbarColor = Color(0xFF2ba070);
  static const drawerColor = Color(0xFF2ba070);
  static const navbarColor = Color(0xFF2ba070);
  static const navbarButtonColor = Color(0xFF0e4f2b);
  static const goldenColor = Color(0XFFBA8B39);
  static const blueColor = Colors.blue;

  static const whiteColor = Colors.white;
  static const textWhite = Colors.white;
  static const redColor = Colors.red;

  static const MaterialColor kBaseColorToDark = const MaterialColor(
    0xFF178543, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    const <int, Color>{
      50: const Color(0xff15783c), //10%
      100: const Color(0xff126a36), //20%
      200: const Color(0xff105d2f), //30%
      300: const Color(0xff0e5028), //40%
      400: const Color(0xff0c4322), //50%
      500: const Color(0xff09351b), //60%
      600: const Color(0xff072814), //70%
      700: const Color(0xff051b0d), //80%
      800: const Color(0xff020d07), //90%
      900: const Color(0xff000000), //100%
    },
  );
  static const MaterialColor kBaseColorToLight = const MaterialColor(
    0xFF178543, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    const <int, Color>{
      50: const Color(0xff2e9156), //10%
      100: const Color(0xff459d69), //20%
      200: const Color(0xff5daa7b), //30%
      300: const Color(0xff74b68e), //40%
      400: const Color(0xff8bc2a1), //50%
      500: const Color(0xffa2ceb4), //60%
      600: const Color(0xffb9dac7), //70%
      700: const Color(0xffd1e7d9), //80%
      800: const Color(0xffe8f3ec), //90%
      900: const Color(0xffffffff), //100%
    },
  );
}
