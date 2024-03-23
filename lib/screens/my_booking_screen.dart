import 'package:flutter/material.dart';
import 'package:lawyerapp/screens/completed_booking_screen.dart';
import 'package:lawyerapp/screens/upcoming_booking_screen.dart';
import 'package:lawyerapp/utils/app_colors.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyBookingScreen extends StatelessWidget {
  const MyBookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.teelColor,
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text(
            AppLocalizations.of(context)!.my_bookings,
            style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          bottom: TabBar(
            physics: const BouncingScrollPhysics(),
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.grey,
            labelStyle: const TextStyle(fontWeight: FontWeight.bold),
            tabs: [
              Tab(
                text: AppLocalizations.of(context)!.upcoming,
              ),
              Tab(text: AppLocalizations.of(context)!.completed),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Content for Upcoming tab
            SingleChildScrollView(
              child: Column(
                children: [
                  UpcomingBookingScreen(
                    button1: true,
                    onPressed1: () {},
                    button1title: AppLocalizations.of(context)!.reschedule,
                  ),
                  UpcomingBookingScreen(
                    button1: true,
                    onPressed1: () {},
                    button1title: AppLocalizations.of(context)!.reschedule,
                  ),
                  UpcomingBookingScreen(
                    button1: true,
                    onPressed1: () {},
                    button1title: AppLocalizations.of(context)!.reschedule,
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
                    showbutton: true,
                  ),
                  CompletedBookingScreen(
                    showbutton: true,
                  ),
                  CompletedBookingScreen(
                    showbutton: true,
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
            //         showbutton: true,
            //       ),
            //       CancelledBookingScreen(
            //         showbutton: true,
            //       ),
            //       CancelledBookingScreen(
            //         showbutton: true,
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
    );
  }
}
