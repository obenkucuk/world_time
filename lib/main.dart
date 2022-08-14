import 'package:flutter/material.dart';
import 'package:world_time/countries/time_countries_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'World Time',
      theme: ThemeData.light().copyWith(
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
      ),
      home: CountriesView(),
    );
  }
}
