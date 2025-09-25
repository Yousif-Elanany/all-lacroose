import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:lacrosse/features/ActivitesPage/data/models/InternalEvent.dart';

import '../../../data/Local/sharedPref/sharedPref.dart';

import '../data/manager/cubit/activities_cubit.dart';

import '../widget/customCarouselSlider.dart';
import '../widget/textFeild_default.dart';

import 'LoginattendencePage.dart';
import '../../auth/widgets/button_default.dart';

class activityDeatlScreen extends StatefulWidget {
  int eventID;

  activityDeatlScreen(this.eventID);

  @override
  State<activityDeatlScreen> createState() => _activityDeatlScreenState();
}

class _activityDeatlScreenState extends State<activityDeatlScreen> {
  String trimmedStartTime = "";
  String trimmedEndTime = "";
  DateTime parsedStartTime = DateTime.now();
  DateTime parsedEndTime = DateTime.now();
  String formattedStartTime = "";
  String formattedEndTime = "";
  String timeRange = "";
  String formattedStartDate = "";

  @override
  void initState() {
    super.initState();

    context.read<ActivitiesCubit>().getInternalEventDataById(widget.eventID);
  }

  InternalEventModel? event;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      //

      body: BlocConsumer<ActivitiesCubit, ActivitiesState>(
        listener: (context, state) {
          if (state is AddInternalEventReservationSuccess) {
            _showAwesomeDialog(context);
          }
          if (state is InternalEventByIdSuccess) {
            event = state.internalEventData;
          }
          if (state is AddInternalEventReservationFailure) {
            _showAwesomeErrorDialog(context, state.errorMessage);
          }
          if( state is DeleteInternalEventSuccess){
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          if (state is InternalEventByIdLoading) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.green),
            );
          } else {
            return Column(
              children: [
                Stack(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.13,
                      child: Container(
                        decoration: BoxDecoration(
                          image: const DecorationImage(
                            image: AssetImage('assets/images/top bar.png'),
                            fit: BoxFit.cover,
                          ),
                          gradient: LinearGradient(
                            colors: [
                              Colors.green.shade900,
                              Colors.green.shade700
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 16.0, right: 16.0, top: 57),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // زر العودة
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.6),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Icon(
                                Icons.arrow_back_ios_outlined,
                                color: Color(0xff185A3F),
                                size: 20,
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          // أيقونة الحذف


                          // عنوان الصفحة
                          Text(
                            "activitiesDetail".tr(),
                            style: const TextStyle(
                              color: Color(0xff185A3F),
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text("تأكيد الحذف"),
                                  content:
                                  Text("هل أنت متأكد من رغبتك في الحذف؟"),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(
                                            context); // إغلاق الديالوج
                                      },
                                      child: Text("رجوع"),
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                        Navigator.pop(
                                            context); // إغلاق الديالوج أولاً
                                        await context
                                            .read<ActivitiesCubit>()
                                            .deleteInternalEvent(
                                            widget.eventID);


                                        // هنا نادي الـ API الخاص بالحذف
                                      },
                                      child: Text("تأكيد"),
                                    ),
                                  ],
                                ),
                              );
                            },
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                color: Colors.red.withOpacity(0.6),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Icon(
                                Icons.delete_outline,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                // Expanded(
                //     flex: 2,
                //     child: Stack(
                //       children: [
                //         Container(
                //           width: double.infinity,
                //           decoration: BoxDecoration(),
                //           child: Container(
                //             height: MediaQuery.of(context).size.height*7,
                //             child:
                //             event!.internalEventFiles.isEmpty || event!.internalEventFiles ==null ?
                //             Image.asset("assets/images/photo.png")
                //                 :
                //
                //             Image.network(
                //               event!.internalEventFiles[0].file,
                //               // URL افتراضي عند عدم وجود صورة
                //               fit: BoxFit.fill,
                //               errorBuilder: (context, error, stackTrace) {
                //                 return Container(
                //                   height: MediaQuery.of(context).size.height*2,
                //
                //                   decoration: BoxDecoration(
                //
                //                     image: DecorationImage(image: AssetImage("assets/images/photo.png"),fit: BoxFit.cover),
                //                     borderRadius: BorderRadius.circular(16),
                //
                //                   )
                //
                //                   ,
                //
                //                 );
                //               },
                //             ),
                //           ),
                //         ),
                //         // Padding(
                //         //   padding: const EdgeInsets.symmetric(
                //         //       horizontal: 20.0, vertical: 30.0),
                //         //   child: Row(
                //         //     // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //         //     children: [
                //         //       GestureDetector(
                //         //         onTap: () {
                //         //           //  context.read<ActivitiesCubit>().getInternalEventForCurrentUser(date: DateTime.now());
                //         //           // BlocProvider.of<ActivitiesCubit>(context);
                //         //           Navigator.pop(context);
                //         //         },
                //         //         child: Row(
                //         //           children: [
                //         //             Padding(
                //         //               padding: CacheHelper.getData(key: "lang") ==1 ? const EdgeInsets.only(
                //         //                   left: 8.0, top: 8) : const EdgeInsets.only(
                //         //                   right: 8.0, top: 8) ,
                //         //               child: Container(
                //         //                 height: 40,
                //         //                 width: 40,
                //         //                 decoration: BoxDecoration(
                //         //                   color:
                //         //                   Colors.white.withOpacity(0.4),
                //         //                   borderRadius:
                //         //                   const BorderRadius.all(
                //         //                     Radius.circular(8),
                //         //                   ),
                //         //                 ),
                //         //                 child: CacheHelper.getData(key: "lang") ==1 ? Image.asset(
                //         //                   "assets/images/Vسهم.png",
                //         //                 ) :Icon(Icons.arrow_back_ios_new,color: Colors.white,),
                //         //               ),
                //         //             ),
                //         //             SizedBox(width: 5 ,),
                //         //             Text(
                //         //               "Back".tr(),
                //         //               style: TextStyle(
                //         //                 color: Color(0xffFFFFFF),
                //         //                 fontSize: 18,
                //         //                 fontWeight: FontWeight.bold,
                //         //               ),
                //         //             ),
                //         //           ],
                //         //         ),
                //         //       ),
                //         //       const SizedBox(),
                //         //     ],
                //         //   ),
                //         // )
                //       ],
                //     )
                // ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ( event!.internalEventFiles.isNotEmpty)
                    MediaCarousel(
                        mediaUrls: event!.internalEventFiles.isNotEmpty
                            ? event!.internalEventFiles
                                .where((model) {
                                  return model.file != null;
                                }) // التأكد أن `file` ليس `null`
                                .map((file) => file.file) // استخراج الروابط
                                .toList()
                            : [
                                // "http://app774.uat.toq.sa/LacrosseApi/Images/InternalEventImage/95463a4d-15ab-42a6-a927-e3d5fa8017c3.jpg"
                                "http://app774.uat.toq.sa/LacrosseApi/Images/InternalEventImage/f6ceb9a8-ce11-4689-a7ac-51586c2e3290.png"
                              ]),

                    Padding(
                      padding: const EdgeInsets.only(
                          left: 12, right: 12, top: 20, bottom: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            event!.eventName,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Icons.calendar_month_outlined,
                                            size: 16, color: Color(0xff207954)),
                                        SizedBox(width: 5.0),
                                        Expanded(
                                          // لإعطاء النص مساحة داخل الـ Row
                                          child: Text(
                                            DateFormat('yyyy-MM-dd')
                                                .format(event!.from),
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Color(0xff207954),
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 5),
                                    Row(
                                      children: [
                                        Icon(Icons.location_on_outlined,
                                            size: 16, color: Colors.grey),
                                        SizedBox(width: 5.0),
                                        Expanded(
                                          child: Text(
                                            event!.eventLocation.toString(),
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey,
                                            ),
                                            maxLines: 1,
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
                                        Icon(Icons.access_time,
                                            size: 16, color: Colors.grey),
                                        SizedBox(width: 8.0),
                                        Expanded(
                                          child: Text(
                                            "${DateFormat('hh:mm a').format(event!.to ?? DateTime.now())}_ ${DateFormat('hh:mm a').format(event!.from)}",
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 5),
                                    Row(
                                      children: [
                                        Icon(Icons.groups,
                                            size: 16, color: Colors.grey),
                                        SizedBox(width: 4.0),
                                        Expanded(
                                          child: Text(
                                            " ${event!.applicationUserInternalEvents.length}",
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey,
                                            ),
                                            maxLines: 2,
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
                        ],
                      ),
                    ),
                    Divider(
                      thickness: 0.5,
                      color: Colors.grey[100],
                    ),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(
                            event!.description.toString(),
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Spacer(),

                if (CacheHelper.getData(key: "roles") == "Admin")
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
//                       print("//////////////////////////////////////////");
// print(event!.internalEventFiles[0].file);
                        navigateTo(
                            context,
                            AttendanceScreen(
                              eventid: event!.id,
                            ));
                      },
                      child: Container(
                        width: double.infinity,
                        height: 40,
                        //width: 30,

                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color(0xff207954), // Green border color
                            width: 1.0, // Border width
                          ),
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),

                        child: Center(
                          child: Text(
                            "checkAttendance".tr(),
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xff207954),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                if (CacheHelper.getData(key: "roles") == "Visitor")
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        showCustomBottomSheet(context);
                      },
                      child: Container(
                        width: double.infinity,
                        height: 40,
                        //width: 30,

                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color(0xff207954), // Green border color
                            width: 1.0, // Border width
                          ),
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),

                        child: Center(
                          child: Text(
                            "ReserveSeat".tr(),
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xff207954),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                SizedBox(height: 20)
              ],
            );
          }
        },
      ),
    );
  }

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  var _nameController = TextEditingController();
  var _phoneController = TextEditingController();
  void showCustomBottomSheet2(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // ✅ يسمح بتفاعل أفضل مع لوحة المفاتيح
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AnimatedPadding(
              duration: Duration(milliseconds: 250), // ✅ يجعل الحركة سلسة
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context)
                    .viewInsets
                    .bottom, // ✅ يحرك الـ Bottom Sheet للأعلى مع الكيبورد
              ),
              child: Container(
                height: 350, // ✅ يظل ثابتًا حتى مع ظهور الكيبورد
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min, // ✅ يمنع التمدد الزائد
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 29),
                        Text(
                          "confirmReservation".tr(),
                          style: TextStyle(
                            color: Color(0xff207954),
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 22),
                        DefaultFormField(
                          label: "name".tr(),
                          controller: _nameController,
                          type: TextInputType.text,
                          validate: (value) {
                            if (value!.isEmpty) return 'Required'.tr();
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
                        DefaultFormField(
                          label: "phone_number".tr(),
                          controller: _phoneController,
                          type: TextInputType.phone,
                          validate: (value) {
                            if (value!.isEmpty) return 'Required'.tr();
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
                        GestureDetector(
                          onTap: () {
                            if (formKey.currentState!.validate()) {
                              context
                                  .read<ActivitiesCubit>()
                                  .addInternalEventReservation(
                                    internalEventId: widget.eventID,
                                    name: _nameController.text,
                                    phoneNumber: _phoneController.text,
                                  );
                              Navigator.pop(context);
                            }
                          },
                          child: Button_default(
                            height: 56,
                            title: "confirmReservation".tr(),
                            color: Color(0xff207954),
                            colortext: Colors.white,
                          ),
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  void showCustomBottomSheet(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AnimatedPadding(
              duration: Duration(
                  milliseconds: 250), // حركة سلسة عند تغيير حجم الإدخال
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Container(
                height: 370, // ✅ يظل ثابتًا ولا يتغير حجمه
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
                      borderRadius: BorderRadius.circular(30), // تحديد شكل القص
                      child: const Image(
                        image: AssetImage("assets/images/sheet.jpeg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                    Form(
                      key: formKey,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(height: 29),
                              Text(
                                "confirmReservation".tr(),
                                style: TextStyle(
                                  color: Color(0xff207954),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 15),
                              Row(
                                children: [
                                  Text(
                                    "aboutYou".tr(),
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 15),
                              SizedBox(height: 22),
                              DefaultFormField(
                                label: "name".tr(),
                                controller: _nameController,
                                type: TextInputType.text,
                                validate: (value) {
                                  if (value!.isEmpty) return 'Required'.tr();
                                  return null;
                                },
                              ),
                              SizedBox(height: 20),
                              DefaultFormField(
                                label: "phone_number".tr(),
                                controller: _phoneController,
                                type: TextInputType.phone,
                                validate: (value) {
                                  if (value!.isEmpty) return 'Required'.tr();
                                  return null;
                                },
                              ),
                              SizedBox(height: 20),
                              BlocBuilder<ActivitiesCubit, ActivitiesState>(
                                  builder: (context, state) {
                                if (state is AddExperienceReservationLoading)
                                  return Button_default(
                                    height: 56,
                                    title: "confirmReservation".tr(),
                                    color: Color(0xff207954),
                                    colortext: Colors.white,
                                  );
                                return GestureDetector(
                                  onTap: () {
                                    if (formKey.currentState!.validate()) {
                                      context
                                          .read<ActivitiesCubit>()
                                          .addInternalEventReservation(
                                            internalEventId: widget.eventID,
                                            name: _nameController.text,
                                            phoneNumber: _phoneController.text,
                                          );
                                      Navigator.pop(context);
                                      _nameController.clear();
                                      _phoneController.clear();
                                    }
                                  },
                                  child: Button_default(
                                    height: 56,
                                    title: "confirmReservation".tr(),
                                    color: Color(0xff207954),
                                    colortext: Colors.white,
                                  ),
                                );
                              }),
                              SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _showAwesomeDialog(BuildContext context) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.success, // success, error, warning, info
      animType: AnimType.leftSlide, // fade, leftSlide, rightSlide, scale
      title: 'success'.tr(),
      desc: 'Gob_done_successfully'.tr(),
      btnOkOnPress: () {},
    ).show();
  }

  void _showAwesomeErrorDialog(BuildContext context, text) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.error, // success, error, warning, info
      animType: AnimType.leftSlide, // fade, leftSlide, rightSlide, scale
      title: 'error'.tr(),
      desc: text.toString(),
      btnOkOnPress: () {},
    ).show();
  }
}

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );
