import 'package:flutter/material.dart';

double anchoDiseno(BuildContext context) {
  return MediaQuery.sizeOf(context).width.clamp(0.0, 600.0).toDouble();
}
