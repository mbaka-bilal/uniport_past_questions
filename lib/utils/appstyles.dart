import 'package:flutter/material.dart';

class AppColors {
  static const purple = Color(0xFF9356F2);
  static const amber = Color(0xFFFFBF00);
  static const alabaster = Color(0xFFEDEADE);
}

class TextStyles {
  static const medium = fw500;
  static const semiBold = fw600;
  static const regular = fw400;

  static TextStyle fw400(double size, Color color) {
    return TextStyle(
      color: color,
      fontSize: size,
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle fw500(double size, Color color) {
    return TextStyle(color: color, fontSize: size, fontWeight: FontWeight.w500);
  }

  static TextStyle fw600(double size, Color color) {
    return TextStyle(color: color, fontSize: size, fontWeight: FontWeight.w600);
  }
}
