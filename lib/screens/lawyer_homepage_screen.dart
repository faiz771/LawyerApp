import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:lawyerapp/components/mytextfield.dart';
import 'package:lawyerapp/screens/analytics_screen.dart';
import 'package:lawyerapp/screens/appointment_detail_screen.dart';
import 'package:lawyerapp/screens/blog_screen.dart';
import 'package:lawyerapp/screens/chat_bot_screen.dart';
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
  final PageController _pageController = PageController();
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
                            decoration: const BoxDecoration(
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
                          child: const Column(
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
                          Get.to(const Notificationscreen());
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          child: CircleAvatar(
                              backgroundColor: Colors.grey[300],
                              child: const Icon(Icons.notifications)),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  MyTextField(
                      isicon2: false, hinttext: 'Search', icon: Icons.search),
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
                          const TabBar(
                            indicatorColor: Color.fromRGBO(17, 25, 40, 1),
                            labelColor: Color.fromRGBO(17, 25, 40, 1),
                            unselectedLabelColor: Colors.grey,
                            labelStyle: TextStyle(fontWeight: FontWeight.bold),
                            tabs: [
                              Tab(
                                text: 'Upcoming',
                              ),
                              Tab(text: 'Completed'),
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
                                        button1: true,
                                        onPressed1: () {
                                          Get.to(
                                              const AppointmentDetailScreen());
                                        },
                                        button1title: 'View',
                                      ),
                                      UpcomingBookingScreen(
                                        button1: true,
                                        onPressed1: () {
                                          Get.to(
                                              const AppointmentDetailScreen());
                                        },
                                        button1title: 'View',
                                      ),
                                      UpcomingBookingScreen(
                                        button1: true,
                                        onPressed1: () {
                                          Get.to(
                                              const AppointmentDetailScreen());
                                        },
                                        button1title: 'View',
                                      ),
                                      const SizedBox(
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
                                      const SizedBox(
                                        height: 10,
                                      )
                                    ],
                                  ),
                                ),
                                // Content for Completed tab

                                // Content for Cancelled tab
                                // CancelledBookingScreen
                                // SingleChildScrollView(
                                //   child: Column(
                                //     children: [
                                //       CancelledBookingScreen(
                                //         showbutton: false,
                                //       ),
                                //       CancelledBookingScreen(
                                //         showbutton: false,
                                //       ),
                                //       CancelledBookingScreen(
                                //         showbutton: false,
                                //       ),
                                //       const SizedBox(
                                //         height: 10,
                                //       )
                                //     ],
                                //   ),
                                // ),
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
          const AnalyticsScreen(),
          //ClientDashboardScreen(),
          const ProfileSettingScreen(),
          BlogScreen(),
          const ChatBotScreen()
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
            icon: const Icon(Icons.home_filled),
            title: const Text('Home'),
            activeColor: const Color.fromRGBO(17, 25, 40, 1),
          ),
          BottomNavyBarItem(
            icon: const Icon(Icons.bar_chart_outlined),
            title: const Text('Analytics'),
            activeColor: const Color.fromRGBO(17, 25, 40, 1),
          ),
          BottomNavyBarItem(
            icon: const Icon(Icons.person),
            title: const Text('Profile'),
            activeColor: const Color.fromRGBO(17, 25, 40, 1),
          ),
          BottomNavyBarItem(
            icon: Image.asset(
              'assets/images/blog-3.png',
              scale: 22,
            ),
            title: const Text('Blogs'),
            activeColor: const Color.fromRGBO(17, 25, 40, 1),
          ),
          BottomNavyBarItem(
            icon: Image.asset(
              'assets/images/chatbot.png',
              scale: 20,
            ),
            title: const Text('Ai Chat'),
            activeColor: const Color.fromRGBO(17, 25, 40, 1),
          ),
        ],
      ),
    );
  }
}
