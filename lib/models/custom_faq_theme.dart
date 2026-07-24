import 'package:flutter/material.dart';

/// Color overrides passed down to a [CustomFaqStyle] view.
class CustomFaqTheme {
  const CustomFaqTheme({
    this.appBarColor,
    this.appBarTitleColor,
    this.backgroundColor,
    this.textColor,
  });

  final Color? appBarColor;
  final Color? appBarTitleColor;
  final Color? backgroundColor;
  final Color? textColor;
}
