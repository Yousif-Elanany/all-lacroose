// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:lacrosse/features/notficationPage/widgets/custom_notification.dart';
//
// import '../../../data/Local/sharedPref/sharedPref.dart';
//
// class NotificationPage extends StatefulWidget {
//   const NotificationPage({super.key});
//
//   @override
//   State<NotificationPage> createState() => _NotificationPageState();
// }
//
// class _NotificationPageState extends State<NotificationPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Stack(
//         children: [
//           // الخلفية
//           Stack(children: [
//             SizedBox(
//               height: MediaQuery.of(context).size.height * 0.15,
//               child: Container(
//                 decoration: BoxDecoration(
//                   image: DecorationImage(
//                     image: AssetImage(
//                         'assets/images/top bar.png'), // Replace with your asset path
//                     fit: BoxFit.cover, // Adjust to control how the image fits
//                   ),
//                   gradient: LinearGradient(
//                     colors: [Colors.green.shade900, Colors.green.shade100],
//                     begin: Alignment.topCenter,
//                     end: Alignment.bottomCenter,
//                   ),
//                 ),
//               ),
//             ),
//             Padding(
//               padding:
//                   const EdgeInsets.symmetric(horizontal: 16.0, vertical: 65),
//               child: Row(
//                 // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   GestureDetector(
//                     child: Container(
//                       padding: EdgeInsets.all(0),
//                       child: Image(
//                           width: 48,
//                           height: 48,
//
//                           // fit: BoxFit.cover,
//
//                           image: AssetImage(
//                             "assets/images/c1.png",
//                           )),
//                     ),
//                     onTap: () {
//                       Navigator.pop(context);
//                     },
//                   ),
//                   Text(
//                     "notification".tr(),
//                     style: TextStyle(
//                       color: Color(0xff185A3F),
//                       fontSize: 20,
//                       fontWeight: FontWeight.w700,
//                     ),
//                   ),
//                   Spacer(),
//                   InkWell(
//                       child: Row(
//                         children: [
//                           Text(
//                             "as_read".tr(),
//                             style: TextStyle(
//                               color: Color(0xff207954),
//                               fontSize: 12,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ],
//                       ),
//                       onTap: () {}),
//                 ],
//               ),
//             )
//           ]),
//           // محتوى الشاشة
//           Container(
//             margin: EdgeInsets.only(
//               top: MediaQuery.of(context).size.height * 0.13,
//             ),
//             padding: EdgeInsets.only(top: 20, right: 16, left: 16),
//             decoration: BoxDecoration(
//               color: Colors.white, //color: Color(0xff185A3F)
//               borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(20),
//                 topRight: Radius.circular(20),
//               ),
//             ),
//             child: SingleChildScrollView(
//               child: Column(
//                 mainAxisSize: MainAxisSize.max,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     children: [
//                       Text(
//                         "3",
//                         style: TextStyle(
//                           color: Color(0xff207954),
//                           fontSize: 16,
//                           // fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       SizedBox(
//                         width: 5,
//                       ),
//                       Text(
//                         'new_notify'.tr(),
//                         style: TextStyle(
//                           fontSize: 16,
//                           //fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ],
//                   ),
//
//                   // القائمة الأولى
//                   ListView.builder(
//                     padding: EdgeInsets.all(0),
//                     shrinkWrap: true, // تأخذ حجم المحتوى
//                     physics: NeverScrollableScrollPhysics(), // تعطيل التمرير
//                     itemCount: 2,
//                     itemBuilder: (context, index) {
//                       return CustomNotification();
//                     },
//                   ),
//
//                   // النص الأوسط
//                   SizedBox(height: 10),
//                   Text(
//                     'old_notify'.tr(),
//                     style: TextStyle(fontSize: 16),
//                   ),
//                   SizedBox(height: 8),
//     Container(
//     margin: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height*.01),
//     // width: MediaQuery.of(context).size.width * 0.4,
//     //height: 120, //MediaQuery.of(context).size.height * 0.2,
//
//     decoration: BoxDecoration(
//     color: Colors.white,
//     borderRadius: BorderRadius.circular(16.0),
//     boxShadow: [
//     BoxShadow(
//     color: Colors.grey.withOpacity(0.6),
//     blurRadius: 0.5,
//     // offset: Offset(2, 2),
//     ),
//     ],
//     ),
//     child: Padding(
//     padding: EdgeInsets.only(top: 16,bottom: 16),
//     child: Row(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//     Padding(
//     padding: const EdgeInsets.only(left: 16, right: 16),
//     child: CircleAvatar(
//     backgroundColor: Color(0xffEBFAF3),
//     child: Image.asset(
//     "assets/images/notify.png",
//     ),
//     radius: 26,
//     ),
//     ),
//     const Expanded(
//     child: Column(
//     mainAxisAlignment: MainAxisAlignment.start,
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//     Text(
//     "تمت اضافه تدريب جديد انشاطاتك",
//     style: TextStyle(
//     //  color: Color(0xff185A3F),
//     fontSize: 16,
//
//     //  overflow: TextOverflow.ellipsis,
//
//     fontWeight: FontWeight.bold,
//
//     ),
//     maxLines: 1,
//     overflow: TextOverflow.ellipsis,
//     ),
//     SizedBox(
//     height: 10,
//     ),
//     Text(
//     "قامت الاداره باضافتك الي قايمه الانشطه ",
//     style: TextStyle(
//     //  color: Color(0xff185A3F),
//     fontSize: 14,
//     ),
//     maxLines: 2,
//     overflow: TextOverflow.ellipsis,
//     ),
//     SizedBox(
//     height: 10,
//     ),
//     Text(
//     'اليوم. 12:00 صباحا',
//     style: TextStyle(
//     color: Colors.grey,
//     fontSize: 14,
//     // fontWeight: FontWeight.bold,
//     ),
//     ),
//     ],
//     ),
//     ),
//     Padding(
//     padding: EdgeInsets.symmetric(horizontal: 16),
//     child: CircleAvatar(
//     radius: 0,///
//     backgroundColor: Color(0xff207954),
//     ),
//     ),
//     ],
//     ),
//     ),
//     ),
//
//
//                   // القائمة الثانية
//                   // ListView.builder(
//                   //   padding: EdgeInsets.all(0),
//                   //   shrinkWrap: true, // تأخذ حجم المحتوى
//                   //  // physics: NeverScrollableScrollPhysics(), // تعطيل التمرير
//                   //   itemCount: 1,
//                   //   itemBuilder: (context, index) {
//                   //     return CustomNotification();
//                   //   },
//                   // ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
