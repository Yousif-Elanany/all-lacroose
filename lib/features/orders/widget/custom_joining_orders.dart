import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lacrosse/features/orders/data/manager/cubit/OrderStates.dart';
import 'package:lacrosse/features/orders/data/model/ordelModel.dart';

import '../../auth/data/manager/cubit/auth_cubit.dart';
import '../../auth/data/manager/cubit/auth_states.dart';
import '../data/manager/cubit/OrderCubite.dart';

class Joining_order extends StatefulWidget {
  final OrderModel orderModel;
  final bool is_player;
  Joining_order(this.orderModel,this.is_player);


  @override
  State<Joining_order> createState() => _Joining_orderState();
}

class _Joining_orderState extends State<Joining_order> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Container(
          height: 196,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color(0xfffffff),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Colors.grey.withOpacity(.2),
              width: 1,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 22,
                      backgroundColor: Colors.white,
                      backgroundImage: widget.orderModel.image.isNotEmpty
                          ? NetworkImage(widget.orderModel.image)
                          : AssetImage("assets/images/c2.png")
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      widget.orderModel.email,
                      overflow: TextOverflow.clip,
                      style: TextStyle(
                        //color: Color(0xff207954), //999999
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(

                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons
                                        .flag_outlined,
                                    size: 16,
                                    color: Colors.grey,),
                                  SizedBox(width: 5.0),
                                  Expanded(
                                    // لإعطاء النص مساحة داخل الـ Row
                                    child: Text(
                                      widget.orderModel.teamName,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey,
                                      ),
                                      maxLines: 1,
                                      overflow:
                                      TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  Icon(Icons.calendar_month_outlined,
                                      size: 16,
                                      color: Colors.grey),
                                  SizedBox(width: 5.0),
                                  Expanded(
                                    child: Text(
                                      widget.orderModel.birthDate,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey,
                                      ),
                                      maxLines: 1,
                                      overflow:
                                      TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.language,
                                      size: 16,
                                      color: Colors.grey),
                                  SizedBox(width: 8.0),
                                  Expanded(
                                    child: Text(
                                      widget.orderModel.nationalityName,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey,
                                      ),
                                      maxLines: 1,
                                      overflow:
                                      TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: [

                                  SizedBox(width: 4.0),
                                  Expanded(
                                    child: Text(
                                        " ",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey,
                                      ),
                                      maxLines: 1,
                                      overflow:
                                      TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    Row(children: [
                      Expanded(

                        child:  BlocBuilder<OrderCubit,OrderStates>(builder: (context,state){
                          if(state is ApproveOrderLoading)
                            return Container(
                              height: 44,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: Color(0xff207954),
                              ),
                              child: Center(
                                child: Text(
                                  "accept_order".tr(),
                                  style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
                                ),
                              ),
                            );
                          return      GestureDetector(
                            onTap:   () async{
                              await  context.read<OrderCubit>().approveOrder(email: widget.orderModel.email);
                              if (widget.is_player) {
                                context.read<OrderCubit>().fetchOrders(userType: 0);
                              } else {
                                context.read<OrderCubit>().fetchOrders(userType: 1);
                              }
                            },
                            child: Container(
                              height: 44,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: Color(0xff207954),
                              ),
                              child: Center(
                                child: Text(
                                  "accept_order".tr(),
                                  style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          );
                        }),


                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: BlocBuilder<OrderCubit,OrderStates>(builder: (context,state){
                          if(state is RejectOrderLoading)
                            return Container(
                              height: 44,
                              decoration: BoxDecoration(
                                border: Border.all(width: 1, color: Color(0xff207954)),
                                borderRadius: BorderRadius.circular(16),
                                color: Colors.white,
                              ),
                              child: Center(
                                child: Text(
                                  "reject_order".tr(),
                                  style: TextStyle(fontSize: 16, color: Color(0xff207954), fontWeight: FontWeight.bold),
                                ),
                              ),
                            );
                          return      GestureDetector(
                            onTap: () async{
                              await context.read<OrderCubit>().rejectOrder(email: widget.orderModel.email);
                              if (widget.is_player) {
                                context.read<OrderCubit>().fetchOrders(userType: 0);
                              } else {
                                context.read<OrderCubit>().fetchOrders(userType: 1);
                              }
                            },
                            child: Container(
                              height: 44,
                              decoration: BoxDecoration(
                                border: Border.all(width: 1, color: Color(0xff207954)),
                                borderRadius: BorderRadius.circular(16),
                                color: Colors.white,
                              ),
                              child: Center(
                                child: Text(
                                  "reject_order".tr(),
                                  style: TextStyle(fontSize: 16, color: Color(0xff207954), fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          );
                        }),


                      ),
                    ]),

                  ],
                )
              ],
            ),
          )),
    );
  }
}
