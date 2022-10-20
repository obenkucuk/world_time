import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'app_theme_state.dart';

class ThemeCubit extends Cubit<AppThemeState> {
  ThemeCubit() : super(AppThemeInitial());

  bool _isDark = false;
  bool get isDark => _isDark;

  void changeTheme() {
    _isDark = !_isDark;

    // Emit will change the state of our theme (Must use)
    emit(AppThemeChanged());
  }
}
