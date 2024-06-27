import 'package:ai_news_caster/modals/news_modals.dart';
import 'package:ai_news_caster/ui/dashboard/dashboard.dart';
import 'package:ai_news_caster/ui/mediaScreens/newsMedia.dart';
import 'package:ai_news_caster/widgets/button.dart';
import 'package:ai_news_caster/widgets/text.dart';
import 'package:flutter/material.dart';

class ReadMore extends StatefulWidget {
  final Articles? article;
  const ReadMore({super.key, this.article});

  @override
  State<ReadMore> createState() => _ReadMoreState();
}

class _ReadMoreState extends State<ReadMore> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 104, 103, 103),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Icon(Icons.arrow_back_ios_new, color: Colors.white),
                ),
                title: sampleText(
                    text: "Read More", fontsize: 20, color: Colors.white),
              ),
              Image.asset(
                'lib/assests/images/line.png',
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Column(
                  children: [
                    Container(
                      height: 590,
                      width: double.infinity,
                      child: SingleChildScrollView(
                        child: sampleText(
                            color: Colors.white,
                            text: widget.article?.description == "[Removed]"
                                ? "Pakistan is currently navigating a period of significant challenges, both economically and in terms of security, as the country prepares for the upcoming 2024 general elections. The political landscape is fraught with instability, exacerbating the nation's existing problems."
                                : widget.article?.description
                           
                            ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        button(
                          width: 120,
                          title: "Go Back",
                          ontap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DashboardScreen(),
                                ));
                            // EmailConfirmation(); // Call the function EmailConfirmation() here
                          },
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        button(
                          containerColor: Colors.white,
                          width: 180,
                          title: "Check for Media",
                          textColor: Colors.black,
                          ontap: () {
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //       builder: (context) => NewsMedia(),
                            //     ));
                          },
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
