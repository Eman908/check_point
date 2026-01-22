import 'package:flutter/material.dart';

extension ContextExtension on BuildContext{
  double get height => MediaQuery.sizeOf(this).height;
  double get width => MediaQuery.sizeOf(this).width;
  TextTheme get textTheme => Theme.of(this).textTheme;
  ColorScheme get color => Theme.of(this).colorScheme;
}