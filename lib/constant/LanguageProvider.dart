import 'package:flutter/material.dart';

class LanguageProvider extends ChangeNotifier {
  String _selectedLanguage = 'fr';

  String get selectedLanguage => _selectedLanguage;

  void setLanguage(String language) {
    _selectedLanguage = language;
    notifyListeners();
  }
}
