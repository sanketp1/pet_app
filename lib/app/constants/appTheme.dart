import 'package:flutter/material.dart';
import 'package:pet_app/app/constants/colors.dart';
import 'package:pet_app/app/constants/fonts.dart';

class AppTheme {
  static final lightTheme = ThemeData(
      appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          centerTitle: true,
          iconTheme: IconThemeData(color: AppColor.titleColor),
          titleTextStyle: AppFonts.primaryFont
              .copyWith(fontSize: 20, color: Colors.black)));
}
