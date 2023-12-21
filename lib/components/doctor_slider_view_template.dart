import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:carousel_slider/carousel_slider.dart';

class DoctorSliderViewTemplate extends StatelessWidget {
  final List<Map<String, dynamic>> dummyData = [
    {
      'name': 'Dr.Syed Muhammad Talha',
      'specialization': 'Criminal Lawyer',
      'availability': 'Available',
      'price': 'Rs. 30000',
    },
    {
      'name': 'Dr.Syed Muhammad Talha',
      'specialization': 'Criminal Lawyer',
      'availability': 'Available',
      'price': 'Rs. 30000',
    },
    {
      'name': 'Dr.Syed Muhammad Talha',
      'specialization': 'Criminal Lawyer',
      'availability': 'Available',
      'price': 'Rs. 30000',
    },
    {
      'name': 'Dr.Syed Muhammad Talha',
      'specialization': 'Criminal Lawyer',
      'availability': 'Available',
      'price': 'Rs. 30000',
    },
    {
      'name': 'Dr.Syed Muhammad Talha',
      'specialization': 'Criminal Lawyer',
      'availability': 'Available',
      'price': 'Rs. 30000',
    },
    // Add more dummy data entries as needed
  ];

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      options: CarouselOptions(
        autoPlay: true,
        aspectRatio: 12 / 7.5,
        enableInfiniteScroll: false,
        enlargeCenterPage: true,
      ),
      itemCount: 5,
      itemBuilder: (context, index, _) {
        return Center(
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  child: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.blue, width: 5)),
                    child: CircleAvatar(
                      radius: 40.h,
                      child: Image.asset('assets/images/person.png'),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 5.h,
                  ),
                  child: Column(
                    children: [
                      Text(
                        dummyData[index]['name'],
                        style: TextStyle(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.ellipsis),
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      Text(dummyData[index]['specialization'],
                          style: TextStyle(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.bold,
                              overflow: TextOverflow.ellipsis)),
                      SizedBox(
                        height: 4.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(dummyData[index]['availability'],
                              style: TextStyle(
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.bold,
                                  overflow: TextOverflow.ellipsis)),
                          Text(dummyData[index]['price'],
                              style: TextStyle(
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.bold,
                                  overflow: TextOverflow.ellipsis))
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
