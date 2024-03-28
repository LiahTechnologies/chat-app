import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:njadia/src/utils/theme/theme_event.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeMode> {
  ThemeBloc() : super(ThemeMode.dark) {
    on<OnThemeChange>((event, emit) {
      emit(event.isDark
          ? ThemeMode.dark
          :ThemeMode.light);
    });
  }
}
