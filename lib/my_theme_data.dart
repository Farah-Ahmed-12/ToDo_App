import 'package:flutter/material.dart';
import 'package:to_do_app/app_colors.dart';

class MyThemeData {
  static final ThemeData lightTheme = ThemeData(
    primaryColor: AppColors.primmarycolor,
    scaffoldBackgroundColor: AppColors.backgroundlightcolor,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.primmarycolor,
      elevation: 0,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: AppColors.primmarycolor,
      unselectedItemColor: AppColors.graycolor,
      showSelectedLabels: false,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.primmarycolor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(35),
        side: BorderSide(color: AppColors.whitcolor, width: 4),
      ),
    ),
  );
  List<Widget> tabs = [];
}
