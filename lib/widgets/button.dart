import 'package:flutter/material.dart';

class button extends StatelessWidget {
  final String title;
  final VoidCallback ontap;
  final Color containerColor;
  final double? width;
  final Color? textColor;
  final bool loading;

  const button(
      {super.key,
      required this.title,
      this.containerColor = const Color(0xFFBD1616),
      this.width,
      this.textColor,
      this.loading = false,
      required this.ontap});

  @override
  Widget build(BuildContext context) {
    Color defaultTextColor = textColor ?? Colors.white;
    return InkWell(
      onTap: ontap,
      child: Container(
        decoration: BoxDecoration(
            color: containerColor,
            border: Border.all(
              color: containerColor,
            ),
            borderRadius: BorderRadius.circular(5.0)),
        height: 40,
        width: width != null ? (width! > 300 ? 300 : width) : 300,
        child: Center(
          child: loading! ? const CircularProgressIndicator(strokeWidth: 3, color: Colors.white,)
            : Text(
            title,
            style: TextStyle(color: defaultTextColor),
          ),
        ),
      ),
    );
  }
}
