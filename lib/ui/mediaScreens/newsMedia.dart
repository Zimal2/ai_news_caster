import 'package:ai_news_caster/ui/dashboard/dashboard.dart';
import 'package:ai_news_caster/widgets/button.dart';
import 'package:ai_news_caster/widgets/text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class NewsMedia extends StatefulWidget {
  final List? imagesList;
  NewsMedia({super.key, this.imagesList});

  @override
  State<NewsMedia> createState() => _NewsMediaState();
}

class _NewsMediaState extends State<NewsMedia> {
  @override
  void initState() {
    super.initState();
  }

  void _showFullScreenImage(BuildContext context, String imageUrl) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: CachedNetworkImage(
            imageUrl: imageUrl=='='?'https://i.pinimg.com/564x/4e/d1/26/4ed126ab70265d07682cba1995385822.jpg':imageUrl,
            fit: BoxFit.contain,
            placeholder: (context, url) => Center(
              child: CircularProgressIndicator(),
            ),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
        );
      },
    );
  }

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
                    text: "Media",
                    fontsize: 20,
                    color: Colors.white,
                  ),
                ),
                Image.asset('lib/assests/images/line.png'),
                Container(
                  height: MediaQuery.of(context).size.height * 0.8,
                  width: MediaQuery.of(context).size.width,
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // 2 images per row
                      crossAxisSpacing: 10.0, // Space between columns
                      mainAxisSpacing: 12.0, // Space between rows
                    ),
                    itemCount: widget.imagesList!.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () => _showFullScreenImage(
                            context, widget.imagesList![index]),
                        child: CachedNetworkImage(
                          imageUrl: widget.imagesList![index] == "="
                              ? 'https://i.pinimg.com/564x/4e/d1/26/4ed126ab70265d07682cba1995385822.jpg'
                              : widget.imagesList![index],
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          ),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                      );
                    },
                    padding: const EdgeInsets.all(10.0),
                  ),
                ),
                button(
                  title: "Go to dashboard",
                  ontap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DashboardScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
