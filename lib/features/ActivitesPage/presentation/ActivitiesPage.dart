import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:lacrosse/features/ActivitesPage/data/models/InternalEvent.dart';
import '../../../data/Local/sharedPref/sharedPref.dart';
import '../../ActivitesPage/data/manager/cubit/activities_cubit.dart';
import '../../ActivitesPage/widget/CustomActivityWidget.dart';

class ActivitiesPage extends StatefulWidget {
  const ActivitiesPage({super.key});

  @override
  State<ActivitiesPage> createState() => _ActivitiesPageState();
}

class _ActivitiesPageState extends State<ActivitiesPage> {
  DateTime selectedDate = DateTime.now(); // التاريخ الحالي كبداية
  int selectedDay = DateTime.now().day; // اليوم الحالي
  List<int> daysInMonth = []; // قائمة الأيام في الشهر الحالي
  List<InternalEventModel> eventList = [];
  final ScrollController _scrollController = ScrollController();
  yearFormat() {
    final langCode = CacheHelper.getData(key: "lang");

    // تحديد الكود المناسب للغة
    String localeCode = 'ar'; // الافتراضي إنجليزي
    if (langCode == 1) {
      localeCode = 'ar';
    } else if (langCode == 2) {
      localeCode = 'en';
    }
    final now = DateTime.now();
    final formattedYear = DateFormat.y(localeCode).format(now);
    // جلب السنة الحالية بصيغة اللغة المختارة
  }

  @override
  void initState() {
    super.initState();

    _generateDaysInMonth(selectedDate);
    context
        .read<ActivitiesCubit>()
        .getInternalEventForCurrentUser(date: selectedDate);
  }

  // دالة لحساب عدد الأيام في الشهر
  void _generateDaysInMonth(DateTime date) {
    int totalDays = DateTime(date.year, date.month + 1, 0).day;

    setState(() {
      daysInMonth = List.generate(totalDays, (index) {
        DateTime dayDate = DateTime(date.year, date.month, index + 1);
        return dayDate.day; // مجرد رقم اليوم (1..30)
      });

      selectedDay = date.day;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ActivitiesCubit, ActivitiesState>(
          listener: (context, state) {
        if (state is InternalEventSuccess) {
          eventList = state.InternalEvent;
          print(eventList);
        }
      }, builder: (context, state) {
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
                        colors: [Colors.green.shade900, Colors.green.shade700],
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
                      Text(
                        "Activities_and_composition".tr(),
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
                                        .month), //  "يناير ".tr(),
                                style: TextStyle(
                                  color: Color(0xff185A3F),
                                  fontSize: 16,
                                ),
                              ),
                              // Text(
                              //   CacheHelper.getData(key: "lang") ==1?  DateFormat.y("ar").format(DateTime.now()):      DateFormat.y("en").format(DateTime.now()),
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
                            height: MediaQuery.of(context).size.height * 0.075,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              padding: EdgeInsets.all(0),
                              itemCount: daysInMonth.length,
                              controller: ScrollController(
                                initialScrollOffset: (index - 2) *
                                    MediaQuery.of(context).size.width *
                                    0.075, // تعديل القيمة لوضع العنصر في المنتصف
                              ),
                              itemBuilder: (context, index) {
                                final dayNumber = daysInMonth[index];
                                var isSelected = selectedDay == dayNumber;

                                return GestureDetector(
                                  onTap: () {
                                    setState(() async {
                                      setState(() {
                                        selectedDay = dayNumber;
                                        selectedDate = DateTime(
                                            selectedDate.year,
                                            selectedDate.month,
                                            dayNumber);
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
                                      //    print(formattedDate);

                                      await context
                                          .read<ActivitiesCubit>()
                                          .getInternalEventForCurrentUser(
                                              date: selectedDate);
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5, vertical: 0),
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
                            eventList.length.toString(),
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
                        return acticityWidget(eventList[index]);
                      },
                      childCount: eventList.length,
                      // عدد العناصر في القائمة
                    ),
                  ),
                ],
              ),
            ),
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

  String _getArabicMonthName(int month) {
    const months = [
      'يناير',
      'فبراير',
      'مارس',
      'إبريل',
      'مايو',
      'يونيو',
      'يوليو',
      'أغسطس',
      'سبتمبر',
      'أكتوبر',
      'نوفمبر',
      'ديسمبر'
    ];
    return months[month - 1];
  }

  String _getEnglishMonthName(int month) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    return months[month - 1];
  }

  // دالة للحصول على اسم اليوم بناءً على اليوم من الشهر
  String _getDayName(int day) {
    DateTime date = DateTime(selectedDate.year, selectedDate.month, day);
    return DateFormat.EEEE(context.locale.languageCode).format(date);
  }
}
