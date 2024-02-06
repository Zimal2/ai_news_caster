import 'package:ai_news_caster/widgets/containers.dart';
import 'package:ai_news_caster/widgets/text.dart';
import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final String title;
  final Color color;
  final double? fontsize;

  const CustomListTile({
    super.key,
    required this.title,
    required this.color,
    this.fontsize,
  });

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
        width: 120,
        height: 50,
        child: ListTile(
          title: sampleText(text: title, color: color, fontsize: fontsize),
        ));
  }
}
