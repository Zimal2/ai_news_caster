import 'package:ai_news_caster/ui/sign_in_screens/sign_in-administrator.dart';
import 'package:ai_news_caster/ui/sign_in_screens/sign_in.dart';
import 'package:ai_news_caster/ui/uploadnews.dart';
import 'package:ai_news_caster/widgets/button.dart';
import 'package:ai_news_caster/widgets/text.dart';
import 'package:flutter/material.dart';

class NewsUploaded extends StatefulWidget {
  const NewsUploaded({super.key});

  @override
  State<NewsUploaded> createState() => _NewsUploadedState();
}

class _NewsUploadedState extends State<NewsUploaded> {
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
              child: Image.asset('lib/assests/images/uploadDone.png'),
            ),
            sampleText(
                text: "News has been uploaded",
                fontWeight: FontWeight.bold,
                fontsize: 30,
                textAlign: TextAlign.center),
            sampleText(
                text: "Check your dashboard for your news",
                textAlign: TextAlign.center),
            Spacer(),
            button(
                title: "Upload another news",
                ontap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UploadNews(),
                      ));
                }),
            SizedBox(
              height: 5,
            ),
            InkWell(
                child: sampleText(
                  text: "Want to switch to user account?",
                  color: Color(0xFFBD1616),
                  fontsize: 12,
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SigninScreen(),
                      ));
                })
          ],
        ),
      ),
    );
  }
}
