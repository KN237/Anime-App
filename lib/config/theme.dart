import 'package:anime_app/config/constant.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final darkTheme = ThemeData.dark().copyWith(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: CustomColor.background,
  textTheme: GoogleFonts.interTextTheme().copyWith(
    titleLarge: const TextStyle(
        fontSize: 32, color: CustomColor.white, fontWeight: FontWeight.bold),
    bodyLarge: const TextStyle(
        fontSize: 18, color: CustomColor.white, fontWeight: FontWeight.normal),
    bodyMedium: const TextStyle(
        fontSize: 16, color: CustomColor.white, fontWeight: FontWeight.normal),
    bodySmall: const TextStyle(
        fontSize: 14, color: CustomColor.white, fontWeight: FontWeight.normal),
    labelSmall: const TextStyle(
        fontSize: 12, color: CustomColor.white, fontWeight: FontWeight.normal),
  ),
);
