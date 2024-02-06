import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class ImageSlider extends StatefulWidget {
  const ImageSlider({super.key});

  @override
  State<ImageSlider> createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  final controller = CarouselController();
  int activeIndex = 0;
  final urlImage = [
    "lib/assests/images/slider1.png",
    "lib/assests/images/slider2.png",
    "lib/assests/images/slider3.png",
  ];

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
        options: CarouselOptions(
            height: 150,
            autoPlay: false,
            enlargeCenterPage: true,
            enableInfiniteScroll: true,
            // viewportFraction: 1,
            aspectRatio: 2.0,
            initialPage: 1,
            scrollDirection: Axis.horizontal,
            onPageChanged: (index, reason) {
              setState(
                () => activeIndex = index,
              );
            }),
        itemCount: urlImage.length,
        itemBuilder: (context, index, realIndex) {
          return buildImage(urlImage[index]);
        });
  }
}

Widget buildImage(String urlImage) => Container(
      width: double.infinity,
      //  margin: EdgeInsets.symmetric(horizontal: 5),
      color: Colors.white,
      child: Image.asset(
        urlImage,
        fit: BoxFit.cover,
      ),
    );
