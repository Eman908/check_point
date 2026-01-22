import 'package:flutter/material.dart';

extension PaddingExtension on Widget {
  Widget horizontalPadding(double padding) {
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: padding),
      child: this,
    );
  }

  Widget verticalPadding(double padding) {
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(vertical: padding),
      child: this,
    );
  }

  Widget allPadding(double padding) {
    return Padding(padding: EdgeInsetsGeometry.all(padding), child: this);
  }
}
