import 'package:flutter/material.dart';
import 'package:monarch_annotations/monarch_annotations.dart';

@MonarchTheme('My Dark Theme')
final myDarkTheme = ThemeData(
  brightness: Brightness.dark,
  applyElevationOverlayColor: true,
  scaffoldBackgroundColor: const Color(0xFF121212),
  colorScheme: const ColorScheme.dark(),
  cardColor: const Color(0xFF121212),
);
