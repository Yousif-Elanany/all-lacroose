import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/Local/sharedPref/sharedPref.dart';
import '../../orders/data/manager/cubit/OrderCubite.dart';
import '../data/manager/cubit/notificationStates.dart';
import '../data/manager/cubit/notificationcubit.dart';
import '../data/model/notificationModel.dart';

class NotificationPage_manager extends StatefulWidget {
  const NotificationPage_manager({super.key});

  @override
  State<NotificationPage_manager> createState() =>
      _NotificationPage_managerState();
}

class _NotificationPage_managerState extends State<NotificationPage_manager> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<NotififcationsCubit>().GetUserNotificationsWithUnReadCount();
  }


  List<NotificationModel> unReadList = [];
  List<NotificationModel> isReadList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: BlocConsumer<NotififcationsCubit, NotififcationsStates>(
          listener: (context, state) {
            if (state is GetAllNotificationSuccess) {
              final List<NotificationModel> allNotification =
                  state.notificationslist;
              unReadList.clear();
              isReadList.clear();
              allNotification.forEach((notify) {
                if (notify.isRead) {
                  isReadList.add(notify);
                } else
                  unReadList.add(notify);
              });
            }
          },
          builder: (context, state) {
            return Stack(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.15,
                  child: Container(
                    decoration: BoxDecoration(
                      image: const DecorationImage(
                        image: AssetImage(
                            'assets/images/top bar.png'), // مسار الصورة في الخلفية
                        fit: BoxFit.cover,
                      ),
                      gradient: LinearGradient(
                        colors: [Colors.green.shade900, Colors.green.shade100],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 56),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: (){
                          Navigator.of(context).pop();
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 0.0, top: 0),
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.6),
                              borderRadius: BorderRadius.all(
                                Radius.circular(8),
                              ),
                            ),
                            child: Icon(
                                Icons.arrow_back_ios_outlined,
                                color: Color(0xff185A3F),
                                size: 20),
                          ),
                        ),
                      ),
                      Text(
                        "notification".tr(),
                        style: const TextStyle(
                          color: Color(0xff185A3F),
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Spacer(),
                      InkWell(
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () async {
                                await context
                                    .read<NotififcationsCubit>()
                                    .markAllNotificationsAsReadAsync();
                                await context
                                    .read<NotififcationsCubit>()
                                    .GetUserNotificationsWithUnReadCount();
                              },
                              child: Text(
                                "as_read".tr(),
                                style: const TextStyle(
                                  color: Color(0xff207954),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        ),
                        onTap: () {
                          // تنفيذ عند الضغط على "تمت القراءة"
                        },
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.13,
                  ),
                  padding: const EdgeInsets.only(top: 20, right: 16, left: 16),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // قسم الإشعارات الجديدة
                        Row(
                          children: [
                            Text(
                              "${unReadList.length}",
                              style: const TextStyle(
                                color: Color(0xff207954),
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(width: 5),
                            Text(
                              'new_notify'.tr(),
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        ListView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: unReadList.length,
                          itemBuilder: (context, index) {
                            return buildNotificationItem(
                                notify: unReadList[index], context: context
                                // showActions: index == 1, // عرض أزرار فقط لإشعار معين
                                );
                          },
                        ),

                        // النص الأوسط
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Text(
                              "${isReadList.length}",
                              style: const TextStyle(
                                color: Color(0xff207954),
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(width: 5),
                            Text(
                              'old_notify'.tr(),
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),

                        const SizedBox(height: 8),
                        ListView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: isReadList.length,
                          itemBuilder: (context, index) {
                            return buildNotificationItem(
                                notify: isReadList[index], context: context

                                //   showActions: index == 1, // عرض أزرار فقط لإشعار معين
                                );
                          },
                        ),
                        // // قسم الإشعارات القديمة
                        // buildNotificationItem(
                        //   context: context,
                        //   title: "طلب انضمام جديد",
                        //   description: "قام اللاعب أيمن يوسف بطلب الانضمام",
                        //   time: "اليوم, 12:00 صباحًا",
                        //   status: "",
                        // ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ));
  }

  Widget buildNotificationItem({
    required NotificationModel notify,
    required BuildContext context,

    //  bool showActions = false,
    String? status,
  }) {

    return Stack(children: [
      GestureDetector(
        onTap: () async {
          await context
              .read<NotififcationsCubit>()
              .MarkNotificationAsReadByID(notificationId: notify.id);
          await context
              .read<NotififcationsCubit>()
              .GetUserNotificationsWithUnReadCount();
        },
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                blurRadius: 5,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    backgroundColor: Color(0xffEBFAF3),
                    child: Icon(
                      Icons.notifications_active,
                      color: Color(0xff207954),
                    ),
                    radius: 20,
                  ),
                  const SizedBox(width: 16),
                  // النصوص
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            print(notify.email);
                            print(notify.isActive);
                            await context
                                .read<NotififcationsCubit>()
                                .MarkNotificationAsReadByID(notificationId: notify.id);
                            await context
                                .read<NotififcationsCubit>()
                                .GetUserNotificationsWithUnReadCount();
                          },
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                              notify.title,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 5),
                              Text(
                                notify.body,
                                style: const TextStyle(fontSize: 14, height: 2),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),

                              Text(
                                getTimeFormate(date: notify.sendingOn),
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                ),
                              ),
                            ],),
                        ),


                        if (notify.isActive == 1 )
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(
                              "order_confirmed".tr(),
                              style: const TextStyle(
                                color: Colors.green,
                                fontSize: 14,
                               // fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
            // if (notify.isActive == null )
            //                     Padding(
            //                       padding: const EdgeInsets.only(top: 8),
            //                       child: Text(
            //                         "rejeected",
            //                         style: const TextStyle(
            //                           color: Colors.redAccent,
            //                           fontSize: 16,
            //                           fontWeight: FontWeight.bold,
            //                         ),
            //                       ),
            //                     ),
                        if (notify.isActive == 0 && (CacheHelper.getData(key: "roles")=="Admin"))
                          Padding(
                            padding: const EdgeInsets.only(top: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: ()async {
                                      print(notify.email);
                                      print(notify.isActive);


                                    await  context
                                          .read<OrderCubit>()
                                          .approveOrder(email: notify.email);
            await context
          .read<NotififcationsCubit>()
          .MarkNotificationAsReadByID(notificationId: notify.id);
          await  context
          .read<NotififcationsCubit>()
          .GetUserNotificationsWithUnReadCount();

                                    },
                                    child: Container(
                                      height: 38,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(8),
                                          color: Color(0xff207954)),
                                      child: Center(
                                        child: Text(
                                          "accept_order".tr(),
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () async {

                                      print(notify.email);
                                      print(notify.isActive);
                                     await  context
                                          .read<OrderCubit>()
                                          .rejectOrder(email: notify.email);
                                      await context
                                          .read<NotififcationsCubit>()
                                          .MarkNotificationAsReadByID(
                                              notificationId: notify.id);
                                     await  context
                                          .read<NotififcationsCubit>()
                                          .GetUserNotificationsWithUnReadCount();
                                    },
                                    child: Container(
                                      height: 38,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 1, color: Color(0xff207954)),
                                          borderRadius: BorderRadius.circular(8),
                                          color: Colors.white),
                                      child: Center(
                                        child: Text(
                                          "reject_order".tr(),
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Color(0xff207954),
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      if(!notify.isRead)
      Positioned(
        top: 25, //context.locale.languageCode == "en" ? 25 : 25,
        // تغيير قيمة top حسب اللغة
        left:
            16, //context.locale.languageCode == "en" ? 16 : 0, // تغيير قيمة left حسب اللغة

        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 0),
          child: GestureDetector(
            onTap: () async {
              await context
                  .read<NotififcationsCubit>()
                  .MarkNotificationAsReadByID(notificationId: notify.id);
             await context
                  .read<NotififcationsCubit>()
                  .GetUserNotificationsWithUnReadCount();
            },
            child: CircleAvatar(
              radius: 5,
              backgroundColor: notify.isRead ? Colors.white : Color(0xff207954),
            ),
          ),
        ),
      ),
    ]);
  }

  String getTimeFormate({DateTime? date}) {
    String inputDate = "2025-01-27T14:58:11.0145781";

    // تحويل النص إلى كائن DateTime
    // DateTime parsedDate = DateTime.parse(inputDate);

    // الحصول على التاريخ الحالي
    DateTime now = DateTime.now();

    // التحقق إذا كان التاريخ المدخل هو تاريخ اليوم
    bool isToday = date?.year == now.year &&
        date?.month == now.month &&
        date?.day == now.day;

    // تنسيق الوقت باللغة العربية (بصيغة صباحًا/مساءً)
    String formattedTime = DateFormat('hh:mm a', 'ar').format(date!);

    // إضافة كلمة "اليوم" إذا كان التاريخ هو تاريخ اليوم
    String finalOutput = isToday
        ? "اليوم, $formattedTime"
        : DateFormat('EEEE, hh:mm a', 'ar').format(date);
    return finalOutput;
    print(finalOutput);
  }
}
