import 'package:ai_news_caster/ui/sign_in_screens/sign_in.dart';
import 'package:ai_news_caster/widgets/button.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 35,
          vertical: 70,
        ),
        child: Column(
          children: [
            Container(
              width: 250,
              height: 250,
              child: Image.asset('lib/assests/images/news caster logo.jpeg'),
            ),
            Spacer(),
            button(
              title: "Get Started",
              ontap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SigninScreen(),
                    ));
              },
            )
          ],
        ),
      ),
    );
  }
}
