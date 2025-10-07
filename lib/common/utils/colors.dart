import 'package:flutter/material.dart';

Color deserializeColor(String hexColor) {
  return Color(int.parse(hexColor, radix: 16));
}

String serializeColor(Color color) {
  return color.toARGB32().toRadixString(16).padLeft(8, '0');
}
