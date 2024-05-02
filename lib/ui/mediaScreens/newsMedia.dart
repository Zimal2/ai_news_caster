import 'package:ai_news_caster/ui/dashboard/dashboard.dart';
import 'package:ai_news_caster/widgets/button.dart';
import 'package:ai_news_caster/widgets/containers.dart';
import 'package:ai_news_caster/widgets/text.dart';
import 'package:flutter/material.dart';

class NewsMedia extends StatefulWidget {
  const NewsMedia({super.key});

  @override
  State<NewsMedia> createState() => _NewsMediaState();
}

class _NewsMediaState extends State<NewsMedia> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 104, 103, 103),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Column(
              children: [
                ListTile(
                  leading: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Icon(Icons.arrow_back_ios_new, color: Colors.white),
                  ),
                  title: sampleText(
                      text: "Media", fontsize: 20, color: Colors.white),
                ),
                Image.asset(
                  'lib/assests/images/line.png',
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CustomContainer(
                          height: 165,
                          width: 162,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              'lib/assests/images/slider3.png',
                              fit: BoxFit
                                  .cover, // Use BoxFit.cover or the appropriate fit
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        CustomContainer(
                          height: 165,
                          width: 162,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              'lib/assests/images/slider1.png',
                              fit: BoxFit
                                  .cover, // Use BoxFit.cover or the appropriate fit
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    CustomContainer(
                      height: 200,
                      width: double.infinity,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          'lib/assests/images/slider2.png',
                          fit: BoxFit
                              .cover, // Use BoxFit.cover or the appropriate fit
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CustomContainer(
                          height: 165,
                          width: 162,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              'lib/assests/images/slider2.png',
                              fit: BoxFit
                                  .cover, // Use BoxFit.cover or the appropriate fit
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        CustomContainer(
                          height: 165,
                          width: 162,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              'lib/assests/images/slider3.png',
                              fit: BoxFit
                                  .cover, // Use BoxFit.cover or the appropriate fit
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 70,
                ),
                button(
                  title: "Go to dashboard",
                  //ontap: () => EmailConfirmation(),
                  ontap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DashboardScreen(),
                        ));
                    // EmailConfirmation(); // Call the function EmailConfirmation() here
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
