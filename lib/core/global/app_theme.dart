import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData appTheme() => ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(ThemeData.light().textTheme),
      );
}
