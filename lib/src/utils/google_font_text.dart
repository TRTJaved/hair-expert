import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GoogleFontsText extends StatelessWidget {
  final String text;
  final String fontFamily;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;

  GoogleFontsText({
    required this.text,
    this.fontFamily = 'Montserrat',
    this.color,
    this.fontSize,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.getFont(
        fontFamily,
        textStyle: TextStyle(
          color: color ?? Colors.black,
          fontSize: fontSize ?? 16,
          fontWeight: fontWeight ?? FontWeight.normal,
        ),
      ),
      textAlign: TextAlign.center,
    );
  }
}
