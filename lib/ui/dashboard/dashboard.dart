import 'package:ai_news_caster/ui/dashboard/appbarWidget.dart';
import 'package:ai_news_caster/widgets/containers.dart';
import 'package:ai_news_caster/widgets/image_slider.dart';
import 'package:ai_news_caster/widgets/news_history_list_view.dart';
import 'package:ai_news_caster/widgets/text.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
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
            AppBarWidget(),
            const SizedBox(
              height: 10,
            ),
            //menu
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: CustomContainer(
                width: double.infinity,
                height: 25,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Container(
                      child: sampleText(
                          text: 'ALL',
                          color: const Color(0xFFBD1616),
                          fontsize: 18),
                    ),
                    const SizedBox(
                      width: 40,
                    ),
                    Container(
                      child: sampleText(
                        text: 'PROGRAMMING',
                      ),
                    ),
                    const SizedBox(
                      width: 40,
                    ),
                    Container(
                      child: sampleText(
                        text: 'SPORTS',
                      ),
                    ),
                    const SizedBox(
                      width: 40,
                    ),
                    Container(
                      child: sampleText(
                        text: 'MEDIA',
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
              padding: const EdgeInsets.only(top: 5, left: 10),
              child: sampleText(
                  text: "News History",
                  color: const Color.fromARGB(255, 120, 28, 21),
                  fontsize: 20,
                  fontWeight: FontWeight.w700),
            ),

            Expanded(
              child: NewsHistoryListView(),
            )
          ],
        ),
      ),
    );
  }
}
