import 'dart:async';

import 'package:ai_news_caster/modals/news_modals.dart';
import 'package:ai_news_caster/provider/Methods.dart';
import 'package:ai_news_caster/ui/dashboard/dashboard.dart';
import 'package:ai_news_caster/ui/mediaScreens/lip-sync/lipsyncWidget.dart';
import 'package:ai_news_caster/ui/mediaScreens/newsMedia.dart';
import 'package:ai_news_caster/ui/mediaScreens/readMore.dart';
import 'package:ai_news_caster/widgets/button.dart';
import 'package:ai_news_caster/widgets/text.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class NewsScreen extends StatefulWidget {
  final Articles? article;
  const NewsScreen({Key? key, this.article}) : super(key: key);

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> with TickerProviderStateMixin {
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;
  // late final AnimationController _controller =
  //     AnimationController(vsync: this, duration: Duration(seconds: 4))
  //       ..repeat();
  void dispose() {
    //  _controller.dispose();

    _videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    final methodsProvider = Provider.of<Methods>(context, listen: false);
    final description = widget.article?.description;
    final speakingTime = methodsProvider
        .calculateSpeakingTime(description ?? "no news to deliver");

    print("speach time:$speakingTime");
    _videoPlayerController =
        VideoPlayerController.asset('lib/assests/videos/avatar1.mp4');
    _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController,
        autoPlay: false,
        looping: false,
        allowFullScreen: false,
        showControls: true,
        allowMuting: true,
        allowedScreenSleep: false,
        autoInitialize: false,
        aspectRatio: 800 / 800,
        progressIndicatorDelay: Duration(microseconds: 5),
        fullScreenByDefault: false);
    _videoPlayerController.addListener(() {
      if (_videoPlayerController.value.position >=
          Duration(seconds: speakingTime.toInt())) {
        _videoPlayerController.pause();
        showReplayDialog();
      }
    });

    Timer(Duration(seconds: speakingTime.toInt()), () {
      if (_videoPlayerController.value.isPlaying) {
        _videoPlayerController.pause();
        showReplayDialog();
      }
    });

    // Timer(Duration(seconds: speakingTime.toInt()), () {
    //   print("speach time:2:${speakingTime.toInt()}");
    //   _videoPlayerController.pause();

    // });

    super.initState();
  }

  void showReplayDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Video Finished"),
          content: Text(
              "Would you like to watch the video again or proceed to the next screen?"),
          actions: <Widget>[
            TextButton(
              child: Text("Watch Again"),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                _videoPlayerController.seekTo(Duration.zero);
                _videoPlayerController.play();
              },
            ),
            TextButton(
              child: Text("Next"),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NewsMedia()),
                );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final methodsProvider = Provider.of<Methods>(context);
    final article = widget.article;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 104, 103, 103),
      body: SafeArea(
        child: SingleChildScrollView(
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
                  text: article?.title ?? "International News",
                  fontsize: 20,
                  color: Colors.white,
                ),
              ),
              Image.asset('lib/assests/images/line.png'),
              Row(
                children: [
                  SizedBox(width: 20),
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: AssetImage("lib/assests/images/women.jpg"),
                  ),
                  SizedBox(width: 10),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      sampleText(
                        text: article?.author,
                        color: Colors.white,
                        fontsize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                      sampleText(
                        text: article?.publishedAt,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  methodsProvider
                      .speak(methodsProvider.decriptionController.text);
                },
                child: Container(
                  color: Colors.black,
                  height: 250,
                  width: double.infinity,
                  child: InkWell(
                    onTap: () {
                      methodsProvider
                          .speak(methodsProvider.decriptionController.text);
                    },
                    child: Chewie(
                      controller: _chewieController,
                    ),
                  ),
                  // LipSyncWidget(text: "Added here")
                  // Center(
                  //   child: Image.asset(
                  //     'lib/assests/images/avatar.png',
                  //     fit: BoxFit.contain,
                  //   ),
                  // ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset('lib/assests/images/line.png'),
                    sampleText(
                      fontsize: 20,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                      text: article?.title ?? "No Title",
                    ),
                    Image.asset('lib/assests/images/line.png'),
                    sampleText(
                      textAlign: TextAlign.start,
                      fontsize: 20,
                      fontWeight: FontWeight.w400,
                      text: "Description:",
                      color: Colors.white,
                    ),
                    sampleText(
                      color: Colors.white,
                      text: article?.description ?? "No Description",
                    ),
                    InkWell(
                      child: sampleText(
                        text: "Read More",
                        decoration: TextDecoration.underline,
                        color: Colors.blue,
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ReadMore(
                                article: article,
                              ),
                            ));
                      },
                    ),
                    Row(
                      children: [
                        SizedBox(width: 10),
                        button(
                          width: 120,
                          title: "Go Back",
                          ontap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DashboardScreen(),
                              ),
                            );
                          },
                        ),
                        SizedBox(width: 10),
                        button(
                          containerColor: Colors.white,
                          width: 180,
                          title: "Check for Media",
                          textColor: Colors.black,
                          ontap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => NewsMedia(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
