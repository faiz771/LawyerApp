// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:lightweight_calendar/global_utils.dart';
// import 'package:lightweight_calendar/lightweight_calendar_app.dart';

// class CalendarTemplate extends StatelessWidget {
//   const CalendarTemplate({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: 12.w),
//       child: Card(
//         child: CalendarApp(
//           startDate: DateTime(2022, 1, 1),
//           onSelectedDate: (date) {
//             print(date);
//           },
//           endDate: DateTime(2030, 1, 1),
//           enablePredicate: (date) {
//             if (date.isAfter(DateTime.now())) {
//               return true;
//             } else {
//               if (checkSameDay(date, DateTime.now())) {
//                 return true;
//               }
//               return false;
//             }
//           },
//         ),
//       ),
//     );
//   }
// }
