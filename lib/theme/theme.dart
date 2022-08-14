import 'package:flutter/material.dart';

final lightTheme = ThemeData.light().copyWith(
  backgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    color: Color(0xFFe3eeff),
    elevation: 0,
  ),
  textTheme: const TextTheme(
    headline2: TextStyle(
      fontSize: 40,
      color: Color(0xFF002359),
    ),
    headline4: TextStyle(
      fontSize: 20,
      color: Color(0xFF002359),
    ),
    headline5: TextStyle(
      fontSize: 16,
      color: Color(0xFF002359),
    ),
  ),
  buttonColor: Color(0xFF002359),
  highlightColor: Color.fromARGB(255, 255, 255, 255),
  hoverColor: Color(0xFF002359),
  cardColor: Color(0xFFe3eeff),
);

final darkTheme = ThemeData.dark().copyWith(
  scaffoldBackgroundColor: Color(0xFF002359),
  backgroundColor: Color(0xFF002359),
  appBarTheme: const AppBarTheme(
    color: Color(0xFF02327D),
    elevation: 0,
  ),
  textTheme: const TextTheme(
    headline2: TextStyle(
      fontSize: 40,
      color: Color(0xFFe3eeff),
    ),
    headline4: TextStyle(
      fontSize: 20,
      color: Color(0xFFe3eeff),
    ),
    headline5: TextStyle(
      fontSize: 16,
      color: Color(0xFFe3eeff),
    ),
  ),
  buttonColor: Color(0xFFe3eeff),
  highlightColor: Color(0xFF02327D),
  hoverColor: Color(0xFF02327D),
  cardColor: Color(0xFF02327D),
);
