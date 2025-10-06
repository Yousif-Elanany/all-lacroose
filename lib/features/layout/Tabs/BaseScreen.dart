import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lacrosse/data/Local/sharedPref/sharedPref.dart';
import 'package:lacrosse/features/eventsPage/presentation/add_club_page.dart';

import 'package:lacrosse/features/eventsPage/presentation/add_news_page.dart';

import '../../ActivitesPage/presentation/ActivitiesPage.dart';
import '../../ActivitesPage/presentation/visitorActivitiesPage.dart';
import '../../NewsPage/presentation/NewsPage.dart';
import '../../accountPage/data/manager/cubit/Account_State.dart';
import '../../accountPage/data/manager/cubit/Account_cubit.dart';
import '../../accountPage/presention/account_page_manager.dart';
import '../../eventsPage/presentation/AudaienceExperienceScheduale.dart';
import '../../eventsPage/presentation/add_event_Page.dart';
import '../../eventsPage/presentation/add_player_trainer.dart';
import '../../eventsPage/presentation/schedule_AnAudience_Experience.dart';
import '../../orders/presentation/orders_page.dart';
import '../../home/presentation/HomePage.dart';

import '../widgets/bottom_sheet_main.dart';

class Basescreen extends StatefulWidget {
  @override
  State<Basescreen> createState() => _BasescreenState();
}

class _BasescreenState extends State<Basescreen> {
  String roles = "Player";
  late final List<Widget> _pages;
  @override
  void initState() {
    super.initState();

    print("user Token ${CacheHelper.getData(key: "accessToken")}");
    roles = CacheHelper.getData(key: "roles") ?? "";
    _pages = [
      HomeScreen(),
      //
      roles == "Visitor" ? VisitorActivities() : ActivitiesPage(),
      if (roles == "Admin") Container(),
      if (roles == "Admin") Order_page(),
      if (roles != "Admin") NewsPage(),

      Accountpage_manager(),
    ];
  }

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  int _currentIndex = 0; // لتحديد الصفحة الحالية

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        elevation: 0,
        currentIndex: _currentIndex,
        selectedItemColor: Colors.green,
        unselectedItemColor: Color(0xff333333),
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
        onTap: (index) {
          if (index == 2 && roles == "Admin") {
            // Prevent navigation & Show Bottom Sheet
            showCustomBottomSheet(context);
          } else {
            // Update selected tab
            setState(() {
              _currentIndex = index;
              print(_currentIndex);
            });
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: (_currentIndex == 0)
                ? Image.asset("assets/images/home.png")
                : Image.asset("assets/images/homee.png"),
            label: 'home'.tr(),
          ),
          BottomNavigationBarItem(
            icon: (_currentIndex != 1)
                ? Image.asset("assets/images/acticte.png")
                : Image.asset("assets/images/bottom2.png"),
            label: 'activities'.tr(),
          ),
          if (roles == "Admin")
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(top: 8),
                child: SvgPicture.asset(
                  'assets/images/plus.svg',
                  height: 32,
                  width: 43,
                ),
              ),
              label: "",
            ),
          if (roles == "Admin")
            BottomNavigationBarItem(
              icon: (_currentIndex != 3)
                  ? Image.asset("assets/images/ggggg.png")
                  : Image.asset("assets/images/ggg.png"),
              label: "orders".tr(),
            ),
          if (roles != "Admin")
            BottomNavigationBarItem(
              icon: (_currentIndex == 2)
                  ? Image.asset("assets/images/news.png")
                  : Image.asset("assets/images/discover.png"),
              label: 'news'.tr(),
            ),
          BottomNavigationBarItem(
            icon: BlocBuilder<AccountCubit, AccountState>(
              builder: (context, state) {
                if (state is editUserProfileSuccess) {
                  return CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(
                      state.userPhoto,
                    ),
                  );
                }
                return CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(
                    CacheHelper.getData(key: "UserPhoto") ?? "",
                  ),

                  child: CacheHelper.getData(key: "UserPhoto") == null ||
                          CacheHelper.getData(key: "UserPhoto").isEmpty
                      ? Image.asset(
                          'assets/images/reg.png',
                          fit: BoxFit.cover,
                        ) // صورة افتراضية
                      : null, // لا يتم عرض child إذا كانت الصورة صالحة
                );
              },
            ),
            label: 'account'.tr(),
          ),
        ],
      ),
    );
  }

   showCustomBottomSheet(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true, // ✅ يتيح التحكم في الارتفاع
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return CustomBottomSheet(
          hight: 100,
          title: 'add'.tr(),
          items: [
            'add_event'.tr(),
            'add_player_trainer'.tr(),
            'add_news'.tr(),
            'add_club'.tr(),
            'add_public_trial_dates'.tr(),
          ],
          onItemTap: (index) {
            print("Item tapped: $index");

            Navigator.of(context).pop();
            //if(index==2){navigateTo(context, Add_club_page());}
            takeAction(index, context);
          },
        );
      },
    ).whenComplete(() {
      setState(() {
        _currentIndex = 0;
        setState(() {});
      });
    });
  }

  void takeAction(int index, BuildContext context) {
    switch (index) {
      case 0:
        navigateTo(context, Add_event());
        break;
      case 1:
        navigateTo(context, Add_player_trainer());
        break;
      case 2:
        navigateTo(context, Add_news_page());
        break;
      case 3:
        navigateTo(context, Add_club_page());
        break;
      case 4:
        navigateTo(context, Schedule_AnAudience_Experience());

        break;
      default:
        //  _currentIndex=0;
        setState(() {});
    }
  }

  void navigateTo(context, widget) =>
      Navigator.of(context, rootNavigator: true).push(
        MaterialPageRoute(
          builder: (context) => widget,
        ),
      );
  // void _showBottomSheet(BuildContext context) {
  //   showModalBottomSheet(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return Container(
  //         height: 375, // (MediaQuery.of(context).size.height * 0.4),
  //         decoration: BoxDecoration(
  //             boxShadow: [
  //               BoxShadow(
  //                 color: Colors.grey.withOpacity(0.2),
  //                 blurRadius: 6,
  //                 offset: Offset(0, 1),
  //               ),
  //             ],
  //             color: Color(0xffffffff),
  //             borderRadius: BorderRadius.only(
  //                 topLeft: Radius.circular(30), topRight: Radius.circular(30))),
  //         child: Stack(children: [
  //           Image(
  //             image: AssetImage(
  //               "assets/images/bt_sh.png",
  //             ),
  //             fit: BoxFit.cover,
  //           ),
  //           Padding(
  //             padding: const EdgeInsets.all(8.0),
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.center,
  //               children: [
  //                 Padding(
  //                   padding: EdgeInsets.all(16),
  //                   child: Text(
  //                     'add'.tr(),
  //                     style: TextStyle(
  //                      color: Color(0xff185A3F), //Color(0xff185A3F),
  //                       fontSize: 20,
  //                       fontWeight: FontWeight.bold,
  //                     ),
  //                   ),
  //                 ),
  //
  //                 buildItem("add_event".tr()),
  //                 buildItem("add_player_trainer".tr()),
  //                 buildItem("add_news".tr()),
  //                 buildItem("add_club".tr()),
  //
  //                 // Divider(
  //                 //
  //                 //   thickness: 3,
  //                 // ),
  //               ],
  //             ),
  //           ),
  //         ]),
  //       );
  //     },
  //   );
  // }
  //
  // Widget buildItem(String text) {
  //   return Container(
  //     margin: EdgeInsets.all(6),
  //     alignment: Alignment.center,
  //     height: 52,
  //     width: double.infinity,
  //     decoration: BoxDecoration(
  //       color: Color(0xffF2F2F2),
  //       borderRadius: BorderRadius.circular(16),
  //     ),
  //     child: Text(
  //       text.tr(),
  //       style: TextStyle(fontSize: 16),
  //     ),
  //   );
  // }
}
