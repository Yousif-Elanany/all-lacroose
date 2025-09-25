//
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
//
//
// import '../../../data/Local/sharedPref/sharedPref.dart';
//
// import '../../layout/Tabs/BaseScreen.dart';
// import '../widgets/button_default.dart';
// import '../widgets/textFeild_default.dart';
//
//
//
//
// class Add_Trainer extends StatefulWidget {
//   const Add_Trainer({super.key});
//
//   @override
//   State<Add_Trainer> createState() => _Add_TrainerState();
// }
//
//
//
// class _Add_TrainerState extends State<Add_Trainer> {
//   bool is_player = true;
//
//   bool selected_register =true; // القيمة المختارة
//   String selectedValue = 'Option 1';
//   final List<String> items = ['Option 1', 'Option 2', 'Option 3', 'Option 4'];
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Stack(
//           children: [
//             SizedBox(
//               height: MediaQuery.of(context).size.height * 0.14,
//               child: Container(
//                 decoration: BoxDecoration(
//                   image: DecorationImage(
//                     image: AssetImage(
//                         'assets/images/top bar.png'), // Replace with your asset path
//                     fit: BoxFit.cover, // Adjust to control how the image fits
//                   ),
//                   gradient: LinearGradient(
//                     colors: [Colors.white, Colors.white60],
//                     begin: Alignment.bottomCenter,
//                     end: Alignment.topCenter,
//                   ),
//                 ),
//               ),
//             ),
//             SingleChildScrollView(
//               padding: EdgeInsets.only(
//                 right: 16, // MediaQuery.of(context).size.width * 0.04,
//                 left: 16, //MediaQuery.of(context).size.width * 0.04,
//                 top: 48, //MediaQuery.of(context).size.height * 0.14
//               ),
//               child: Column(
//                 mainAxisSize: MainAxisSize.max,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//
//                   Row(children: [
//
//                     GestureDetector(
//
//
//                       child:  Container(
//                         padding: EdgeInsets.all(0),
//                         child: Image(
//
//                             width: 48,
//                             height: 48,
//
//                             // fit: BoxFit.cover,
//
//                             image: AssetImage("assets/images/c1.png",)
//                         ),
//                       ),
//                       onTap: (){
//
//                         Navigator.pop(context);
//                       },
//                     ),
//
//                     Text(
//                       "Add_Trainer_trainer".tr(),
//                       style: TextStyle(
//                         color: Color(0xff207954), //999999
//                         fontSize: 24,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     Spacer(),
//                     Text(
//                       "join_order".tr(),
//                       style: TextStyle(
//                         color: Color(0xff207954), //999999
//                         fontSize: 16,
//                         // fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ],),
//                   SizedBox(height:MediaQuery.of(context).size.height*.05 ,),
//
//                   Row(
//                     children: [
//                       Text(
//                         "step".tr(),
//                         style: TextStyle(
//                           ///  color: Color(0xff328361),
//                           fontSize: 16,
//                           // fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       Text(
//                         "2",
//                         style: TextStyle(
//                           color: Color(0xff207954), //999999
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       Text(
//                         "from".tr(),
//                         style: TextStyle(
//                           ///  color: Color(0xff328361),
//                           fontSize: 16,
//                           //fontWeight: FontWeight.bold,
//                         ),
//                       ),
//
//                     ],
//                   ),
//
//
//
//                   Stack(
//
//                     alignment:CacheHelper.getData(key: "lang") == "1"?Alignment.bottomLeft:Alignment.bottomRight,
//                     children: [
//                       Container(
//                         padding: EdgeInsets.only(top: 10,bottom: 10),
//                         height: 92,
//                         width: 82,
//
//                         child: CircleAvatar(
//                           backgroundColor: Colors.white,
//                           child: Image(
//                             image: AssetImage(
//                               "assets/images/reg.png",
//                             ),
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                       ),
//                       CircleAvatar(
//                         backgroundColor: Colors.white,
//                         radius: 19,
//                         child: Image.asset(
//                           "assets/images/upload1.png",
//
//                         ),
//
//                       )
//                     ],
//                   ),
//                   SizedBox(
//                     height: 24,
//                   ),
//
//
//
//
//
//
//                   DefaultFormField(
//                     label: "email".tr(),
//                     type: TextInputType.text,
//
//                   ),
//                   SizedBox(
//                     height: 20,
//                   ),
//
//
//                   DefaultFormField(
//                     label: "password".tr(),
//                     type: TextInputType.text,
//
//                   ),
//
//
//
//                   SizedBox(
//                     height: 20,
//                   ),
//                   DefaultFormField(
//                     label: "confirm_pass".tr(),
//                     type: TextInputType.text,
//                     //  hint: "رقم الجوال"
//                   ),
//
//                   SizedBox(
//                     height: MediaQuery.of(context).size.height*.37,
//                   ),
//                   GestureDetector(
//                       onTap: (){
//                         navigateTo(context, Basescreen());
//                       },
//                       child: Button_default( height: 56, title: "add_trainer".tr(), color: Color(0xff207954),)),
//
//                   SizedBox(
//                     height: 20,
//                   ),                ],
//               ),
//             )
//           ],
//         ));
//   }
//
//
// }
//
//
//
// void navigateTo(context, widget) => Navigator.push(
//   context,
//   MaterialPageRoute(
//     builder: (context) => widget,
//   ),
// );
//
//
//
