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
                  UpcomingBookingScreen(),
                  UpcomingBookingScreen(),
                  UpcomingBookingScreen(),
                  SizedBox(
                    height: 10,
                  )
                ],
              ),
            ),

            SingleChildScrollView(
              child: Column(
                children: [
                  CompletedBookingScreen(),
                  CompletedBookingScreen(),
                  CompletedBookingScreen(),
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
                  CancelledBookingScreen(),
                  CancelledBookingScreen(),
                  CancelledBookingScreen(),
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
