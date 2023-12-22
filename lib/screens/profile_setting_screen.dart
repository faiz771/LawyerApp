import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:lawyerapp/auth_screens/login_screen.dart';
import 'package:lawyerapp/components/rounded_button.dart';

class ProfileSettingScreen extends StatefulWidget {
  const ProfileSettingScreen({super.key});

  @override
  State<ProfileSettingScreen> createState() => _ProfileSettingScreenState();
}

class _ProfileSettingScreenState extends State<ProfileSettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: Center(
        //     child: Text(
        //       'Profile',
        //       style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),
        //     ),
        //   ),
        // ),
        body: SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 50.h,
          ),
          Center(
            child: Text(
              'Profile',
              style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          Center(
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                CircleAvatar(
                  radius: 75,
                  backgroundColor: Colors.white,
                  backgroundImage: AssetImage(
                    'assets/images/onboard2.jpg',
                  ),
                ),
                Positioned(
                  bottom: 15.h,
                  // left: MediaQuery.of(context).size.height * 0.15,
                  child: Container(
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(6)),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                      )),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h),
            child: Text(
              'Joe Doe William',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            trailing: Icon(
              Icons.arrow_forward_ios_sharp,
              size: 20,
            ),
            title: Text(
              'Edit Profile',
              style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
            ),
            leading: Icon(
              Icons.edit_outlined,
              color: Color.fromRGBO(17, 25, 40, 1),
            ),
            onTap: () {},
          ),
          ListTile(
            trailing: Icon(
              Icons.arrow_forward_ios_sharp,
              size: 20,
            ),
            title: Text(
              'Favorite',
              style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
            ),
            leading: Icon(
              Icons.favorite_outline,
              color: Color.fromRGBO(17, 25, 40, 1),
            ),
            onTap: () {},
          ),
          ListTile(
            trailing: Icon(
              Icons.arrow_forward_ios_sharp,
              size: 20,
            ),
            title: Text(
              'Settings',
              style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
            ),
            leading: Icon(
              Icons.settings_outlined,
              color: Color.fromRGBO(17, 25, 40, 1),
            ),
            onTap: () {},
          ),
          ListTile(
            trailing: Icon(
              Icons.arrow_forward_ios_sharp,
              size: 20,
            ),
            title: Text(
              'Notifications',
              style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
            ),
            leading: Icon(
              Icons.notifications_outlined,
              color: Color.fromRGBO(17, 25, 40, 1),
            ),
            onTap: () {},
          ),
          ListTile(
            trailing: Icon(
              Icons.arrow_forward_ios_sharp,
              size: 20,
            ),
            title: Text(
              'Help and Support',
              style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
            ),
            leading: Icon(
              Icons.live_help_outlined,
              color: Color.fromRGBO(17, 25, 40, 1),
            ),
            onTap: () {},
          ),
          // ListTile(
          //   trailing: Icon(
          //     Icons.arrow_forward_ios_sharp,
          //     size: 20,
          //   ),
          //   title: Text(
          //     'Terms And Conditions',
          //     style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
          //   ),
          //   leading: Icon(
          //     Icons.policy_outlined,
          //     color: Color.fromRGBO(17, 25, 40, 1),
          //   ),
          //   onTap: () {},
          // ),
          ListTile(
            title: Text(
              'Logout',
              style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
            ),
            leading: Icon(
              Icons.logout_outlined,
              color: Color.fromRGBO(17, 25, 40, 1),
            ),
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return StatefulBuilder(
                        builder: (BuildContext context, StateSetter setState) {
                      return Container(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Logout',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 16),
                            Center(
                                child: Text('Are you sure you want to logout')),
                            SizedBox(height: 20),
                            // Row(
                            //   mainAxisSize: MainAxisSize.min,
                            //   children: [
                            // RoundedButton(
                            //   text: 'Cancel',
                            //   onPressed: () {},
                            // ),
                            RoundedButton(
                              text: 'Logout',
                              onPressed: () {
                                Get.offAll(LoginScreen());
                              },
                            )
                            //   ],
                            // )
                          ],
                        ),
                      );
                    });
                  });
            },
          )
        ],
      ),
    ));
  }
}
