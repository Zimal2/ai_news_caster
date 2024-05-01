import 'package:ai_news_caster/ui/dashboard/dashboard.dart';
import 'package:ai_news_caster/widgets/button.dart';
import 'package:ai_news_caster/widgets/text.dart';
import 'package:flutter/material.dart';

class PhoneNumberConfirmed extends StatefulWidget {
  const PhoneNumberConfirmed({super.key});

  @override
  State<PhoneNumberConfirmed> createState() => _PhoneNumberConfirmedState();
}

class _PhoneNumberConfirmedState extends State<PhoneNumberConfirmed> {
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
            SizedBox(
              height: 40,
            ),
            sampleText(
                text: "Yeah! Your PhoneNumber has been confirmed!",
                fontWeight: FontWeight.bold,
                fontsize: 25,
                textAlign: TextAlign.center),
            Spacer(),
            button(
                title: "Next",
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
