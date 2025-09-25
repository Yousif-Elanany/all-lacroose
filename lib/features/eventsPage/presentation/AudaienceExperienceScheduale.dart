import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:lacrosse/features/ActivitesPage/data/models/InternalEvent.dart';
import 'package:lacrosse/features/accountPage/presention/account_page_manager.dart';
import 'package:lacrosse/features/eventsPage/data/manager/cubit/manager_cubit.dart';
import 'package:lacrosse/features/eventsPage/presentation/schedule_AnAudience_Experience.dart';
import '../../../data/Local/sharedPref/sharedPref.dart';
import '../../ActivitesPage/data/manager/cubit/activities_cubit.dart';
import '../../ActivitesPage/widget/CustomActivityWidget.dart';
import '../data/manager/cubit/manager_states.dart';
import '../data/model/experienceModel.dart';
import '../widgets/CustomAudienceExperience.dart';
import '../widgets/bottom_sheet_main.dart';
import '../widgets/button_default.dart';


class AudienceExperienceSchedule extends StatefulWidget {
  const AudienceExperienceSchedule({super.key});

  @override
  State<AudienceExperienceSchedule> createState() => _AudienceExperienceScheduleState();
}

class _AudienceExperienceScheduleState extends State<AudienceExperienceSchedule> {
  DateTime selectedDate = DateTime.now(); // التاريخ الحالي كبداية
  int selectedDay = DateTime.now().day;
  //int selectedDay2 = DateTime.now().month; // اليوم الحالي
  List<int> daysInMonth = []; // قائمة الأيام في الشهر الحالي
  List<ExperiencesModel> ExprienceList = [];
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();



    _generateDaysInMonth(selectedDate);
    context
        .read<managerCubit>()
        .getExperiences(date: selectedDate);
  }

  // دالة لحساب عدد الأيام في الشهر
  void _generateDaysInMonth(DateTime date) {
    int totalDays =
        DateTime(date.year, date.month + 1, 0).day; // حساب عدد أيام الشهر
    setState(() {
      daysInMonth = List.generate(totalDays, (index) => index + 1);
      selectedDay = date.day; // تعيين اليوم الحالي
    });
  }

  // دالة للحصول على اسم اليوم بناءً على اليوم من الشهر
  String _getDayName(int day) {
    DateTime date = DateTime(selectedDate.year, selectedDate.month, day);
    return DateFormat.EEEE(context.locale.languageCode).format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<managerCubit, ManagerStates>(
        listener: (context, state) {
      if (state is GetExperienceSuccess) {
        ExprienceList = state.listModel;
        print(ExprienceList);
      }
      if (state is DeleteExperienceSuccess) {

        context
            .read<managerCubit>()
            .getExperiences(date: selectedDate);
      }

        },
        builder: (context, state) {


            return Stack(
              children: [
                // الخلفية
                Stack(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.15,
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 60.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if(CacheHelper.getData(key: "roles")=="Admin")
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
                          SizedBox(width:5,),

                          Text(
                            "Audience_Experience".tr(),
                            style: const TextStyle(
                              color: Color(0xff185A3F),
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Spacer(),
                          InkWell(
                              child: Row(
                                children: [
                                  Text(
                                    CacheHelper.getData(key: "lang") == 1
                                        ? _getArabicMonthName(DateTime.now().month)
                                        : _getEnglishMonthName(DateTime.now()
                                        .month),  // "يناير ".tr(),
                                    style: TextStyle(
                                      color: Color(0xff185A3F),
                                      fontSize: 16,
                                    ),
                                  ),
                                  // Text(
                                  //   " ٢٠٢٥",
                                  //   style: TextStyle(
                                  //     color: Colors.grey,
                                  //     fontSize: 16,
                                  //     // fontWeight: FontWeight.bold,
                                  //   ),
                                  // ),
                                ],
                              ),
                              onTap: () {}),
                        ],
                      ),
                    ),
                  ],
                ),

                // المحتوى مع Container
                Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.13),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: CustomScrollView(
                    slivers: [
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                              (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 5, right: 12, left: 12, top: 25),
                              child: SizedBox(
                                height:
                                MediaQuery.of(context).size.height * 0.075,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  padding: EdgeInsets.all(0),
                                  itemCount: daysInMonth.length,
                                  // controller: ScrollController(
                                  //   initialScrollOffset: (index - 2) *
                                  //       MediaQuery.of(context).size.width *
                                  //       0.075, // تعديل القيمة لوضع العنصر في المنتصف
                                  // ),
                                  itemBuilder: (context, index) {
                                    final dayNumber = daysInMonth[index];
                                    var isSelected = selectedDay == dayNumber;

                                    return GestureDetector(
                                      onTap: () async{


                                            selectedDay = dayNumber;
                                            selectedDate = DateTime(
                                                selectedDate.year,
                                                selectedDate.month,
                                                dayNumber);
setState(() {

});

                                          print(
                                              "selectedDate//////////////////////////////");
                                          // print(isSelected);
                                          // print(dayNumber);
                                          // print(selectedDay);
                                          print(selectedDate);
                                          // String formattedDate =
                                          //     DateFormat('yyyy-MM-dd HH:mm:ss')
                                          //         .format(selectedDate);

                                       await context
                                        .read<managerCubit>()
                                        .getExperiences(date: selectedDate);



                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5,vertical: 0),
                                        child: Container(
                                          //  margin: EdgeInsets.symmetric(horizontal: 8.0),
                                          width: 62,
                                          height: 42, // عرض العنصر
                                          decoration: BoxDecoration(
                                            color: isSelected
                                                ? Colors.orange.shade100
                                                : Colors.white,
                                            borderRadius:
                                            BorderRadius.circular(12.0),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black12,
                                                blurRadius: 2,
                                                offset: Offset(0, 2),
                                              ),
                                            ],
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                '$dayNumber',
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w700,
                                                  color: isSelected
                                                      ? Colors.orange
                                                      : Colors.black,
                                                ),
                                              ),
                                              //    SizedBox(height: 2),
                                              Flexible(
                                                child: Text(
                                                  _getDayName(dayNumber),
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                    overflow: TextOverflow.ellipsis,

                                                    fontSize: 12,
                                                    color: isSelected
                                                        ? Colors.orange
                                                        : Colors.grey,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            );
                          },
                          childCount: 1, // عدد العناصر في القائمة
                        ),
                      ),
                      // النص "الأنشطة القريبة"
                      SliverToBoxAdapter(
                        child: Padding(
                          padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                          child: Row(
                            children: [
                              Text(
                                ExprienceList.length.toString(),
                                style: TextStyle(
                                    color: Color(0xff2BA170), fontSize: 16),
                              ),
                              Text(
                                "event_today".tr(),
                                style: TextStyle(
                                    fontSize: 12, color: Color(0xff4D4D4D)),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // القائمة (الأنشطة)
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                              (BuildContext context, int index) {
                            return CustomAudienceExperience(ExprienceList[index]);
                          },
                          childCount: ExprienceList.length,
                          // عدد العناصر في القائمة
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 20,
                    left: 16,
                    right: 16,
                    child: GestureDetector(
                      onTap: (){
                        navigateTo(context, Schedule_AnAudience_Experience());
                      },
                      child: Button_default(

                                        height: 48,

                                        title: "adding_time".tr(),
                                        color: Color(0xff207954),
                                      ),
                    ))
              ],
            );
          }
        //   else if (state is InternalEventFailure) {
        //     return const Center(
        //       child: Text("حدث خطأ أثناء تحميل البيانات"),
        //     );
        //   }
        //
        //   // حالة افتراضية عند عدم تحميل البيانات أو الخطأ
        //   return const Center(
        //     child: Text("لا توجد بيانات"),
        //   );
        // },
      ),
    );
  }
  // void showCustomBottomSheet(BuildContext context) {
  //   showModalBottomSheet(
  //     context: context,
  //     backgroundColor: Colors.transparent,
  //     builder: (BuildContext context) {
  //       return CustomBottomSheet(
  //         hight: 500.0,
  //         title: 'Options'.tr(),
  //         items: [
  //
  //           'show_participators'.tr(),
  //           'delete_event'.tr(),
  //         ],
  //         onItemTap: (index) async {
  //           Navigator.pop(context);
  //           setState(() {});
  //           if (index == 0) {
  //
  //           }
  //           if (index == 1) {
  //
  //
  //           }
  //
  //         },
  //       );
  //     },
  //   );
  // }
  // String deleteStyle(){
  //   return
  // }
  // String _getDayName(DateTime date, BuildContext context) {
  //   return DateFormat.EEEE(context.locale.languageCode).format(date);
  // }

  String _getMonthName(DateTime date, BuildContext context) {
    return DateFormat.MMMM(context.locale.languageCode).format(date);
  }
  void _generateMonthDates() {
     List monthDates = [];
    DateTime firstDay = DateTime(selectedDate.year, selectedDate.month, 1);
    DateTime lastDay = DateTime(selectedDate.year, selectedDate.month + 1, 0);

    for (int i = 0; i < lastDay.day; i++) {
      monthDates.add(firstDay.add(Duration(days: i)));
    }
  }

  String _getArabicMonthName(int month) {
    const months = [
      'يناير', 'فبراير', 'مارس', 'إبريل', 'مايو', 'يونيو',
      'يوليو', 'أغسطس', 'سبتمبر', 'أكتوبر', 'نوفمبر', 'ديسمبر'
    ];
    return months[month - 1];
  }
  String _getEnglishMonthName(int month) {
    const months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return months[month - 1];
  }
  String _getArabicDayName(int weekday) {
    const days = ['الإثنين', 'الثلاثاء', 'الأربعاء', 'الخميس', 'الجمعة', 'السبت', 'الأحد'];
    return days[weekday - 1];
  }
  void navigateTo(context, widget) => Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
  );

}
