import 'dart:async';
import 'package:ai_news_caster/modals/news_modals.dart';
import 'package:ai_news_caster/provider/Methods.dart';
import 'package:ai_news_caster/ui/dashboard/dashboard.dart';
import 'package:ai_news_caster/ui/mediaScreens/newsMedia.dart';
import 'package:ai_news_caster/ui/mediaScreens/readMore.dart';
import 'package:ai_news_caster/widgets/button.dart';
import 'package:ai_news_caster/widgets/text.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class NewsScreen extends StatefulWidget {
  final Articles? article;
  final List? imagesList;
  NewsScreen({Key? key, this.article, this.imagesList}) : super(key: key);

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> with TickerProviderStateMixin {
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;
  late FlutterTts flutterTts;
  late Methods methodsProvider;
  String? description;
  double speakingTime = 0.0;
  bool isTtsPlaying = false;
  bool isExpandedDescription = false;
  bool isExpandedTitle = false;

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController.dispose();
    flutterTts.stop();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    methodsProvider = Provider.of<Methods>(context, listen: false);
    description = widget.article?.description;
    speakingTime = methodsProvider
        .calculateSpeakingTime(description ?? "no news to deliver");

    flutterTts = FlutterTts();

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
      fullScreenByDefault: false,
    );

    _videoPlayerController.addListener(() {
      final bool isPlaying = _videoPlayerController.value.isPlaying;
      if (isPlaying && !isTtsPlaying) {
        playTTS();
      } else if (!isPlaying && isTtsPlaying) {
        stopTTS();
      }

      if (_videoPlayerController.value.position >=
          Duration(seconds: speakingTime.toInt())) {
        _videoPlayerController.pause();
        stopTTS();
        showReplayDialog();
      }
    });

    Timer(Duration(seconds: speakingTime.toInt()), () {
      if (_videoPlayerController.value.isPlaying) {
        _videoPlayerController.pause();
        stopTTS();
        showReplayDialog();
      }
    });
  }

  Future<void> playTTS() async {
    setState(() {
      isTtsPlaying = true;
    });
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1); // range 0.5-1.5
    await flutterTts.speak(description!);
  }

  Future<void> stopTTS() async {
    setState(() {
      isTtsPlaying = false;
    });
    await flutterTts.stop();
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
                _videoPlayerController.seekTo(Duration.zero);
                Navigator.of(context).pop();
                _videoPlayerController.play();
                playTTS();
              },
            ),
            TextButton(
              child: Text("Next"),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NewsMedia(
                            imagesList: widget.imagesList,
                          )),
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
    final article = widget.article;

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 104, 103, 103),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      leading: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Icon(Icons.arrow_back_ios_new, color: Colors.white),
                      ),
                      title: GestureDetector(
                        onTap: () {
                          setState(() {
                            isExpandedTitle = !isExpandedTitle;
                          });
                        },
                        child: AnimatedCrossFade(
                          firstChild: Container(
                            constraints: BoxConstraints(maxHeight: 40.0),
                            child: sampleText(
                              text: article?.title == "[Removed]"
                                  ? "International News"
                                  : article?.title ?? "International News",
                              fontsize: 20,
                              color: Colors.white,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          secondChild: sampleText(
                            text: article?.title == "[Removed]"
                                ? "International News"
                                : article?.title ?? "International News",
                            fontsize: 20,
                            color: Colors.white,
                          ),
                          crossFadeState: isExpandedTitle
                              ? CrossFadeState.showSecond
                              : CrossFadeState.showFirst,
                          duration: Duration(milliseconds: 300),
                        ),
                      ),
                    ),
                    Image.asset('lib/assests/images/line.png'),
                    Row(
                      children: [
                        SizedBox(width: 20),
                        CircleAvatar(
                          radius: 25,
                          backgroundImage:
                              AssetImage("lib/assests/images/profile.jpg"),
                        ),
                        SizedBox(width: 10),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            sampleText(
                              text: article?.author ??
                                  'LISA MANUBAN', //article?.author,
                              color: Colors.white,
                              fontsize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                            sampleText(
                              text: article?.publishedAt ??
                                  '12 dec 2024', //article?.publishedAt,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      color: Colors.black,
                      height: 250,
                      width: double.infinity,
                      child: Chewie(
                        controller: _chewieController,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset('lib/assests/images/line.png'),
                          sampleText(
                            fontsize: 20,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                            text: article?.title == "[Removed]"
                                ? "Pakistan Faces Economic and Security Challenges Amidst Political Instability"
                                : article?.title ?? "No Title",
                          ),
                          Image.asset('lib/assests/images/line.png'),
                          sampleText(
                            textAlign: TextAlign.start,
                            fontsize: 20,
                            fontWeight: FontWeight.w400,
                            text: "Description:",
                            color: Colors.white,
                          ),
                          AnimatedCrossFade(
                            firstChild: sampleText(
                              color: Colors.white,
                              text: article?.description != null &&
                                      article!.description!.length > 100
                                  ? article.description!.substring(0, 100) + "..."
                                  : article?.description ?? "No Description",
                            ),
                            secondChild: sampleText(
                              color: Colors.white,
                              text: article?.description ?? "No Description",
                            ),
                            crossFadeState: isExpandedDescription
                                ? CrossFadeState.showSecond
                                : CrossFadeState.showFirst,
                            duration: Duration(milliseconds: 300),
                          ),
                          InkWell(
                            child: sampleText(
                              text: isExpandedDescription ? "Show Less" : "Read More",
                              decoration: TextDecoration.underline,
                              color: Colors.blue,
                            ),
                            onTap: () {
                              setState(() {
                                isExpandedDescription = !isExpandedDescription;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              color: Colors.transparent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  button(
                    width: 120,
                    title: "Go Back",
                    ontap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DashboardScreen()),
                      );
                    },
                  ),
                  button(
                    containerColor: Colors.white,
                    width: 180,
                    title: "Check for Media",
                    textColor: Colors.black,
                    ontap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NewsMedia(
                                  imagesList: widget.imagesList,
                                )),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
