import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final kLightModeColor = ColorScheme.fromSeed(seedColor: Colors.green.shade700);

final kDarkModeColor = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: Colors.green.shade800,
);

// L I G H T  T H E M E
ThemeData lightTheme = ThemeData(
  colorScheme: kLightModeColor,

  //APP  BAR
  appBarTheme: AppBarTheme().copyWith(
    backgroundColor: kLightModeColor.primaryContainer,
    foregroundColor: kLightModeColor.onPrimaryContainer,
    elevation: 1,
    titleSpacing: 1,
  ),
  textTheme: GoogleFonts.notoSerifBengaliTextTheme(),
);

ThemeData darkTheme = ThemeData(
  colorScheme: kDarkModeColor,

  // APP BAR
  appBarTheme: AppBarTheme().copyWith(
    backgroundColor: kDarkModeColor.primaryContainer,
    foregroundColor: kDarkModeColor.onPrimaryContainer,
    elevation: 1,
    titleSpacing: 1,
  ),

  textTheme: GoogleFonts.notoSerifBengaliTextTheme(),
);
