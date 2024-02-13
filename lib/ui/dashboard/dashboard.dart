import 'package:ai_news_caster/modals/news_modals.dart';

import 'package:ai_news_caster/ui/profile.dart';
import 'package:ai_news_caster/ui/sign_in_screens/sign_in.dart';
import 'package:ai_news_caster/widgets/containers.dart';
import 'package:ai_news_caster/widgets/image_slider.dart';
import 'package:ai_news_caster/widgets/news_history_list_view.dart';
import 'package:ai_news_caster/widgets/text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<NewsModals> postList = [];
  Future<List<NewsModals>> getPostAPI() async {
    final response = await http.get(Uri.parse(
        'https://api.nytimes.com/svc/search/v2/articlesearch.json?q=election&api-key=erPsHTGZ5ziQGFFbV73mvdviZpdsTqb7'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      postList.clear();
      for (Map i in data) {
        // postList.add(NewsModals.fromJson(i as Map<String, dynamic>));
      }
      return postList;
    } else {
      return postList;
    }
  }

  List<NewsItem> newsHistory = [
    const NewsItem(
      imagePath: 'lib/assests/images/slider1.png',
      description: 'News of didgital market regarding the ups and down',
      watermark: 'Digital Market',
      trailingIcon: Icons.favorite,
      trailingText: '2.1 k',
    ),
    const NewsItem(
      imagePath: 'lib/assests/images/slider2.png',
      description: 'News of didgital market regarding the ups and down',
      watermark: 'Media',
      trailingIcon: Icons.favorite,
      trailingText: '2.1 k',
    ),
    const NewsItem(
      imagePath: 'lib/assests/images/slider3.png',
      description: 'News of didgital market regarding the ups and down',
      watermark: 'Cyber Crime',
      trailingIcon: Icons.favorite,
      trailingText: '2.1 k',
    ),
    const NewsItem(
      imagePath: 'lib/assests/images/slider1.png',
      description: 'News of didgital market regarding the ups and down',
      watermark: 'Digital Market',
      trailingIcon: Icons.favorite,
      trailingText: '2.1 k',
    ),
    const NewsItem(
      imagePath: 'lib/assests/images/slider4.png',
      description: 'News of didgital market regarding the ups and down',
      watermark: 'Nature',
      trailingIcon: Icons.favorite,
      trailingText: '2.1 k',
    ),
    const NewsItem(
      imagePath: 'lib/assests/images/slider5.png',
      description: 'News of didgital market regarding the ups and down',
      watermark: 'Fashion',
      trailingIcon: Icons.favorite,
      trailingText: '2.1 k',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomContainer(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomContainer(
              width: double.infinity,
              height: 100,
              child: Row(
                children: [
                  CustomContainer(
                      width: 50, height: 50, child: const Icon(Icons.menu)),
                  const SizedBox(
                    width: 35,
                  ),
                  CustomContainer(
                    width: 200,
                    height: 130,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        CustomContainer(
                            width: 150,
                            height: 30,
                            child: sampleText(
                                text: 'ANCHOR AI',
                                color: const Color(0xFFBD1616),
                                textAlign: TextAlign.center,
                                fontsize: 20)),
                        CustomContainer(
                            width: 200,
                            height: 30,
                            child: sampleText(
                                text: 'Smart News Broadcasting Platform',
                                color: Colors.black,
                                textAlign: TextAlign.center,
                                fontsize: 11)),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 18,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              Profile(), // Replace ProfilePage() with your profile page widget
                        ),
                      );
                    },
                    child: CustomContainer(
                      onTap: () async {
                        await GoogleSignIn().signOut();
                        FirebaseAuth.instance.signOut();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SigninScreen()));
                      },
                      width: 50,
                      height: 50,
                      child: Icon(Icons.power_settings_new_outlined),
                    ),
                  )

                  // CustomContainer(
                  //     width: 50,
                  //     height: 50,
                  //     child: Image.asset("lib/assests/images/notif.png")),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: CustomContainer(
                width: double.infinity,
                height: 25,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Container(
                      child: sampleText(
                          text: 'ALL', color: Color(0xFFBD1616), fontsize: 18),
                    ),
                    SizedBox(
                      width: 40,
                    ),
                    Container(
                      child: sampleText(
                        text: 'PROGRAMMING',
                      ),
                    ),
                    SizedBox(
                      width: 40,
                    ),
                    Container(
                      child: sampleText(
                        text: 'SPORTS',
                      ),
                    ),
                    SizedBox(
                      width: 40,
                    ),
                    Container(
                      child: sampleText(
                        text: 'MEDIA',
                      ),
                    )
                    // CustomListTile(
                    //   title: 'ALL',
                    //   color: Color(0xFFBD1616),
                    //   fontsize: 15,
                    // ),
                    // CustomListTile(
                    //   title: 'SPORTS',
                    //   color: Colors.black,
                    //   fontsize: 15,
                    // ),
                    // CustomListTile(
                    //   title: 'PROGRAMMING',
                    //   color: Colors.black,
                    //   fontsize: 15,
                    // ),
                    // CustomListTile(
                    //   title: 'MEDIA',
                    //   color: Colors.black,
                    //   fontsize: 15,
                    // ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            CustomContainer(
              width: double.infinity,
              height: 10,
              child: Image.asset('lib/assests/images/line1.png',
                  fit: BoxFit.cover),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: CustomContainer(
                  width: double.infinity,
                  height: 100,
                  child: sampleText(
                      text: "What interests you today?",
                      color: Colors.black,
                      fontsize: 35)),
            ),
            const ImageSlider(),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5, left: 10),
              child: sampleText(
                  text: "News History", color: Colors.black, fontsize: 20),
            ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 8),
            //   child: CustomContainer(
            //     width: double.infinity,
            //   //  height: 50,
            //     child: sampleText(
            //         text: "News History", color: Colors.black, fontsize: 20),
            //   ),
            // ),
            Expanded(
              child: NewsHistoryListView(newsItems: newsHistory),
            )
            // CustomContainer(
            //   width: double.infinity,
            //   height: 270,
            //   child: NewsHistoryListView(newsItems: newsHistory),
            // ),
          ],
        ),
      ),
    );
  }
}
