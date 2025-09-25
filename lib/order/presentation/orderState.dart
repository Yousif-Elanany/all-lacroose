import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:enhance_stepper/enhance_stepper.dart';
// class OrderDetailsScreen extends StatefulWidget {
//   @override
//   _OrderDetailsScreenState createState() => _OrderDetailsScreenState();
// }
//
// class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
//   int _currentStep = 1; // الخطوة الحالية
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('#12345', style: TextStyle(color: Colors.black)),
//         centerTitle: true,
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back, color: Colors.black),
//           onPressed: () {},
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Stepper لحالة الطلب
//             Stepper(
//               currentStep: _currentStep,
//               onStepTapped: (step) {
//                 setState(() {
//                   _currentStep = step;
//                 });
//               },
//               steps: [
//                 Step(
//                   title: Text("تم التحضير"),
//                   content: Text("طلبك جاهز وتم تحضيره."),
//                   isActive: _currentStep >= 0,
//                   state: _currentStep > 0 ? StepState.complete : StepState.indexed,
//                 ),
//                 Step(
//                   title: Text("تم التسليم للمندوب"),
//                   content: Text("سيصلك خلال 20 دقيقة."),
//                   isActive: _currentStep >= 1,
//                   state: _currentStep > 1 ? StepState.complete : StepState.indexed,
//                 ),
//                 Step(
//                   title: Text("تم التوصيل"),
//                   content: Text("تم توصيل الطلب إلى العنوان."),
//                   isActive: _currentStep >= 2,
//                   state: _currentStep == 2 ? StepState.complete : StepState.indexed,
//                 ),
//               ],
//             ),
//             SizedBox(height: 16),
//
//             // معلومات المندوب
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Row(
//                 children: [
//                   CircleAvatar(
//                     radius: 30,
//
//                     backgroundImage: AssetImage('assets/images/photo.png'),
//                   ),
//                   SizedBox(width: 16),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text("أبو بكر صبحي يوسف", style: TextStyle(fontSize: 16)),
//                       Text("123 أ ب", style: TextStyle(color: Colors.grey)),
//                       SizedBox(height: 8),
//                       Row(
//                         children: [
//                           Icon(Icons.phone, color: Colors.orange),
//                           SizedBox(width: 8),
//                           Text("اتصال", style: TextStyle(color: Colors.orange)),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//
//             // العنوان
//             ListTile(
//               leading: Icon(Icons.location_on, color: Colors.grey),
//               title: Text("جدة، حي الروضة، طريق الملك عبد العزيز"),
//             ),
//
//             // الفاتورة
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text("الفاتورة", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//                   SizedBox(height: 8),
//                   Container(
//                     padding: EdgeInsets.all(16),
//                     decoration: BoxDecoration(
//                       color: Colors.grey[200],
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     child: Column(
//                       children: [
//                         buildInvoiceRow("نعيمي صغير", "1x", "1450 ريال"),
//                         buildInvoiceRow("نعيمي صغير", "1x", "1450 ريال"),
//                         buildInvoiceRow("نعيمي صغير", "1x", "1450 ريال"),
//                         buildInvoiceRow("التوصيل", "", "50 ريال"),
//                         Divider(),
//                         buildInvoiceRow("الإجمالي", "", "4400 ريال", isTotal: true),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget buildInvoiceRow(String item, String quantity, String price, {bool isTotal = false}) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 4.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(item, style: TextStyle(fontSize: isTotal ? 16 : 14, fontWeight: isTotal ? FontWeight.bold : FontWeight.normal)),
//           Text(quantity, style: TextStyle(color: Colors.grey)),
//           Text(price, style: TextStyle(fontSize: isTotal ? 16 : 14, color: isTotal ? Colors.orange : Colors.black)),
//         ],
//       ),
//     );
//   }
// }
////


//////////////////////


class OrderDetailsScreen1 extends StatefulWidget {
  @override
  _OrdersStepperScreenState createState() => _OrdersStepperScreenState();
}

class _OrdersStepperScreenState extends State<OrderDetailsScreen1> {
  int _currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('#12345', style: TextStyle()),
      ),
      body:SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text("حاله الطلب", style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500)),
          ),
          EnhanceStepper(
            currentStep: _currentStep,
            type: StepperType.vertical, // نوع التخطيط: عمودي
            onStepTapped: (step) {
              setState(() {
                _currentStep = step;
              });
            },
            onStepContinue: () {
              if (_currentStep < _steps().length - 1) {
                setState(() {
                  _currentStep += 1;
                });
              }
            },
            onStepCancel: () {
              if (_currentStep > 0) {
                setState(() {
                  _currentStep -= 1;
                });
              }
            },
            steps: _steps(),
            controlsBuilder: (context, details) {
              return Container();
              //   Row(
              //   children: [
              //     TextButton(
              //       onPressed: details.onStepContinue,
              //       child: Text(''),
              //     ),
              //     TextButton(
              //       onPressed: details.onStepCancel,
              //       child: Text(''),
              //     ),
              //   ],
              // );
            },
          ),


          // الفاتورة
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("الفاتورة", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                SizedBox(height: 8),
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      buildInvoiceRow("نعيمي صغير", "1x", 1199),
                      buildInvoiceRow("نعيمي صغير", "1x", 1199),
                      buildInvoiceRow("نعيمي صغير", "1x", 1177),
                      buildInvoiceRow("التوصيل", "", 7777),
                      Divider(),
                      buildInvoiceRow("الإجمالي", "", 67844, isTotal: true),
                    ],
                  ),
                ),
              ],
            ),
          ),

        ],),
      )


    );
  }

  List<EnhanceStep> _steps() {
    return [
      EnhanceStep(
        title: Text("تم التحضير" ,style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400),),
        subtitle: Text(""),

        content: _orderDetails(),
        state: _currentStep == 0 ? StepState.editing : StepState.complete,
        isActive: _currentStep == 0,
      ),
      EnhanceStep(

        title: Row(children: [
          Text("تم التسليم للمندوب",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400)),
          Spacer(),
          Text("10-12-2025",style: TextStyle(fontSize: 10,fontWeight: FontWeight.w400,color: Color(0xff6C6C89))),
        ],),

        subtitle: Row(children: [
          Text("سيصلك خلال 20 دقيقة.",style: TextStyle(fontSize: 10,fontWeight: FontWeight.w400,color: Color(0xff6C6C89))),
    Spacer(),
    Text("pm 09:33 ",style: TextStyle(fontSize: 10,fontWeight: FontWeight.w400,color: Color(0xff6C6C89))),
    ],),
    content: _orderDetails(),
        state: _currentStep == 1 ? StepState.editing : StepState.complete,
        isActive: _currentStep == 1,
      ),
      EnhanceStep(
        title: Text("المنزل",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400)),
        subtitle: Text("جدة، حي الروضة، طريق الملك عبد العزيز",style: TextStyle(fontSize: 10,fontWeight: FontWeight.w400,color: Color(0xff6C6C89))),
       // icon: Icon(Icons.location_on, color: Colors.black),

        content: _orderDetails(),
        state: _currentStep == 2 ? StepState.editing : StepState.complete,
        isActive: _currentStep == 2,
      ),
    ];
  }

  Widget _orderDetails() {
    // return Row(
    //   children: [
    //     ClipRRect(
    //       borderRadius: BorderRadius.circular(10),
    //       child:  Image.asset(
    //         "assets/images/photo.png", // رابط الصورة
    //         width: 80,
    //         height: 80,
    //         fit: BoxFit.cover,
    //       ),
    //     ),
    //     SizedBox(width: 10),
    //     Expanded(
    //       child: Column(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: [
    //           Row(
    //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //             children: [
    //               Text(
    //                 '1450 ر.س',
    //                 style: TextStyle(
    //                   fontSize: 16,
    //                   fontWeight: FontWeight.bold,
    //                   color: Colors.red,
    //                 ),
    //               ),
    //               Text(
    //                 '#12345',
    //                 style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
    //               ),
    //             ],
    //           ),
    //           SizedBox(height: 5),
    //           Text(
    //             'شركة الشحن: الرياض، حي الياسمين، طريق الملك سلمان.',
    //             style: TextStyle(fontSize: 12, color: Colors.grey[700]),
    //           ),
    //           SizedBox(height: 5),
    //           Text(
    //             'الوجهة: جدة، حي الروضة، طريق الملك عبدالعزيز.',
    //             style: TextStyle(fontSize: 12, color: Colors.grey[700]),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ],
    // );
    return Container(
      
      padding: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.orange.shade100,
      ),
      height: 64,
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,

            backgroundImage: AssetImage('assets/images/photo.png'),
          ),
          SizedBox(width: 16),
          Column(
mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text("أبو بكر صبحي يوسف", style: TextStyle(fontSize: 14)),
              Text("123 أ ب", style: TextStyle(fontSize: 12,color: Colors.grey)),


            ],
          ),
          Spacer(),
          Icon(Icons.phone, color: Colors.orange)


        ],
      ),
    );
  }
  Widget buildInvoiceRow(String item, String quantity, int price, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
       // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(item, style: TextStyle(fontSize: isTotal ? 16 : 14, fontWeight: isTotal ? FontWeight.w500 : FontWeight.normal,color: isTotal?Colors.black: Color(0xff6C6C89))),
          SizedBox(width: 5,),
          Text(quantity, style: TextStyle(color: Color(0xff6C6C89))),
          Spacer(),
      Text(" $price  ", style: TextStyle(fontSize: isTotal ? 16 : 14, color: isTotal ? Colors.orange : Colors.black)),
      Text("ريال ", style: TextStyle(fontSize: isTotal ? 16 : 14, color: Colors.black)),

        ],
      ),
    );
  }
}