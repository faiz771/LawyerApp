import 'package:flutter/material.dart';
import 'package:lawyerapp/screens/cancelled_booking_screen.dart';
import 'package:lawyerapp/screens/completed_booking_screen.dart';
import 'package:lawyerapp/screens/upcoming_booking_screen.dart';

class ClientDashboardScreen extends StatelessWidget {
  const ClientDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text(
            'My Bookings',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          bottom: TabBar(
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
        ),
        body: TabBarView(
          children: [
            // Content for Upcoming tab
            SingleChildScrollView(
              child: Column(
                children: [
                  UpcomingBookingScreen(
                    button1: true,
                    button2: true,
                    onPressed1: () {},
                    onPressed2: () {},
                    button1title: 'Cancel',
                    button2title: 'Reschedule',
                  ),
                  UpcomingBookingScreen(
                    button1: true,
                    button2: true,
                    onPressed1: () {},
                    onPressed2: () {},
                    button1title: 'Cancel',
                    button2title: 'Reschedule',
                  ),
                  UpcomingBookingScreen(
                    button1: true,
                    button2: true,
                    onPressed1: () {},
                    onPressed2: () {},
                    button1title: 'Cancel',
                    button2title: 'Reschedule',
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
                    showbutton: true,
                  ),
                  CompletedBookingScreen(
                    showbutton: true,
                  ),
                  CompletedBookingScreen(
                    showbutton: true,
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
                    showbutton: true,
                  ),
                  CancelledBookingScreen(
                    showbutton: true,
                  ),
                  CancelledBookingScreen(
                    showbutton: true,
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
    );
  }
}
