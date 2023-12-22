import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:lawyerapp/components/Lawyer_slider_view_template.dart';
import 'package:lawyerapp/components/filter_dropdown_button.dart';
import 'package:lawyerapp/components/homepage_icons_with_text_template.dart';
import 'package:lawyerapp/components/mytextfield.dart';
import 'package:lawyerapp/components/promotion_slider_view_template.dart';
import 'package:lawyerapp/components/rounded_button.dart';
import 'package:lawyerapp/screens/all_lawyer_screen.dart';
import 'package:lawyerapp/screens/appointments_history_screen.dart';
import 'package:lawyerapp/screens/profile_setting_screen.dart';

class ClientHomepage extends StatefulWidget {
  const ClientHomepage({super.key});

  @override
  State<ClientHomepage> createState() => _ClientHomepageState();
}

class _ClientHomepageState extends State<ClientHomepage> {
  int _currentIndex = 0;
  PageController _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   actions: [

      //   ],
      // ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 40.h,
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          _pageController.jumpToPage(2);
                        },
                        child: CircleAvatar(
                          radius: 30,
                          child: Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage(
                                      'assets/images/onboard3.jpg',
                                    ))),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(left: 10.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Hi, Welcome Back!',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(color: Colors.grey),
                              ),
                              Text(
                                'John Doe William',
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.w),
                        child: CircleAvatar(
                            backgroundColor: Colors.grey[300],
                            child: Icon(Icons.notifications)),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  MyTextField(hinttext: 'Search', icon: Icons.search),
                  SizedBox(
                    height: 10.h,
                  ),
                  PromotionSliderViewTemplate(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      HomepageIconsWithTextTemplate(),
                      Padding(
                        padding: EdgeInsets.only(
                            right: 10.w, top: 10.h, bottom: 2.h),
                        child: InkWell(
                            onTap: () {
                              Get.to(AllLawyerScreen());
                            },
                            child: Text('See All')),
                      ),
                      LawyerSliderViewTemplate(),
                      // RoundedButton(
                      //     text: 'Top Rated Lawyers',
                      //     onPressed: () {
                      //       Get.to(AllLawyerScreen());
                      //     }),
                      //LawyerSliderViewTemplate()
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  )
                ],
              ),
            ),
          ),
          AppointmentHistoryScreen(),
          ProfileSettingScreen(),
        ],
      ),

      bottomNavigationBar: BottomNavyBar(
        backgroundColor: Colors.grey[300],
        selectedIndex: _currentIndex,
        onItemSelected: (index) {
          setState(() {
            _currentIndex = index;
            _pageController.jumpToPage(index);
          });
        },
        items: [
          BottomNavyBarItem(
            icon: Icon(Icons.home_filled),
            title: Text('Home'),
            activeColor: Color.fromRGBO(17, 25, 40, 1),
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.history),
            title: Text('History'),
            activeColor: Color.fromRGBO(17, 25, 40, 1),
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.person),
            title: Text('Profile'),
            activeColor: Color.fromRGBO(17, 25, 40, 1),
          ),
        ],
      ),
    );
  }
}
