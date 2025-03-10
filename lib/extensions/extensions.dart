import 'package:flutter/material.dart';

extension ThemeExt on BuildContext {
  ColorScheme get color => Theme.of(this).colorScheme;
}
