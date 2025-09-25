
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lacrosse/features/accountPage/presention/account_page_manager.dart';

import '../../../data/Local/sharedPref/sharedPref.dart';
import '../../../test.dart';
import '../../eventsPage/data/manager/cubit/manager_cubit.dart';
import '../data/models/userAttendenceModel.dart';
import 'bottom_sheet_main.dart';

class AttendanceWidget extends StatefulWidget {
  final UserAttendenceModel userReq;
  final int eventId;


  // Constructor
  AttendanceWidget(this.userReq,this.eventId);

  @override
  State<AttendanceWidget> createState() => _AttendanceWidgetState();
}

class _AttendanceWidgetState extends State<AttendanceWidget> {
  var _absentReason = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Stack(
      children:[ Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                blurRadius: 5,
                offset: Offset(0, 2),
              ),
            ],
            border: Border.all(
              color: Colors.grey.withOpacity(.2),
              width: 1,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    // CircleAvatar(
                    //   radius: 22,
                    //   backgroundColor: Colors.white,
                    //   child: Image(
                    //     image:NetworkImage(widget.userReq.image),// AssetImage("assets/images/c2.png"),
                    //     fit: BoxFit.cover,
                    //   ),
                    // ),
                    CircleAvatar(
                      radius: 22,
                      backgroundColor: Colors.white,
                      child: ClipOval(
                        child: Image.network(
                          widget.userReq.image,
                          fit: BoxFit.cover,
                          width: 44, // نفس القطر (radius * 2)
                          height: 44, // نفس القطر (radius * 2)
                          errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                            return Center(
                              child: Image.asset(
                                'assets/images/reg.png',
                                height: 44, // نفس القطر
                                width: 44, // نفس القطر
                                fit: BoxFit.cover,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      widget.userReq.displayName ?? "غير معروف",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Spacer(),
                    if(widget.userReq.status!=null)
                    GestureDetector(
                      onTap: (){
                        // context.read<managerCubit>().approveOrRejectAttendenceRequestFromManager(
                        //     eventId:widget.eventId, status: true,userId:widget.userReq.id );
                        if(widget.userReq.status!=null){
                          showCustomBottomSheetChangeStatus(context,widget.userReq.status!);
                        }

                      },
                      child: Container(
                        height: 32,
                        width: 32,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              blurRadius: 5,
                              offset: Offset(0, 2),
                            ),
                          ],
                          border: Border.all(
                            color: Colors.grey.withOpacity(.2),
                            width: 1,
                          ),
                        ),
                        child: Icon(Icons.more_horiz_outlined,color: Colors.grey,),),
                    )

                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.flag_outlined, size: 16, color: Colors.grey),
                              SizedBox(width: 5),
                              Text("club_n".tr(), style: TextStyle(fontSize: 14, color: Colors.grey)),
                              Expanded(
                                child: Text(
                                  widget.userReq.teamName ?? "غير معروف",
                                  style: TextStyle(fontSize: 14, color: Colors.grey),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Icon(Icons.calendar_month_outlined, size: 16, color: Colors.grey),
                              SizedBox(width: 5),
                              Text("birth_date".tr(), style: TextStyle(fontSize: 14, color: Colors.grey)),
                              Expanded(
                                child: Text(
                                  widget.userReq.birthDate ?? "غير معروف",
                                  style: TextStyle(fontSize: 14, color: Colors.grey),
                                  overflow: TextOverflow.ellipsis,
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.language, size: 16, color: Colors.grey),
                              SizedBox(width: 8),
                              Text("nationality1".tr(), style: TextStyle(fontSize: 14, color: Colors.grey)),
                              Expanded(
                                child: Text(
                                  widget.userReq.nationalityName ?? "غير معروف",
                                  style: TextStyle(fontSize: 14, color: Colors.grey),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
              //  widget.player["nationality"]=="",
      
                Container(
                  child: widget.userReq.status == null ?
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: (){
                            context.read<managerCubit>().approveOrRejectAttendenceRequestFromManager(
                                eventId:widget.eventId, status: true,userId:widget.userReq.id ).then((e){
                              context.read<managerCubit>().allreguestsAboutEventByManager(
                                  EventId:widget.eventId, classification: 0 );
                            });
                          },
                          child: Container(
                            height: 44,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Color(0xff207954),
                            ),
                            child: Center(
                              child: Text(
                                "accept_attend".tr(),
                                style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: GestureDetector(
                          onTap: (){
                           showCustomBottomSheet1(context);


                          },
                          child: Container(
                            height: 44,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(width: 1, color:Color(0xff207954)),
                              color: Colors.white,
                            ),
                            child: Center(
                              child: Text(
                                "reject_attend".tr(),
                                style: TextStyle(fontSize: 16, color: Color(0xff207954), fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ):Container()
                ),
                widget.userReq.status == false ?
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          height: 34,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Color(0xffF53D6B).withOpacity(.08),
                          ),
                          child: Center(
                            child: Text(
                              "absent_confirmed".tr(), //background: #F53D6B14;
      
                              style: TextStyle(fontSize: 16, color: Color(0xffF53D6B), ),
                            ),
                          ),
                        ),
                        SizedBox(width: 20),
                       Spacer()
                      ],
                    ):Container(),
                widget.userReq.status == false ?
                SizedBox(height: 10):Container(),
                (widget.userReq.status == false &&  widget.userReq.absenceReason !=null) ?
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("${'Absent_Reason'.tr()} :", style: TextStyle(fontSize: 14, color: Colors.grey)),

                    SizedBox(width: 10,),
                    Flexible(child: Text(widget.userReq.absenceReason! , style: TextStyle(fontSize: 14, color: Colors.grey))),
                  ],
                ):Container(),
                Container(
                    child: widget.userReq.status== true ?
                    Row(
                      children: [
                        Container(
                          height: 34,
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Color(0xffEEFBF4),
                          ),
      
                    child: Center(
                            child: Text(
                              "attendance_confirmed".tr(), //background: #F53D6B14;
      
                              style: TextStyle(fontSize: 16, color: Color(0xff207954), ),
                            ),
                          ),
                        ),
      
                      ],
                    ):Container()
                ),
              ],
            ),
          ),
        ),
      ),


      ]
    );
  }

  void showCustomBottomSheet1(BuildContext context) {
    showModalBottomSheet(
    //  isScrollControlled: true,

      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return  Container(
          height: 470,
          width: double.infinity,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                blurRadius: 6,
                offset: Offset(0, 1),
              ),
            ],
            color: const Color(0xffffffff),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: Stack(
            children: [
               ClipRRect(
                 borderRadius: BorderRadius.horizontal(right: Radius.circular(30),left: Radius.circular(30) ),
                 child: Image(
                  image: AssetImage("assets/images/sheet.jpeg"),
                  fit: BoxFit.cover,
                               ),
               ),
              Padding(
                padding: EdgeInsets.only(
                  left: 16,
                  right: 16,
                  bottom: MediaQuery.of(context).viewInsets.bottom, // يجعل الـ Bottom Sheet يتحرك للأعلى مع الكيبورد
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 22),
                      CircleAvatar(
                        radius: 40,
                        child: Image.asset("assets/images/c2.png"),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        "reject_attend".tr(),
                        style: const TextStyle(
                          color: Color(0xff185A3F),
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "pleaseEnterAbsentReason".tr(), // ترجمة النص
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 21),
                      Container(
                        margin: const EdgeInsets.all(8),
                        padding: const EdgeInsets.all(10),
                        alignment: Alignment.center,
                  
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: const Color(0xffF6F8F8),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: TextFormField(
                          controller: _absentReason,
                          decoration: InputDecoration(
                            border: InputBorder.none, // Removes the underline
                            hintText: 'Absent_Reason'.tr(),
                            hintStyle: TextStyle(color: Colors.grey)
                          ),
                  
                  
                          maxLines: 5
                          ,
                  
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: (){
                                context.read<managerCubit>().approveOrRejectAttendenceRequestFromManager(
                                    eventId:widget.eventId, status: false,userId:widget.userReq.id ,absenceReason: _absentReason.text).then((e){
                                      Navigator.pop(context);
                                  context.read<managerCubit>().allreguestsAboutEventByManager(
                                      EventId:widget.eventId, classification: 0 );
                                });
                  
                              },
                              child: Container(
                                margin: const EdgeInsets.all(8),
                                alignment: Alignment.center,
                                height: 52,
                                decoration: BoxDecoration(
                                  color: const Color(0xff207954),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Text(
                                  "reject_attend".tr(),
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                      fontWeight: FontWeight.w500
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: GestureDetector(
                              onTap:(){
                                Navigator.pop(context);
                              },
                              child: Container(
                                margin: const EdgeInsets.all(8),
                                alignment: Alignment.center,
                                height: 52,
                                decoration: BoxDecoration(
                                  color: const Color(0xffF2F2F2),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Text(
                                  "cancel".tr(),
                                  style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          ),

                        ],
                      ),
                      SizedBox(height: 5),
                      Container(width: 80,height: 5,color: Colors.grey.shade300,)

                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
  void showCustomBottomSheetChangeStatus(BuildContext context,bool status,) {
    showModalBottomSheet(

      context: context,
      backgroundColor: Colors.white,
      builder: (BuildContext context) {
        return  Container(
          height: 358,

          width: double.infinity,
          decoration: BoxDecoration(
          //  color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                blurRadius: 6,
                offset: Offset(0, 1),
              ),
            ],
           //color: const Color(0xffffffff),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: Stack(
            children: [
              // Align(
              //   alignment: Alignment.center,
              //   child: Container(
              //     width: 80,  // حجم الدائرة
              //     height: 80,
              //     decoration: BoxDecoration(
              //       color: Colors.yellow, // لون الدائرة
              //       shape: BoxShape.circle,
              //     ),
              //     child: Padding(
              //       padding: const EdgeInsets.all(12.0), // المسافة بين الصورة وحدود الدائرة
              //       child: Image.asset(
              //         "assets/images/Warning icon.png",
              //         fit: BoxFit.contain,
              //       ),
              //     ),
              //   ),
              // ),

              // const Image(
              //   image: AssetImage("assets/images/bt_sh.png"),
              //   fit: BoxFit.cover,
              // ),

              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),

                    // الدائرة الصفراء مع أيقونة التحذير
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        width: 80,  // حجم الدائرة
                        height: 80,
                        decoration: BoxDecoration(
                          color: Colors.orangeAccent.withOpacity(0.8),    // لون الدائرة
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 4,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0), // المسافة بين الصورة وحدود الدائرة
                          child: Image.asset(
                            "assets/images/Warning icon.png",
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 40),

                    // النص الرئيسي
                    Text(
                      "changeAttendanceStates".tr(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Color(0xff185A3F),
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // النص الفرعي
                    Text(
                      "SureChangeAttendanceStates".tr(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),

                    const SizedBox(height: 30),

                    // أزرار الإجراء
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              context.read<managerCubit>().approveOrRejectAttendenceRequestFromManager(
                                  eventId: widget.eventId,
                                  status: !status,
                                  userId: widget.userReq.id
                              ).then((e) {
                                Navigator.pop(context);
                                context.read<managerCubit>().allreguestsAboutEventByManager(
                                    EventId: widget.eventId,
                                    classification: 0
                                );
                              });
                            },
                            child: Container(
                              height: 52,
                              alignment: Alignment.center,
                              margin: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: const Color(0xff207954),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Text(
                                "changeStats".tr(),
                                style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              height: 52,
                              alignment: Alignment.center,
                              margin: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: const Color(0xffF2F2F2),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Text(
                                "cancel".tr(),
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )

            ],
          ),
        );
      },
    );
  }
}
