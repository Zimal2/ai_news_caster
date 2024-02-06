import 'package:ai_news_caster/ui/dashboard/dashboard.dart';
import 'package:ai_news_caster/ui/uploadnews.dart';
import 'package:ai_news_caster/widgets/button.dart';
import 'package:ai_news_caster/widgets/text.dart';
import 'package:flutter/material.dart';

class EmailConfirmation extends StatefulWidget {
  const EmailConfirmation({super.key});

  @override
  State<EmailConfirmation> createState() => _EmailConfirmationState();
}

class _EmailConfirmationState extends State<EmailConfirmation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 100),
        child: Column(
          children: [
            Container(
              width: 200,
              height: 200,
              child: Image.asset('lib/assests/images/mail icon.png'),
            ),
            sampleText(
                text: "Yeah! Confirm your email!",
                fontWeight: FontWeight.bold,
                fontsize: 30,
                textAlign: TextAlign.center),
            sampleText(
                text:
                    "Please check your email for confirmation of phone number.Click link in mail to verify your account",
                textAlign: TextAlign.center),
            Spacer(),
            button(
                title: "Resend Email?",
                ontap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DashboardScreen(),
                      ));
                })
          ],
        ),
      ),
    );
  }
}
