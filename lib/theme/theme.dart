import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final lightTheme = ThemeData.light().copyWith(
  backgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    color: Color(0xFFe3eeff),
    elevation: 0,
  ),
  textTheme: TextTheme(
    headline2: GoogleFonts.montserrat(
      fontSize: 40,
      color: const Color(0xFF002359),
    ),
    headline4: GoogleFonts.montserrat(
      fontSize: 20,
      color: const Color(0xFF002359),
    ),
    headline5: GoogleFonts.montserrat(
      fontSize: 16,
      color: const Color(0xFF002359),
    ),
    headline6: GoogleFonts.montserrat(
      fontSize: 16,
      color: const Color(0xFF002359),
    ),
  ),
  buttonColor: const Color(0xFF002359),
  highlightColor: const Color.fromARGB(255, 255, 255, 255),
  hoverColor: const Color(0xFF002359),
  cardColor: const Color(0xFFe3eeff),
);

final darkTheme = ThemeData.dark().copyWith(
  scaffoldBackgroundColor: const Color(0xFF002359),
  backgroundColor: const Color(0xFF002359),
  appBarTheme: const AppBarTheme(
    color: Color(0xFF02327D),
    elevation: 0,
  ),
  textTheme: TextTheme(
    headline2: GoogleFonts.montserrat(
      fontSize: 40,
      color: const Color(0xFFe3eeff),
    ),
    headline4: GoogleFonts.montserrat(
      fontSize: 20,
      color: const Color(0xFFe3eeff),
    ),
    headline5: GoogleFonts.montserrat(
      fontSize: 16,
      color: const Color(0xFFe3eeff),
    ),
    headline6: GoogleFonts.montserrat(
      fontSize: 16,
      color: const Color(0xFF002359),
    ),
  ),
  buttonColor: const Color(0xFFe3eeff),
  highlightColor: const Color(0xFF02327D),
  hoverColor: const Color(0xFF02327D),
  cardColor: const Color(0xFF02327D),
);
