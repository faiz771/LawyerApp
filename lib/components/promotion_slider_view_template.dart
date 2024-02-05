import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:lawyerapp/screens/blog_screen.dart';

class PromotionSliderViewTemplate extends StatelessWidget {
  final List<Map<String, dynamic>> sliderimages = [
    {"image": 'assets/images/slider1.jpg'},
    {"image": 'assets/images/slider2.jpg'},
    {"image": 'assets/images/slider3.jpg'},
    {"image": 'assets/images/slider1.jpg'},
    {"image": 'assets/images/slider2.jpg'},
    {"image": 'assets/images/slider3.jpg'}
  ];

  PromotionSliderViewTemplate({super.key});
  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      options: CarouselOptions(
          height: 400,
          autoPlay: true,
          enableInfiniteScroll: false,
          enlargeCenterPage: true,
          initialPage: 2,
          viewportFraction: 1),
      itemCount: 6,
      itemBuilder: (context, index, _) {
        return BlogPostContainer();
      },
    );
  }
}
