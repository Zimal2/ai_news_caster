import 'package:flutter/material.dart';

sampleText({
  String? text,
  FontWeight? fontWeight,
  double? fontsize,
  Color? color,
  TextAlign? textAlign,
  TextDecoration? decoration,
}) {
  return Text(
    text!,
    textAlign: textAlign,
    style: TextStyle(
      fontSize: fontsize,
      fontWeight: fontWeight,
      color: color,
      decoration: decoration,
    ),
  );
}
