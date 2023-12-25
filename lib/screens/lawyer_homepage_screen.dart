import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:lawyerapp/components/Lawyer_slider_view_template.dart';
import 'package:lawyerapp/components/filter_dropdown_button.dart';
import 'package:lawyerapp/components/homepage_icons_with_text_template.dart';
import 'package:lawyerapp/components/mytextfield.dart';
import 'package:lawyerapp/components/promotion_slider_view_template.dart';
import 'package:lawyerapp/components/rounded_button.dart';
import 'package:lawyerapp/screens/all_lawyer_screen.dart';
import 'package:lawyerapp/screens/analytics_screen.dart';
import 'package:lawyerapp/screens/appointment_detail_screen.dart';
import 'package:lawyerapp/screens/cancelled_booking_screen.dart';
import 'package:lawyerapp/screens/client_dashboard_screen.dart';
import 'package:lawyerapp/screens/completed_booking_screen.dart';
import 'package:lawyerapp/screens/notification_screen.dart';
import 'package:lawyerapp/screens/profile_setting_screen.dart';
import 'package:lawyerapp/screens/upcoming_booking_screen.dart';

class LawyerHomepage extends StatefulWidget {
  const LawyerHomepage({super.key});

  @override
  State<LawyerHomepage> createState() => _LawyerHomepageState();
}

class _LawyerHomepageState extends State<LawyerHomepage> {
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
                      InkWell(
                        onTap: () {
                          Get.to(Notificationscreen());
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          child: CircleAvatar(
                              backgroundColor: Colors.grey[300],
                              child: Icon(Icons.notifications)),
                        ),
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
                  SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: DefaultTabController(
                      length: 3, // Set the number of tabs
                      child: Column(
                        children: [
                          // Your TabBar widget
                          TabBar(
                            indicatorColor: Color.fromRGBO(17, 25, 40, 1),
                            labelColor: Color.fromRGBO(17, 25, 40, 1),
                            unselectedLabelColor: Colors.grey,
                            labelStyle: TextStyle(fontWeight: FontWeight.bold),
                            tabs: [
                              Tab(
                                text: 'Upcoming',
                              ),
                              Tab(text: 'Completed'),
                              Tab(text: 'Cancelled'),
                            ],
                          ),
                          // The content associated with the tabs
                          Expanded(
                            child: TabBarView(
                              children: [
                                // Content for Upcoming tab
                                SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      UpcomingBookingScreen(
                                        button1: false,
                                        button2: true,
                                        onPressed1: () {},
                                        onPressed2: () {
                                          Get.to(AppointmentDetailScreen());
                                        },
                                        button1title: 'Cancel',
                                        button2title: 'View',
                                      ),
                                      UpcomingBookingScreen(
                                        button1: false,
                                        button2: true,
                                        onPressed1: () {},
                                        onPressed2: () {
                                          Get.to(AppointmentDetailScreen());
                                        },
                                        button1title: 'Cancel',
                                        button2title: 'View',
                                      ),
                                      UpcomingBookingScreen(
                                        button1: false,
                                        button2: true,
                                        onPressed1: () {},
                                        onPressed2: () {
                                          Get.to(AppointmentDetailScreen());
                                        },
                                        button1title: 'Cancel',
                                        button2title: 'View',
                                      ),
                                      SizedBox(
                                        height: 10,
                                      )
                                    ],
                                  ),
                                ),

                                SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      CompletedBookingScreen(
                                        showbutton: false,
                                      ),
                                      CompletedBookingScreen(
                                        showbutton: false,
                                      ),
                                      CompletedBookingScreen(
                                        showbutton: false,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      )
                                    ],
                                  ),
                                ),
                                // Content for Completed tab

                                // Content for Cancelled tab
                                // CancelledBookingScreen
                                SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      CancelledBookingScreen(
                                        showbutton: false,
                                      ),
                                      CancelledBookingScreen(
                                        showbutton: false,
                                      ),
                                      CancelledBookingScreen(
                                        showbutton: false,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          AnalyticsScreen(),
          //ClientDashboardScreen(),
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
            icon: Icon(Icons.bar_chart_outlined),
            title: Text('Analytics'),
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
