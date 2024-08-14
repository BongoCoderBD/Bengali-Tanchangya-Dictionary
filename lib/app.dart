import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tanchangyadictionary/presentation/screens/home_screen.dart';
import 'package:tanchangyadictionary/presentation/utility/app_colors.dart';

import 'controller_binder/controller_binder.dart';

class TcgDictionaryApp extends StatelessWidget {
  const TcgDictionaryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: ControllerBinder(),
      theme: ThemeData(
        colorSchemeSeed: AppColors.primaryColor,
        inputDecorationTheme: _inputDecorationTheme(),
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.primaryColor,
          foregroundColor: Colors.white,
        ),
        progressIndicatorTheme: const ProgressIndicatorThemeData(
          color: AppColors.primaryColor,
        ),
      ),
      home: const HomePage(),
    );
  }

  InputDecorationTheme _inputDecorationTheme() => InputDecorationTheme(
    hintStyle: const TextStyle(
      color: Colors.grey,
      fontWeight: FontWeight.w400,
    ),
    border: _outlineInputBorder,
    enabledBorder: _outlineInputBorder,
    focusedBorder: _outlineInputBorder,
    errorBorder: _outlineInputBorder.copyWith(
      borderSide: const BorderSide(
        color: Colors.red,
      ),
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  );

  final OutlineInputBorder _outlineInputBorder = const OutlineInputBorder(
    borderSide: BorderSide(
      color: AppColors.primaryColor,
    ),
  );
}
