import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  AppTheme._();

  static const primary = Color(0xFFB8A6F5);
  static const secondary = Color(0xFFA0E7D8);
  static const accent = Color(0xFFFFC7C7);
  static const background = Color(0xFFFDF9F6);
  static const onGradientText = Color(0xFF4A3F7A);

  static ThemeData get light {
    final base = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: primary),
    );

    return base.copyWith(
      textTheme: GoogleFonts.notoSansKrTextTheme(base.textTheme),
      scaffoldBackgroundColor: background,
    );
  }
}
