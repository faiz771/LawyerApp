import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:carousel_slider/carousel_slider.dart';

class PromotionSliderViewTemplate extends StatelessWidget {
  final List<Map<String, dynamic>> sliderimages = [
    {"image": 'assets/images/slider1.jpg'},
    {"image": 'assets/images/slider2.jpg'},
    {"image": 'assets/images/slider3.jpg'},
    {"image": 'assets/images/slider1.jpg'},
    {"image": 'assets/images/slider2.jpg'},
    {"image": 'assets/images/slider3.jpg'}
  ];
  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      options: CarouselOptions(
          autoPlay: true,
          aspectRatio: 12 / 7,
          enableInfiniteScroll: false,
          enlargeCenterPage: true,
          initialPage: 2),
      itemCount: 6,
      itemBuilder: (context, index, _) {
        return ClipRRect(
          borderRadius:
              BorderRadius.circular(12.0), // Set your desired border radius
          child: Image.asset(
            sliderimages[index]['image'],
            fit: BoxFit.cover,
          ),
        );
      },
    );
  }
}
