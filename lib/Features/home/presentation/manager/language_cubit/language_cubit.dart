import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'language_state.dart';

class LanguageCubit extends Cubit<LanguageState> {
  LanguageCubit() : super(LanguageInitial());

  Locale mainLocale = const Locale('en');
  void changeLocaleToEng() {
    mainLocale = const Locale('en');
  }

  void changeLocaleToAr() {
    mainLocale = const Locale('ar');
  }
}
