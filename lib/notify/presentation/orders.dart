//
// import 'package:flutter/material.dart';
// import 'package:enhance_stepper/enhance_stepper.dart';
//
//
// class OrdersScreen extends StatefulWidget {
//   @override
//   _OrdersStepperScreenState createState() => _OrdersStepperScreenState();
// }
//
// class _OrdersStepperScreenState extends State<OrdersScreen> {
//   int _currentStep = 0;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('الطلبات', style: TextStyle(fontFamily: 'Arial')),
//       ),
//       body: EnhanceStepper(
//         currentStep: _currentStep,
//         type: StepperType.vertical, // نوع التخطيط: عمودي
//         onStepTapped: (step) {
//           setState(() {
//             _currentStep = step;
//           });
//         },
//         onStepContinue: () {
//           if (_currentStep < _steps().length - 1) {
//             setState(() {
//               _currentStep += 1;
//             });
//           }
//         },
//         onStepCancel: () {
//           if (_currentStep > 0) {
//             setState(() {
//               _currentStep -= 1;
//             });
//           }
//         },
//         steps: _steps(),
//         controlsBuilder: (context, details) {
//           return Row(
//             children: [
//               TextButton(
//                 onPressed: details.onStepContinue,
//                 child: Text('التالي'),
//               ),
//               TextButton(
//                 onPressed: details.onStepCancel,
//                 child: Text('السابق'),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
//
//   List<EnhanceStep> _steps() {
//     return [
//       EnhanceStep(
//         title: Text('قيد التنفيذ'),
//         subtitle: Text('طلبك يتم تحضيره الآن'),
//         content: _orderDetails(),
//         state: _currentStep == 0 ? StepState.editing : StepState.complete,
//         isActive: _currentStep == 0,
//       ),
//       EnhanceStep(
//         title: Text('في الطريق'),
//         subtitle: Text('طلبك في طريقه إليك'),
//         content: _orderDetails(),
//         state: _currentStep == 1 ? StepState.editing : StepState.complete,
//         isActive: _currentStep == 1,
//       ),
//       EnhanceStep(
//         title: Text('تم التسليم'),
//         subtitle: Text('تم تسليم الطلب'),
//         content: _orderDetails(),
//         state: _currentStep == 2 ? StepState.editing : StepState.complete,
//         isActive: _currentStep == 2,
//       ),
//     ];
//   }
//
//   Widget _orderDetails() {
//     return Row(
//       children: [
//         ClipRRect(
//           borderRadius: BorderRadius.circular(10),
//           child:  Image.asset(
//             "assets/images/photo.png", // رابط الصورة
//             width: 80,
//             height: 80,
//             fit: BoxFit.cover,
//           ),
//         ),
//         SizedBox(width: 10),
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     '1450 ر.س',
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.red,
//                     ),
//                   ),
//                   Text(
//                     '#12345',
//                     style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 5),
//               Text(
//                 'شركة الشحن: الرياض، حي الياسمين، طريق الملك سلمان.',
//                 style: TextStyle(fontSize: 12, color: Colors.grey[700]),
//               ),
//               SizedBox(height: 5),
//               Text(
//                 'الوجهة: جدة، حي الروضة، طريق الملك عبدالعزيز.',
//                 style: TextStyle(fontSize: 12, color: Colors.grey[700]),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
import 'package:flutter/material.dart';




class OrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            'الطلبات',
            style: TextStyle(fontSize: 24,),
          ),
          bottom: TabBar(
            indicatorColor:  Color(0xffEF600D),
            indicatorSize:TabBarIndicatorSize.label ,
            labelColor: Colors.black,
            unselectedLabelColor: Color(0xff6C6C89),
            dividerHeight: 0,
            labelStyle: TextStyle( fontSize: 16),
            tabs: [
              Tab(text: 'قيد التنفيذ'),
              Tab(text: 'تم التسليم'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            OrdersList(),
            OrdersList(), // يمكن تخصيصها لقسم "تم التسليم"
          ],
        ),
      ),
    );
  }
}

class OrdersList extends StatelessWidget {
  final List<Map<String, String>> orders = [
    {
      'price': '1450',
      'orderNumber': '#12345',
      'shippingCompany': 'شركة الشحن',
      'pickupAddress': 'الرياض، حي الياسمين، طريق الملك سلمان.',
      'deliveryAddress': 'جدة، حي الروضة، طريق الملك عبدالعزيز.',
      'imageUrl': 'https://via.placeholder.com/150', // استبدل بالرابط الصحيح
    },
    {
      'price': '1450',
      'orderNumber': '#12345',
      'shippingCompany': 'شركة الشحن',
      'pickupAddress': 'الرياض، حي الياسمين، طريق الملك سلمان.',
      'deliveryAddress': 'جدة، حي الروضة، طريق الملك عبدالعزيز.',
      'imageUrl': 'https://via.placeholder.com/150', // استبدل بالرابط الصحيح
    },
    {
      'price': '1450',
      'orderNumber': '#12345',
      'shippingCompany': 'شركة الشحن',
      'pickupAddress': 'الرياض، حي الياسمين، طريق الملك سلمان.',
      'deliveryAddress': 'جدة، حي الروضة، طريق الملك عبدالعزيز.',
      'imageUrl': 'https://via.placeholder.com/150', // استبدل بالرابط الصحيح
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final order = orders[index];
        return OrderItem(
          price: order['price']!,
          orderNumber: order['orderNumber']!,
          shippingCompany: order['shippingCompany']!,
          pickupAddress: order['pickupAddress']!,
          deliveryAddress: order['deliveryAddress']!,
          imageUrl: order['imageUrl']!,
        );
      },
    );
  }
}

class OrderItem extends StatelessWidget {
  final String price;
  final String orderNumber;
  final String shippingCompany;
  final String pickupAddress;
  final String deliveryAddress;
  final String imageUrl;

  const OrderItem({
    required this.price,
    required this.orderNumber,
    required this.shippingCompany,
    required this.pickupAddress,
    required this.deliveryAddress,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: Container(
        height: 120,
        //color: Colors.orange,
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Row(
            children: [
              // صورة الطلب
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  "assets/images/photo.png",
                  width:120,
                  height:120,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 10),
              // تفاصيل الطلب
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // رقم الطلب والسعر
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          orderNumber,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            // color: Colors.grey[700],
                          ),
                        ),
                        Spacer(),
                        Text(
                          price  ,
                          style: TextStyle(
                            fontSize: 16,
                            // fontWeight: FontWeight.bold,
                            color: Color(0xffEF600D),
                          ),
                        ),
                        Text(' ر.س', style: TextStyle(
                            fontSize: 12, color:Color(0xff6C6C89)),),

                      ],
                    ),
                    SizedBox(height: 10),
                    // اسم شركة الشحن
                    Container(
                      height: 76,
                      color: Colors.grey.shade100,
                      child: Row(children: [
                        Column(
                          mainAxisSize:MainAxisSize.min,
                          children: [
                            CircleAvatar(radius: 14,backgroundColor:Color(0xA9A9BC26).withOpacity(.15),child:Icon(Icons.local_shipping, size: 16, color: Colors.orange)),


                            Spacer(),
                            CircleAvatar(radius: 14,backgroundColor:Color(0xA9A9BC26).withOpacity(.15),child:Icon(Icons.location_on, size: 16, color: Colors.orange) ,



                            ),

                          ],

                        ),
                        SizedBox(width: 5),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [ Text(
                            shippingCompany,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),

                            // العنوان


                            Expanded(
                              child:
                              Text(
                                'م$deliveryAddress',
                                style: TextStyle(fontSize: 10, color: Color(0xff6C6C89)),
                                // maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            SizedBox(height: 10),
                     Text(
                        "المنزل",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),

                        // العنوان


                        Expanded(
                          child:
                          Text(
                            'م طريق الملك عبدالعزيز',
                            style: TextStyle(fontSize: 10, color: Color(0xff6C6C89)),
                            // maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                          ],
                        )


                      ],),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
