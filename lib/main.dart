import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:world_time/countries/time_countries_view.dart';
import 'package:world_time/theme/cubit/app_theme_cubit.dart';
import 'package:world_time/theme/theme.dart';

void main() {
  runApp(MultiBlocProvider(providers: [
    BlocProvider(
      create: (context) => ThemeCubit(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeCubit theme = BlocProvider.of<ThemeCubit>(context, listen: true);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: theme.isDark ? Colors.white : Colors.black,
      statusBarBrightness: theme.isDark ? Brightness.dark : Brightness.light,
    ));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'World Time',
      themeMode: ThemeMode.system,
      theme: theme.isDark ? darkTheme : lightTheme,
      darkTheme: theme.isDark ? lightTheme : darkTheme,
      home: CountriesView(),
    );
  }
}
