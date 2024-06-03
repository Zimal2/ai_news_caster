import 'package:ai_news_caster/provider/Methods.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';

class ImageSlider extends StatelessWidget {
  const ImageSlider({super.key});

  @override
  Widget build(BuildContext context) {
    final methodsProvider = Provider.of<Methods>(context);

    return FutureBuilder(
      future: methodsProvider.getPostApimethod(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          debugPrint(snapshot.error.toString());
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.articles == null) {
          return const Center(child: Text("No data available"));
        }

        return Container(
          width: double.infinity,
          height: 250,
          child: CarouselSlider.builder(
            itemCount: snapshot.data!.articles!.length,
            itemBuilder: (context, index, realIndex) {
              final doc = snapshot.data!.articles![index];

              return Card(
                elevation: 10,
                child: Container(
                  width: MediaQuery.of(context).size.width * .9,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      isValidUrl(doc.urlToImage)
                          ? doc.urlToImage!
                          : 'https://i.pinimg.com/564x/4e/d1/26/4ed126ab70265d07682cba1995385822.jpg',
                      fit: BoxFit.fill,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.network(
                          'https://i.pinimg.com/564x/4e/d1/26/4ed126ab70265d07682cba1995385822.jpg',
                          fit: BoxFit.fill,
                        );
                      },
                    ),
                  ),
                ),
              );
            },
            options: CarouselOptions(
              aspectRatio: 1.2,
              autoPlay: true,
              enlargeCenterPage: true,
              initialPage: 0,
              viewportFraction: 0.7,
              reverse: true,
              scrollDirection: Axis.horizontal,
            ),
          ),
        );
      },
    );
  }

  bool isValidUrl(String? url) {
    if (url == null || url.isEmpty) return false;
    Uri uri = Uri.tryParse(url) ?? Uri();
    return uri.isAbsolute && uri.hasScheme && uri.hasAuthority;
  }
}
