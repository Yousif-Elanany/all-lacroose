import 'package:flutter/material.dart';

import '../presentation/orderState.dart';

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
void navigateTo(context, widget) => Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => widget,
  ),
);