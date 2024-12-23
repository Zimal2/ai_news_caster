import 'package:ai_news_caster/provider/Methods.dart';
import 'package:ai_news_caster/ui/dashboard/appbarWidget.dart';
import 'package:ai_news_caster/ui/dashboard/tags.dart';
import 'package:ai_news_caster/ui/mediaScreens/new-Uploaded-News.dart';
import 'package:ai_news_caster/widgets/containers.dart';
import 'package:ai_news_caster/widgets/image_slider.dart';
import 'package:ai_news_caster/widgets/news_history_list_view.dart';
import 'package:ai_news_caster/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    final methodsProvider = Provider.of<Methods>(context, listen: false);

    methodsProvider
        .fetchUserProfileImage()
        .then((value) => methodsProvider.imageurl);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomContainer(
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppBarWidget(),
              const SizedBox(
                height: 10,
              ),
              //menu
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          child: sampleText(
                              text: 'ALL',
                              color: const Color(0xFFBD1616),
                              fontsize: 18),
                        ),
                      ),
                      const SizedBox(
                        width: 40,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    Tags(category: 'Technology'),
                              ));
                        },
                        child: Container(
                          child: sampleText(
                            text: 'TECHNOLOGY',
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 40,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Tags(category: 'Sports'),
                              ));
                        },
                        child: Container(
                          child: sampleText(
                            text: 'SPORTS',
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 40,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Tags(
                                  category: 'Entertainment',
                                ),
                              ));
                        },
                        child: Container(
                          child: sampleText(
                            text: 'ENTERTAINMENT',
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              //divider
              const Divider(
                height: 20,
                thickness: 2,
                color: Colors.grey,
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: CustomContainer(
                    width: double.infinity,
                    height: 100,
                    child: sampleText(
                        text: "What interests you today?",
                        color: Colors.black,
                        fontsize: 35)),
              ),
              //slider
              ImageSlider(),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5, left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    sampleText(
                        text: "News History",
                        color: const Color.fromARGB(255, 120, 28, 21),
                        fontsize: 20,
                        fontWeight: FontWeight.w700),
                    InkWell(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NewNews(),
                          )),
                      child: sampleText(
                          text: "Whats New?",
                          color: Colors.black,
                          fontsize: 17,
                          fontWeight: FontWeight.w700),
                    )
                  ],
                ),
              ),

              // Ensure the NewsHistoryListView is properly constrained
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.4,
                ),
                child: NewsHistoryListView(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
