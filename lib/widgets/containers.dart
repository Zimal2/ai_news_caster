import 'package:flutter/material.dart';

CustomContainer(
    {double? width,
    double? height,
    Color? color,
    BorderRadiusGeometry? radius,
    Border? border,
    Widget? child,
    Alignment? alignment,
    Function()? onTap}) {
  final BorderRadiusGeometry defaultRadius =
      radius ?? BorderRadius.all(Radius.circular(20.0));
  final Border defaultbordercolor =
      border ?? Border.all(color: Colors.transparent);
  final Color defaultcolor = color ?? Colors.transparent;
//  final Alignment defaultAlignment = alignment ?? Alignment.centerRight;
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: defaultRadius,
        color: defaultcolor,
        border: defaultbordercolor,
      ),
      alignment: alignment,
      child: child,
    ),
  );
}
