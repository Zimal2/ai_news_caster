import 'package:ai_news_caster/ui/dashboard/dashboard.dart';
import 'package:ai_news_caster/ui/mediaScreens/newsMedia.dart';
import 'package:ai_news_caster/ui/mediaScreens/readMore.dart';
import 'package:ai_news_caster/widgets/button.dart';
import 'package:ai_news_caster/widgets/text.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> with TickerProviderStateMixin {
  // late VideoPlayerController _videoPlayerController;
  // late ChewieController _chewieController;

  // void dispose() {
  //   _controller.dispose();

  //   _videoPlayerController.dispose();
  //   _chewieController.dispose();
  //   super.dispose();
  // }

  // void initState() {
  //   _videoPlayerController =
  //       VideoPlayerController.asset('lib/assests/videos/uploadvideo.mp4');
  //   _chewieController = ChewieController(
  //       videoPlayerController: _videoPlayerController,
  //       autoPlay: true,
  //       looping: true,
  //       allowFullScreen: true,
  //       showControls: false,
  //       allowMuting: false,
  //       allowedScreenSleep: false,
  //       autoInitialize: true,
  //       aspectRatio: 800 / 1640,
  //       fullScreenByDefault: true);

  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 104, 103, 103),
      body: SafeArea(
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
                  text: "International News",
                  fontsize: 20,
                  color: Colors.white),
            ),
            Image.asset(
              'lib/assests/images/line.png',
            ),
            Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                CircleAvatar(
                  radius: 25,
                  backgroundImage: AssetImage("lib/assests/images/women.jpg"),
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    sampleText(
                        text: "Jacob nancy",
                        color: Colors.white,
                        fontsize: 20,
                        fontWeight: FontWeight.w500),
                    sampleText(
                        text: "Uploaded on 2:30 AM", color: Colors.white),
                  ],
                )
              ],
            ),

            //video upload here
            Container(
                color: Colors.black,
                height: 250,
                width: double.infinity,
                child: Text("data")
                //Chewie(controller: _chewieController),
                ),

            ////
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    'lib/assests/images/line.png',
                  ),
                  sampleText(
                      fontsize: 20,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                      text:
                          "News of digital market regarding the ups and downs"),
                  Image.asset(
                    'lib/assests/images/line.png',
                  ),
                  sampleText(
                      textAlign: TextAlign.start,
                      fontsize: 20,
                      fontWeight: FontWeight.w400,
                      text: "Description:",
                      color: Colors.white),
                  sampleText(
                      color: Colors.white,
                      text:
                          "In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content. Lorem ipsum may be used as a placeholder before final copy is available In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visua form of a document or a typeface without relying on meaningful content."),
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
                              builder: (context) => ReadMore(),
                            ));
                      }),
                  Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      button(
                        width: 120,
                        title: "Go Back",
                        //ontap: () => EmailConfirmation(),
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => NewsMedia(),
                              ));
                          // EmailConfirmation(); // Call the function EmailConfirmation() here
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
    );
  }
}
