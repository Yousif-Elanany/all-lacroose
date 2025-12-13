import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lacrosse/features/accountPage/presention/changPassword_page.dart';
import 'package:lacrosse/features/home/presentation/aboutUnionLacroose.dart';
import 'dart:ui';
import '../../../data/Local/sharedPref/sharedPref.dart';
import '../../NewsPage/presentation/NewsPage.dart';
import '../../auth/pressntation/registerPage1.dart';
import '../../auth/widgets/button_default.dart';
import '../../eventsPage/presentation/AudaienceExperienceScheduale.dart';
import '../data/manager/cubit/Account_State.dart';
import '../data/manager/cubit/Account_cubit.dart';
import 'editeAccountPage.dart';
import 'queastionsPage.dart';
import '../../auth/pressntation/loginPage.dart';
import '../widgets/BottomSheet.dart';
import '../widgets/custom_build acount.dart';

class Accountpage_manager extends StatefulWidget {
  @override
  State<Accountpage_manager> createState() => _Accountpage_managerState();
}

class _Accountpage_managerState extends State<Accountpage_manager> {
  GlobalKey<ScaffoldState> scaffoldkey = GlobalKey();
  String language = "en";
  String roles = CacheHelper.getData(key: "roles") ?? "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(CacheHelper.getData(key: "UserPhoto"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldkey,
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // الخلفية
          Stack(children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.15,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                        'assets/images/top bar.png'), // Replace with your asset path
                    fit: BoxFit.cover, // Adjust to control how the image fits
                  ),
                  gradient: LinearGradient(
                    colors: [Colors.green.shade900, Colors.green.shade700],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),
            CacheHelper.getData(key: "lang") == "1"
                ? Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 64.0),
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'account'.tr(),
                          style: TextStyle(
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
                                  'En ',
                                  style: TextStyle(
                                    //color: Color(0xff185A3F),
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                SizedBox(
                                    height: 30,
                                    width: 30,
                                    child:
                                        Image.asset("assets/images/usa.png")),
                              ],
                            ),
                            onTap: () {
                              scaffoldkey.currentState!.showBottomSheet(
                                  (context) => LangBottomSheet());
                            }),
                      ],
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 64.0),
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'account'.tr(),
                          style: TextStyle(
                            color: Color(0xff185A3F),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                        InkWell(
                            child: Row(
                              children: [
                                Text(
                                  'arabic'.tr(),
                                  style: TextStyle(
                                    //color: Color(0xff185A3F),
                                    fontSize: 16,
                                    //  fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                SizedBox(
                                    height: 40,
                                    width: 40,
                                    child:
                                        Image.asset("assets/images/saudi.png")),
                              ],
                            ),
                            onTap: () {
                              scaffoldkey.currentState!.showBottomSheet(
                                  (context) => LangBottomSheet());
                              // showCupertinoModalPopup(
                              //     context: context,
                              //     builder: (BuildContext context) =>
                              //         changeLanguage(context));
                            }),
                      ],
                    ),
                  ),
          ]),
          // محتوى الشاشة
          Container(
            margin:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.14),
            //padding:  EdgeInsets.all(MediaQuery.of(context).size.height * 0.20

            decoration: BoxDecoration(
              color: Colors.white, //color: Color(0xff185A3F)
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: roles == "Visitor"
                ? buildVisitor()
                : SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.01),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          BlocBuilder<AccountCubit, AccountState>(
                            builder: (context, state) {
                              if (state is editUserProfileSuccess) {
                                return Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Row(
                                    children: [
                                      // Padding(
                                      //   padding: const EdgeInsets.symmetric(vertical: 15),
                                      //   child: CircleAvatar(
                                      //     radius: 40,
                                      //
                                      //     backgroundImage: CacheHelper.getData(key: "UserPhoto") != null
                                      //         ? NetworkImage(CacheHelper.getData(key: "UserPhoto")!)
                                      //         : AssetImage("assets/images/reg.png") as ImageProvider, // ✅ الصورة الافتراضية
                                      //     // child: Image(
                                      //     //   image: AssetImage("assets/images/photo.png"),
                                      //     //  fit: BoxFit.cover,
                                      //   ),
                                      // ),

                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              CacheHelper.getData(
                                                  key: "UserName"),
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.005,
                                            ),
                                            Text(
                                              CacheHelper.getData(
                                                      key: "UserPhone")
                                                  .toString()
                                                  .replaceFirst('966+', ''),
                                              style: const TextStyle(
                                                color: Colors.black45,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.005,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                navigateTo(context,
                                                    Editeaccountpage());
                                              },
                                              child: Text(
                                                "chang account data".tr(),
                                                style: TextStyle(
                                                  color: Color(0xff185A3F),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              }
                              return Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 15),
                                      child: CircleAvatar(
                                        radius: 40,

                                        backgroundImage: CacheHelper.getData(
                                                    key: "UserPhoto") !=
                                                null
                                            ? NetworkImage(CacheHelper.getData(
                                                key: "UserPhoto")!)
                                            : AssetImage(
                                                    "assets/images/reg.png")
                                                as ImageProvider, // ✅ الصورة الافتراضية
                                        // child: Image(
                                        //   image: AssetImage("assets/images/photo.png"),
                                        //  fit: BoxFit.cover,
                                      ),
                                    ),

                                    //////

                                    ////
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            CacheHelper.getData(
                                                    key: "UserName") ??
                                                "name",
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.005,
                                          ),
                                          Text(
                                            CacheHelper.getData(
                                                    key: "UserPhone") ??
                                                "phone",
                                            style: TextStyle(
                                              color: Colors.black45,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.005,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              navigateTo(
                                                  context, Editeaccountpage());
                                            },
                                            child: Text(
                                              "chang account data".tr(),
                                              style: TextStyle(
                                                color: Color(0xff185A3F),
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
                          ),

                          SizedBox(
                            height: 5,
                          ),
                          // if (roles == "Admin")
                          //   AccountItemWidget(
                          //       text: "news".tr(), iconPath: "assets/images/22.png"),
                          //
                          // if (roles == "Admin")
                          //   AccountItemWidget(
                          //       text: "performance_report".tr(),
                          //       iconPath: "assets/images/44.png"),
                          // if (roles == "Admin")

                          if (roles == "Admin")
                            GestureDetector(
                              onTap: () {
                                // print (CacheHelper.getData(key: "UserName")??"name");
                                navigateTo(context, NewsPage());
                              },
                              child: AccountItemWidget(
                                text: "news".tr(),
                                iconPath: "assets/images/newsIcon.jpeg",
                                backgroundColor:
                                    Color(0xff7047EB).withOpacity(.1),
                              ),
                            ),
                          if (roles == "Admin")
                            GestureDetector(
                              onTap: () {
                                navigateTo(
                                    context, AudienceExperienceSchedule());
                              },
                              child: AccountItemWidget(
                                text: "expriencesTime".tr(),
                                iconPath: "assets/images/exp.jpeg",
                                backgroundColor:
                                    Color(0xff2BA170).withOpacity(.1),
                              ),
                            ),
                          GestureDetector(
                            onTap: () {
                              navigateTo(context, queastionsPage());
                            },
                            child: AccountItemWidget(
                              text: "Frequently question".tr(),
                              iconPath: "assets/images/q.png",
                              backgroundColor:
                                  Color(0xffF2994A).withOpacity(.1),
                            ),
                          ),

                          GestureDetector(
                            onTap: () {
                              navigateTo(context, ChangePasswordPage());
                            },
                            child: AccountItemWidget(
                              text: "Change password".tr(),
                              iconPath: "assets/images/33.png",
                              backgroundColor:
                                  Color(0xffF2994A).withOpacity(.1),
                            ),
                          ),

                          GestureDetector(
                            onTap: () {
                              navigateTo(context, AboutUnionPage());
                            },
                            child: AccountItemWidget(
                              text: "obout_app".tr(),
                              iconPath: "assets/images/About_app.png",
                              backgroundColor:
                                  Color(0xffcccccc).withOpacity(.1),
                            ),
                          ),
                          if (roles == "Player" || roles == "Trainer")
                            GestureDetector(
                              child: AccountItemWidget(
                                text: "Delete account".tr(),
                                iconPath: "assets/images/44.png",
                                backgroundColor:
                                    Color(0xffF294A).withOpacity(.01),
                              ),
                            ),

                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 25, vertical: 5),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.output_outlined,
                                  color: Colors.red,
                                  size: 18,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(builder: (context) {
                                      return LoginPage();
                                    }));
                                    CacheHelper.clearSharedPreferencesExcept(
                                        "FCMToken");
                                  },
                                  child: Text(
                                    'Sign out'.tr(),
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05,
                          )
                        ],
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Widget buildVisitor() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Don't have Account".tr(),
            style: TextStyle(
              color: Color(0xff999999), //
              fontSize: 20,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(
            height: 25,
          ),
          GestureDetector(
            onTap: () {
              navigateTo(context, LoginPage());
            },
            child: Button_default(
              height: 56,
              title: "Login".tr(),
              color: Color(0xff207954),
              colortext: Colors.white,
            ),
          ),
          SizedBox(
            height: 24,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "or".tr(),
                style: TextStyle(
                  color: Color(0xff999999), //999999
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 24,
          ),
          GestureDetector(
            child: Button_default(
              height: 56,
              title: "Sign_up".tr(),
              color: Color(0xff207954).withOpacity(0.08),
              colortext: Color(0xff207954),
            ),
            onTap: () {
              navigateAndFinish(context, Registerpage1());
            },
          )
        ],
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
