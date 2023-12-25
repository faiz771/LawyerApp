import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationTemplate extends StatelessWidget {
  NotificationTemplate({super.key, required this.image,required this.heading,required this.text});
  String image = '';
  String heading = '';
  String text = '';

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        child: Image.asset(image),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            heading,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            '1h',
            style: TextStyle(fontSize: 12.sp, color: Colors.grey),
          )
        ],
      ),
      subtitle: Text(
        text
          ),
    );
  }
}
