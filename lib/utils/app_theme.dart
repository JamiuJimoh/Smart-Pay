import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'color_scheme.dart';

class AppTheme {
  static final TextTheme lightTextTheme = TextTheme(
    bodyText1: GoogleFonts.roboto(
      color: kOnPrimaryColor,
      fontWeight: FontWeight.w600,
      fontSize: 16.0,
      letterSpacing: 0.3,
    ),
    bodyText2: GoogleFonts.roboto(
      color: kSecondaryColor,
      fontWeight: FontWeight.w400,
      fontSize: 16.0,
      letterSpacing: 0.3,
    ),
    subtitle1: GoogleFonts.roboto(
      color: kSecondaryColor,
      fontWeight: FontWeight.w400,
      fontSize: 16.0,
      letterSpacing: 0.3,
    ),
    subtitle2: GoogleFonts.roboto(
      color: kSecondaryColor,
      fontWeight: FontWeight.w400,
      fontSize: 14.0,
      letterSpacing: 0.3,
    ),
    headline1: GoogleFonts.roboto(
      color: kOnPrimaryColor,
      fontWeight: FontWeight.w700,
      fontSize: 24.0,
      letterSpacing: -0.2,
    ),
    headline5: GoogleFonts.roboto(
      color: kAccentColor2,
      fontWeight: FontWeight.w700,
      fontSize: 16.0,
      letterSpacing: 0.3,
    ),
    headline6: GoogleFonts.roboto(
      color: kAccentColor,
      fontWeight: FontWeight.w700,
      fontSize: 16.0,
      letterSpacing: 0.3,
    ),
  );

  static light() {
    return ThemeData(
      scaffoldBackgroundColor: kScaffoldBackgroundColor,
      textTheme: lightTextTheme,
      appBarTheme: const AppBarTheme().copyWith(
        elevation: 0.0,
        color: kScaffoldBackgroundColor,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: kScaffoldBackgroundColor,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
        // titleTextStyle: GoogleFonts.lato(
        //   color: AppColor.kOnPrimaryTextColor,
        //   fontWeight: FontWeight.w600,
        //   fontSize: 12.0,
        // ),
      ),
    );
  }
}
