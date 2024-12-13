import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:rokhshare/config/local_storage_service.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  final LocalStorageService _localStorageService;

  ThemeCubit({required LocalStorageService localStorageService})
      : _localStorageService = localStorageService,
        super(ThemeMode.system) {
    _init();
  }

  void _init() async {
    bool? isDark = await _localStorageService.isDark();
    if (isDark == true) {
      emit(ThemeMode.dark);
    } else if (isDark == false) {
      emit(ThemeMode.light);
    }
  }

  void changeTheme(ThemeMode mode) {
    if (mode == ThemeMode.dark) {
      _localStorageService.setThemeMode(true);
    } else {
      _localStorageService.setThemeMode(false);
    }
    emit(mode);
  }
}
