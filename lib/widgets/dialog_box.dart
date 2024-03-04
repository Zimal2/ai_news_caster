import 'package:ai_news_caster/widgets/text_button.dart';
import 'package:flutter/material.dart';

class DialogBox {
  static Future<void> showLogoutDialog({
    required BuildContext context,
    String? heading,
    String? text,
    Color color = Colors.white,
    String? button1text,
    String? button2text,
    Color? button1color,
    Color? button2color,
    VoidCallback? button1onTap,
    VoidCallback? button2onTap,
  }) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(heading ?? '',),
          content: Text(text ?? ''),
          actions: [
            Textbutton(
              title: button1text!, 
              color: button1color!, 
              ontap: button1onTap!
              ),
            Textbutton(
              title: button2text!, 
              color: button2color!, 
              ontap: button2onTap!
              ),
          ],
        );
      },
    );
  }
}
