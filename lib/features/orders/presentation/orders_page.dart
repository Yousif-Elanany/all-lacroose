import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lacrosse/features/auth/data/manager/cubit/auth_cubit.dart';
import 'package:lacrosse/features/auth/data/manager/cubit/auth_states.dart';

import '../../../data/Local/sharedPref/sharedPref.dart';
import '../../home/presentation/player_page.dart';
import '../../home/presentation/trainersPage.dart';
import '../../layout/Tabs/BaseScreen.dart';
import '../../eventsPage/widgets/button_default.dart';
import '../../eventsPage/widgets/custom_drop_down.dart';
import '../data/manager/cubit/OrderCubite.dart';
import '../data/manager/cubit/OrderStates.dart';
import '../data/model/ordelModel.dart';
import '../widget/custom_joining_orders.dart';
import '../../eventsPage/widgets/textFeild_default.dart';
import '../../eventsPage/presentation/add_player_trainer.dart';

class Order_page extends StatefulWidget {
  @override
  State<Order_page> createState() => _Order_pageState();
}

class _Order_pageState extends State<Order_page> {
  bool is_players_order = true;
  bool is_trainer_order = false;
  List<OrderModel> plyersOrderlist = [];
  List<OrderModel> trainersOrderlist = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<OrderCubit>().fetchOrders(userType: 0);
    context.read<OrderCubit>().fetchOrders(userType: 1);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrderCubit, OrderStates>(
      listener: (context, state) {
        if (state is Fetch_PlayersOrderSuccess)
          plyersOrderlist = state.playerOrderData;
        if (state is Fetch_TrainerOrderSuccess)
          trainersOrderlist = state.trainerOrderData;
      },
      builder: (context, state) {
        return Scaffold(
            backgroundColor: Colors.white,
            body: Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.13,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          'assets/images/top bar.png'), // Replace with your asset path
                      fit: BoxFit.cover, // Adjust to control how the image fits
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * .08,
                      right: 16,
                      left: 16),
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            // GestureDetector(
                            //   child: Container(
                            //     padding: EdgeInsets.all(0),
                            //     child: Image(
                            //         width: 48,
                            //         height: 48,
                            //
                            //         // fit: BoxFit.cover,
                            //
                            //         image: AssetImage(
                            //           "assets/images/c1.png",
                            //         )),
                            //   ),
                            //   onTap: () {
                            //     Navigator.pop(context);
                            //   },
                            // ),
                            SizedBox(),
                            Text(
                              "orders".tr(),
                              style: TextStyle(
                                color: Color(0xff207954), //999999
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Spacer(),

                            GestureDetector(
                              onTap: () {
                                is_players_order
                                    ? navigateTo(context, PlayersScreen())
                                    : navigateTo(context, TrainersScreen());
                              },
                              child: Text(
                                is_players_order == true
                                    ? "show_players".tr()
                                    : "show_trainers".tr(),
                                style: TextStyle(
                                  color: Color(0xff207954), //999999
                                  fontSize: 18,
                                  // fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .03,
                      ),

                      // SingleChildScrollView(
                      //   scrollDirection: Axis.horizontal,
                      //   child:
                      //   Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //     children: [
                      //       GestureDetector(
                      //         onTap: () {
                      //           setState(() {
                      //             is_players_order = true;
                      //             is_trainer_order = false;
                      //           });
                      //           context.read<OrderCubit>().fetchOrders(userType: 0);
                      //         },
                      //         child: _select_Button("players_join_order".tr(), is_players_order),
                      //       ),
                      //       SizedBox(width: 5),
                      //       GestureDetector(
                      //         onTap: () {
                      //           setState(() {
                      //             is_players_order = false;
                      //             is_trainer_order = true;
                      //           });
                      //           context.read<OrderCubit>().fetchOrders(userType: 1);
                      //         },
                      //         child: _select_Button("trainers_join_order".tr(), is_trainer_order),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            // 👈 يجعل الزر الأول يأخذ نصف المساحة المتاحة
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  is_players_order = true;
                                  is_trainer_order = false;
                                });
                                context
                                    .read<OrderCubit>()
                                    .fetchOrders(userType: 0);
                              },
                              child: _select_Button(
                                  "players_join_order".tr(), is_players_order),
                            ),
                          ),
                          SizedBox(width: 5),
                          Expanded(
                            // 👈 يجعل الزر الثاني يأخذ نصف المساحة المتاحة
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  is_players_order = false;
                                  is_trainer_order = true;
                                });
                                context
                                    .read<OrderCubit>()
                                    .fetchOrders(userType: 1);
                              },
                              child: _select_Button(
                                  "trainers_join_order".tr(), is_trainer_order),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .02,
                      ),
                      Row(
                        children: [
                          Text(
                            is_players_order
                                ? "${plyersOrderlist.length}"
                                : "${trainersOrderlist.length}",
                            style: TextStyle(
                              color: Color(0xff207954), //999999
                              fontSize: 16,
                              // fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "new_orders".tr(),
                            style: TextStyle(
                              //color: Color(0xff207954), //999999
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .01,
                      ),
                      // if(state is Fetch_OrderLoading)
                      //   Expanded(
                      //     child: Center(child: CircularProgressIndicator(  color: Color(0xff207954),)),
                      //   ),
                      if (is_players_order && plyersOrderlist.isEmpty)
                        Container(
                          height: 450,
                          //  color: Colors.green,
                          child: Center(
                            child: Text(
                              "no_player_orders".tr(), // مفتاح الترجمة
                              style: TextStyle(
                                color: Color(0xff999999), //
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      if (is_trainer_order && trainersOrderlist.isEmpty)
                        Container(
                          height: 450,
                          //  color: Colors.green,
                          child: Center(
                            child: Text(
                              "no_trainer_orders".tr(), // مفتاح الترجمة
                              style: TextStyle(
                                color: Color(0xff999999), //
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      Expanded(
                          child: ListView.builder(
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              itemCount: is_players_order
                                  ? plyersOrderlist.length
                                  : trainersOrderlist.length,
                              itemBuilder: (context, index) {
                                if (is_players_order)
                                  return Joining_order(
                                      plyersOrderlist[index], is_players_order);
                                if (is_trainer_order)
                                  return Joining_order(trainersOrderlist[index],
                                      is_players_order);
                                return Container();
                              }))

                      //   return is_players_order?Joining_order(plyersOrderlist[index], is_players_order):
                      //     plyersOrderlist.length!=0?Joining_order(
                      //       plyersOrderlist[index], is_players_order):
                      //    Container();
                      // }))
                    ],
                  ),
                )
              ],
            ));
      },
    );
  }

  Widget _select_Button(String text, bool is_player) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: 12, vertical: 8), // تحسين الحشو
      height: 42.0,
      decoration: BoxDecoration(
        color: is_player
            ? const Color(0xffEBFAF3).withOpacity(.25)
            : const Color(0xffF0F4F5),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: is_player ? const Color(0xff488B71) : const Color(0xff9999),
          width: 1, // سماكة الحدود
        ),
      ),
      alignment: Alignment.center,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: Colors.black,
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
