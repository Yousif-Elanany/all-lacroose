// import 'package:flutter/material.dart';
//
// class CustomNotification extends StatelessWidget {
//   const CustomNotification({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.symmetric(vertical: 8),
//       // width: MediaQuery.of(context).size.width * 0.4,
//       height: 132,//MediaQuery.of(context).size.height * 0.2,
//
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16.0),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.6),
//             blurRadius: 0.5,
//             // offset: Offset(2, 2),
//           ),
//         ],
//       ),
//       child: Padding(
//         padding:  EdgeInsets.all(16),
//
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//
//             Padding(
//               padding:
//               const EdgeInsets.only(left: 16, right: 16),
//               child: CircleAvatar(backgroundColor: Color(0xffEBFAF3),
//                 child: Image.asset("assets/images/notify.png",),
//                 radius: 26,
//               ),
//             ),
//             Expanded(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     "تمت اضافه تدريب جديد انشاطاتك",
//                     style: TextStyle(
//                       //  color: Color(0xff185A3F),
//                       fontSize: 16,
//
//
//                       fontWeight: FontWeight.bold,
//                     ),
//
//                   ),
//                   SizedBox(height: 5,),
//                   Text(
//                     "قامت الاداره باضافتك الي قايمه الانشطهhgh والتدريب"
//
//                     ,
//                     style: TextStyle(
//                       //  color: Color(0xff185A3F),
//                       fontSize: 14,
//                     ),
//
//                   ),
//                   SizedBox(height: 5,),
//                   Text(
//                     'اليوم. 12:00 صباحا',
//                     style: TextStyle(
//                       color: Colors.grey,
//                       fontSize: 14,
//                       // fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             CircleAvatar(
//               radius: 5,
//               backgroundColor: Color(0xff207954),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

class CustomNotification extends StatelessWidget {
  const CustomNotification({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height*.01),
      // width: MediaQuery.of(context).size.width * 0.4,
      //height: 120, //MediaQuery.of(context).size.height * 0.2,

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.6),
            blurRadius: 0.5,
            // offset: Offset(2, 2),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.only(top: 16,bottom: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: CircleAvatar(
                backgroundColor: Color(0xffEBFAF3),
                child: Image.asset(
                  "assets/images/notify.png",
                ),
                radius: 26,
              ),
            ),
            const Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "تمت اضافه تدريب جديد انشاطاتك",
                    style: TextStyle(
                      //  color: Color(0xff185A3F),
                      fontSize: 16,

                      //  overflow: TextOverflow.ellipsis,

                      fontWeight: FontWeight.bold,

                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "قامت الاداره باضافتك الي قايمه الانشطه ",
                    style: TextStyle(
                      //  color: Color(0xff185A3F),
                      fontSize: 14,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'اليوم. 12:00 صباحا',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                      // fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
padding: EdgeInsets.symmetric(horizontal: 16),
              child: CircleAvatar(
                radius: 5,///
                backgroundColor: Color(0xff207954),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
