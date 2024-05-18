import 'package:flutter/material.dart';

class ThemeNotifier extends InheritedWidget {
  final ValueNotifier<ThemeMode> themeModeNotifier;

  ThemeNotifier({
    required this.themeModeNotifier,
    required Widget child,
  }) : super(child: child);

  static ThemeNotifier? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ThemeNotifier>();
  }

  @override
  bool updateShouldNotify(covariant ThemeNotifier oldWidget) {
    return oldWidget.themeModeNotifier != themeModeNotifier;
  }
}
