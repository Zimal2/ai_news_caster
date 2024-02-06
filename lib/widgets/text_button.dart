import 'package:flutter/material.dart';

class Textbutton extends StatelessWidget {
  final String title;
  final VoidCallback ontap;
  final Color color;

  const Textbutton(
      {super.key,
      required this.title,
      required this.color,
      required this.ontap});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: ontap, 
      child: Text(
        title,
        style: TextStyle(
          color: color
        ),
      ),
      );
    // return InkWell(
    //   onTap: ontap,
    //   child: Container(
    //     decoration: BoxDecoration(
    //         color: color,
    //         border: Border.all(
    //           color: containerColor,
    //         ),
    //         borderRadius: BorderRadius.circular(5.0)),
    //     height: 40,
    //     width: 300,
    //     child: Center(
    //       child: Text(title,
    //       style: TextStyle(color: Colors.white),
    //       ),
    //     ),
    //   ),
    // );
  }
}