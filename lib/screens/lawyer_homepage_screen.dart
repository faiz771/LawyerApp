import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lawyerapp/controllers/user_controller.dart';
import 'package:lawyerapp/models/user_detail_model.dart';
import 'package:lawyerapp/screens/analytics_screen.dart';
import 'package:lawyerapp/screens/blog_screen.dart';
import 'package:lawyerapp/screens/chat_bot_screen.dart';
import 'package:lawyerapp/screens/completed_booking_screen.dart';
import 'package:lawyerapp/screens/notification_screen.dart';
import 'package:lawyerapp/screens/profile_setting_screen.dart';
import 'package:lawyerapp/screens/upcoming_booking_screen.dart';
import 'package:lawyerapp/utils/app_colors.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LawyerHomepage extends StatefulWidget {
  UserModel user;
  LawyerHomepage({super.key, required this.user});

  @override
  State<LawyerHomepage> createState() => _LawyerHomepageState();
}

class _LawyerHomepageState extends State<LawyerHomepage> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();
  final UserController controller = Get.put(UserController());
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
                          Get.to(ProfileSettingScreen(
                            user: widget.user,
                          ));
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: CircleAvatar(
                            radius: 30,
                            child: Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                          widget.user.profile_path!))),
                            ),
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
                                AppLocalizations.of(context)!.welcome_back,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(color: Colors.grey),
                              ),
                              Text(
                                widget.user.name,
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
                  // SizedBox(
                  //   height: 20.h,
                  // ),
                  // MyTextField(
                  //     isicon2: false, hinttext: 'Search', icon: Icons.search),
                  // SizedBox(
                  //   height: 10.h,
                  // ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: DefaultTabController(
                      length: 3, // Set the number of tabs
                      child: Column(
                        children: [
                          // Your TabBar widget
                          TabBar(
                            indicatorColor: const Color.fromRGBO(17, 25, 40, 1),
                            labelColor: const Color.fromRGBO(17, 25, 40, 1),
                            unselectedLabelColor: Colors.grey,
                            labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                            tabs: [
                              Tab(
                                text: AppLocalizations.of(context)!.upcoming,
                              ),
                              Tab(
                                  text:
                                      AppLocalizations.of(context)!.completed),
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
                                          // Get.to(
                                          //     const AppointmentDetailScreen());
                                        },
                                        button1title: 'View',
                                      ),
                                      UpcomingBookingScreen(
                                        button1: true,
                                        onPressed1: () {
                                          // Get.to(
                                          //     const AppointmentDetailScreen());
                                        },
                                        button1title: 'View',
                                      ),
                                      UpcomingBookingScreen(
                                        button1: true,
                                        onPressed1: () {
                                          // Get.to(
                                          //     const AppointmentDetailScreen());
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
          // const ProfileSettingScreen(),
          const BlogScreen(),
          const ChatPage()
        ],
      ),

      bottomNavigationBar: BottomNavyBar(
        backgroundColor: AppColor.teelColor,
        selectedIndex: _currentIndex,
        onItemSelected: (index) {
          setState(() {
            _currentIndex = index;
            _pageController.jumpToPage(index);
          });
        },
        items: [
          BottomNavyBarItem(
            textAlign: TextAlign.center,
            inactiveColor: Colors.grey,
            icon: const Icon(
              Icons.home_filled,
              color: Colors.white,
            ),
            title: Text(AppLocalizations.of(context)!.home),
            activeColor: Colors.white,
          ),
          BottomNavyBarItem(
            textAlign: TextAlign.center,
            inactiveColor: Colors.grey,
            icon: const Icon(
              Icons.bar_chart_outlined,
              color: Colors.white,
            ),
            title: Text(AppLocalizations.of(context)!.analytics),
            activeColor: Colors.white,
          ),
          // BottomNavyBarItem(
          //    textAlign: TextAlign.center,
          //   inactiveColor: Colors.grey,
          //   icon: const Icon(Icons.person),
          //   title: const Text('Profile'),
          // activeColor: Colors.white,
          // ),
          BottomNavyBarItem(
            textAlign: TextAlign.center,
            inactiveColor: Colors.grey,
            icon: Image.asset(
              'assets/images/blog-3.png',
              scale: 22,
              color: Colors.white,
            ),
            title: Text(AppLocalizations.of(context)!.blogs),
            activeColor: Colors.white,
          ),
          BottomNavyBarItem(
            textAlign: TextAlign.center,
            inactiveColor: Colors.grey,
            icon: Image.asset(
              'assets/images/chatbot.png',
              scale: 20,
              color: Colors.white,
            ),
            title: Text(AppLocalizations.of(context)!.ai_chat),
            activeColor: Colors.white,
          ),
        ],
      ),
    );
  }
}
