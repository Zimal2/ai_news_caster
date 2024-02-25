import 'package:flutter/material.dart';

sampleText({
  String? text,
  FontWeight? fontWeight,
  double? fontsize,
  Color? color,
  TextAlign? textAlign,
  TextDecoration? decoration,
  TextOverflow? overflow,
}) {
  return Text(
    text!,
    textAlign: textAlign,
    style: TextStyle(
      overflow: overflow,
      fontSize: fontsize,
      fontWeight: fontWeight,
      color: color,
      decoration: decoration,
    ),
  );
}
