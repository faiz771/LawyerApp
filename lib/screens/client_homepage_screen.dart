import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:lawyerapp/components/promotion_slider_view_template.dart';
import 'package:lawyerapp/controllers/blog_controller.dart';
import 'package:lawyerapp/controllers/login_controller.dart';
import 'package:lawyerapp/controllers/user_controller.dart';
import 'package:lawyerapp/models/user_detail_model.dart';
import 'package:lawyerapp/screens/blog_screen.dart';
import 'package:lawyerapp/screens/chat_bot_screen.dart';
import 'package:lawyerapp/screens/my_booking_screen.dart';
import 'package:lawyerapp/screens/consultation_page.dart';
import 'package:lawyerapp/screens/notification_screen.dart';
import 'package:lawyerapp/screens/profile_setting_screen.dart';
import 'package:lawyerapp/screens/upcoming_booking_screen.dart';
import 'package:lawyerapp/utils/app_colors.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ClientHomepage extends StatefulWidget {
  UserModel user;
  ClientHomepage({super.key, required this.user});

  @override
  State<ClientHomepage> createState() => _ClientHomepageState();
}

class _ClientHomepageState extends State<ClientHomepage> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();
  final UserController controller = Get.put(UserController());
  final BlogController blogController = Get.put(BlogController());
  final LoginController loginController = Get.put(LoginController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    blogController.fetchArticles();
    blogController.fetchPodcasts();
    blogController.fetchVideos();
  }

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
            child: Scaffold(
              floatingActionButton: Container(
                decoration: BoxDecoration(
                  color: AppColor.teelColor,
                  borderRadius: BorderRadius.circular(
                    12,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Image.asset(
                    'assets/images/chat.png',
                    scale: 13,
                    color: Colors.white,
                  ),
                ),
              ),
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 30.h,
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
                            padding: const EdgeInsets.only(left: 8, right: 8),
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
                                  style: TextStyle(color: Colors.grey),
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
                    // MyTextField(hinttext: 'Search', icon: Icons.search),
                    SizedBox(
                      height: 10.h,
                    ),

                    SizedBox(
                      height: 10.h,
                    ),
                    // Container(
                    //   margin: const EdgeInsets.all(8),
                    //   padding: const EdgeInsets.all(8),
                    //   decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(15),
                    //     color: Colors.white,
                    //     boxShadow: [
                    //       BoxShadow(
                    //         color: Colors.grey.withOpacity(0.5),
                    //         spreadRadius: 5,
                    //         blurRadius: 7,
                    //         offset: const Offset(0, 3),
                    //       ),
                    //     ],
                    //   ),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //     children: [
                    //       Image.asset(
                    //         'assets/images/book_consultaion.png',
                    //         scale: 10,
                    //       ),
                    //       const Text(
                    //         'Book Consultation Now',
                    //         style: TextStyle(
                    //             fontSize: 20, fontWeight: FontWeight.bold),
                    //       )
                    //     ],
                    //   ),
                    // ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: BookConsultationButton(),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      AppLocalizations.of(context)!.upcoming_appointments,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        // const HomepageIconsWithTextTemplate(),
                        CarouselSlider(
                          options: CarouselOptions(
                            height: 210,
                            enlargeCenterPage: true,
                            autoPlay: true,
                            autoPlayCurve: Curves.fastOutSlowIn,
                            enableInfiniteScroll: true,
                            autoPlayAnimationDuration:
                                const Duration(milliseconds: 800),
                            viewportFraction: 1,
                          ),
                          items: [
                            UpcomingBookingScreen(
                              button1: false,
                              onPressed1: () {
                                // Handle button 1 press
                              },
                              button1title:
                                  AppLocalizations.of(context)!.reschedule,
                            ),
                            // Add more instances of UpcomingBookingScreen for each item in the carousel
                          ],
                        ),

                        // Padding(
                        //   padding:
                        //       EdgeInsets.only(right: 10.w, top: 5.h, bottom: 2.h),
                        //   child: InkWell(
                        //       onTap: () {
                        //         Get.to(const AllLawyerScreen());
                        //       },
                        //       child: const Text('See All')),
                        // ),
                        // LawyerSliderViewTemplate(),
                        // RoundedButton(
                        //     text: 'Top Rated Lawyers',
                        //     onPressed: () {
                        //       Get.to(AllLawyerScreen());
                        //     }),
                        //LawyerSliderViewTemplate()
                      ],
                    ),
                    //BlogScreen(),
                    Text(
                      AppLocalizations.of(context)!.blogs_podcasts,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    ArticleCarouselSlider(),
                    const SizedBox(
                      height: 10,
                    )
                  ],
                ),
              ),
            ),
          ),
          const MyBookingScreen(),
          // const ProfileSettingScreen(),
          const BlogScreen(),
          ChatPage()
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
            icon: Image.asset(
              'assets/images/home-2.png',
              scale: 20,
              color: Colors.white,
            ),
            title: Text(AppLocalizations.of(context)!.home),
            activeColor: Colors.white,
          ),
          BottomNavyBarItem(
            textAlign: TextAlign.center,
            inactiveColor: Colors.grey,
            icon: Image.asset(
              'assets/images/appointment.png',
              scale: 20,
              color: Colors.white,
            ),
            title: Text(AppLocalizations.of(context)!.bookings),
            activeColor: Colors.white,
          ),
          // BottomNavyBarItem(
          //   icon: const Icon(
          //     Icons.person_2_outlined,
          //     size: 30,
          //   ),
          //   title: const Text('Profile'),
          //   activeColor: const Color.fromRGBO(17, 25, 40, 1),
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

class BookConsultationButton extends StatefulWidget {
  const BookConsultationButton({super.key});

  @override
  _BookConsultationButtonState createState() => _BookConsultationButtonState();
}

class _BookConsultationButtonState extends State<BookConsultationButton>
    with TickerProviderStateMixin {
  late AnimationController _vibrationController;
  late Animation<Offset> _vibrationAnimation;

  @override
  void initState() {
    super.initState();
    _vibrationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    )..repeat(
        reverse:
            true); // Repeat the animation in forward and reverse directions
    _vibrationAnimation = Tween<Offset>(
      begin: const Offset(0, 0),
      end: const Offset(0.03, 0),
    ).animate(_vibrationController);
  }

  @override
  void dispose() {
    _vibrationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _vibrationAnimation,
      child: InkWell(
        onTap: () {
          Get.to(const ConsultationForm());
        },
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: const Color.fromRGBO(17, 25, 40, 1),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 8,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/book_consultaion.png',
                  scale: 20,
                  color: Colors.white,
                ),
                const SizedBox(width: 8),
                Text(
                  AppLocalizations.of(context)!.book_consultation,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
