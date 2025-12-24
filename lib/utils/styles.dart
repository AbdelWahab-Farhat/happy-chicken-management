import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:happy_chicken_restaurant/utils/exstation.dart';

abstract class Styles {
  static String mainFont = GoogleFonts.cairo().fontFamily!;
  static TextStyle styles24 (BuildContext context) {
    return  TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        fontFamily: mainFont,
        color: context.colorScheme.onSurface
    );
  }

  static TextStyle styles20 (BuildContext context) {
    return  TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      fontFamily: mainFont,
      color: context.colorScheme.onSurface
    );
  }
  static TextStyle styles16 (BuildContext context) {
    return  TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        fontFamily: mainFont,
        color: context.colorScheme.onSurface
    );
  }
}