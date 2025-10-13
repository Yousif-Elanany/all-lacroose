import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:lacrosse/features/home/data/manager/cubit/home_cubit.dart';
import 'package:lacrosse/features/home/data/models/PlayerModel.dart';

import 'package:lacrosse/features/home/data/models/advertisementModel.dart';
import 'package:lacrosse/features/home/presentation/aboutUnionLacroose.dart';
import 'package:lacrosse/features/home/presentation/nearestClub.dart';
import 'package:lacrosse/features/home/presentation/playGroundDesign.dart';
import 'package:lacrosse/features/home/presentation/player_page.dart';
import 'package:lacrosse/features/home/presentation/trainersPage.dart';

import 'package:lacrosse/features/home/widgets/player_Design.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../data/Local/sharedPref/sharedPref.dart';


import '../../ActivitesPage/data/models/activityModel.dart';
import '../../notficationPage/presentation/notification_page_manager.dart';
import '../data/models/matchModel.dart';
import '../data/models/model_team.dart';
import '../widgets/TeamDesign.dart';
import '../widgets/matchDesign.dart';
import '../widgets/terms.dart';
import 'allEvents.dart';
import 'clubs_Page.dart';
import 'gameRolePage.dart';
import 'matchesPage.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //final _controller = PageController();
  CarouselSliderController _carouselController = CarouselSliderController();
  int _currentIndex = 0;
  late List<MatchModel> matchList = [];
  late List<PlayerModel> playerList = [];
  late List<PlayerModel> trainersList = [];
  late List<EventModel> eventsList = [];
  late List<teamModels> TeamList = [];
  late List<AdvertisementModel> AdvertisemenList = [];

  final List<Map<String, String>> items = [
    {
      "name": "Nearby stadium".tr(),
      "image":
          "assets/images/lacrosse 1@3x.png", // Replace with your asset path
    },
    {
      "name": "Rules of the game".tr(),
      "image": "assets/images/lacrosse 1.png", // Replace with your asset path
    },
    {
      "name": "Mor about us".tr(),
      "image": "assets/images/lacrosse 3.png", // Replace with your asset path
    },
    {
      "name": "All stadiums".tr(),
      "image":
          "assets/images/lacrosse 1@3x.png", // Replace with your asset path
    },
  ];
  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().fetchAdvertisement();
    context.read<HomeCubit>().fetchAlltEAMS();
    context.read<HomeCubit>().fetchAllPlayerData();
    context.read<HomeCubit>().fetchAllmatches();
    context.read<HomeCubit>().fetchAllTrainersData();
    context.read<HomeCubit>().getFutureEvents();

    print(CacheHelper.getData(key: "FcmToken"));
    print(CacheHelper.getData(key: "accessToken"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {
          if (state is AdvertisementDataSuccess) {
            AdvertisemenList = state.AdvertisementData;
          }
          if (state is TeamsDataSuccess) {
            TeamList = state.teamsData;
          }
          if (state is PlayerDataSuccess) {
            playerList = state.playerData;
          }
          if (state is MatchSuccess) {
            matchList = state.matchData;
          }
          if (state is TrainerDataSuccess) {
            trainersList = state.trainerData;
          }
          if (state is GetHomeEventsSuccess) {
            eventsList = state.listModel;
          }
        },
        builder: (context, state) {
          // if (playerList.isEmpty || matchList.isEmpty || TeamList.isEmpty) {
          //   return const Center(
          //     child: CircularProgressIndicator(),
          //   );
          // } else if (playerList.isNotEmpty &&
          //     matchList.isNotEmpty &&
          //     TeamList.isNotEmpty) {
          // final List<PlayerModel> PlayerList = state.playerData;
          // final List<MatchModel> mList = state.m;

          return Stack(
            children: [
              // الخلفية
              Stack(children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.24,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                            'assets/images/Screenshot_12.png'), // Replace with your asset path
                        fit: BoxFit
                            .cover, // Adjust to control how the image fits
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
                      horizontal: 16.0, vertical: 45.0),
                  child: Column(
                    children: [
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.white.withOpacity(0.1),
                            radius: 28,
                            child: Image(
                              image: AssetImage(
                                "assets/images/Vector.png",
                              ),
                              fit: BoxFit.contain,
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: Text(
                              'Saudi lacrosse Federation'.tr(),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          if (CacheHelper.getData(key: "roles") != "Visitor")
                            InkWell(
                              onTap: () {
                                navigateTo(context, NotificationPage_manager());
                              },
                              child: Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.3),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                  ),
                                  child: Center(
                                      child: Image.asset(
                                    "assets/images/notification.png",
                                    color: Colors.white,
                                  ))),
                            ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: Container(
                            height: 56,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.93),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      // Text(
                                      //   "3 ",
                                      //   style: TextStyle(
                                      //       color: Color(0xff185A3F),
                                      //       fontSize: 16,
                                      //   fontWeight: FontWeight.w500),
                                      //
                                      // ),
                                      Text(
                                        "Events on your schedule".tr(),
                                        style: TextStyle(
                                            color: Color(0xff333333),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 0,
                                  ),
                                  // GestureDetector(
                                  //   onTap: () {
                                  //     //      LatLng l= LatLng(24.7136, 46.6753);
                                  //     // openMapScreen(context);
                                  //     // navigateTo(context, MapScreen(onLocationSelected: (l ) {  },));
                                  //     //    navigateTo(context, VisitorActivities());
                                  //     // context.read<ActivitiesCubit>().getAllInternalEventsForNationalTeam();
                                  //     // navigateTo(context, LiveTrackingMap());
                                  //
                                  //     //   context.read<ActivitiesCubit>().approveOrRejectAttendenceRequestFromManager();
                                  //     //   context.read<ActivitiesCubit>().approveOrRejectAttendenceRequestFromManager();
                                  //     //  context.read<notififcationCubit>().MarkNotificationAsReadByID(notificationId: 27);
                                  //   },
                                  //   child: Container(
                                  //     width: 55,
                                  //     height: 35,
                                  //     child: Center(
                                  //       child: Text(
                                  //         "view",
                                  //         style: TextStyle(color: Colors.white),
                                  //       ).tr(),
                                  //     ),
                                  //     decoration: BoxDecoration(
                                  //       color: Color(0xff207954),
                                  //       borderRadius: BorderRadius.all(
                                  //           Radius.circular(20)),
                                  //     ),
                                  //   ),
                                  // )
                                ],
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
              ]),
              // محتوى الشاشة
              Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.22),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  children: [
                    // الجزء الثابت (الإعلانات + الأيقونات)
                    SizedBox(
                      height: 144,
                      width: double.infinity,
                      child: CarouselSlider.builder(
                        carouselController: _carouselController,
                        itemCount: AdvertisemenList.length,
                        itemBuilder: (context, index, realIndex) {
                          return AdvertisemenList.isEmpty
                              ? Center(
                                  child: CircularProgressIndicator(
                                      color: Colors.green),
                                )
                              : Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 10),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          AdvertisemenList[index].img),
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                );
                        },
                        options: CarouselOptions(
                          autoPlay: true,
                          reverse: true,
                          autoPlayInterval: Duration(seconds: 5),
                          enlargeCenterPage: false,
                          viewportFraction: 1.0,
                          onPageChanged: (index, reason) {
                            setState(() {
                              _currentIndex = index;
                            });
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: AnimatedSmoothIndicator(
                        activeIndex:
                            (_currentIndex.isFinite && !_currentIndex.isNaN)
                                ? _currentIndex.toInt()
                                : 0,
                        count: AdvertisemenList.isNotEmpty
                            ? AdvertisemenList.length
                            : 1,
                        effect: ExpandingDotsEffect(
                          activeDotColor: Colors.green,
                          dotColor: Colors.green.shade100,
                          dotHeight: 6,
                          dotWidth: 6,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.1,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          final item = items[index];
                          return Container(
                            width: MediaQuery.of(context).size.width /
                                items.length, // توزيع متساوي
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: GestureDetector(
                              onTap: () {
                                if (index == 1) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => GameRolesPage()),
                                  );
                                } else if (index == 2) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AboutUnionPage()),
                                  );
                                } else if (index == 0) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => NearestClub()),
                                  );
                                } else if (index == 3) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => PlayGroundPage()),
                                  );
                                }
                              },
                              child: IconItemWidget(
                                imagePath: item['image']!,
                                title: item['name']!,
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    SizedBox(
                      height: 25,
                    ),

                    /// الجزء المتحرك (المباريات + اللاعبين + الفرق)
                    Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              if (CacheHelper.getData(key: "roles") == "Admin")       if (eventsList.isNotEmpty) ...[
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 10),
                                  child: Row(
                                    children: [
                                      Text(
                                        'activities'.tr(),
                                        style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const Spacer(),
                                      GestureDetector(
                                        onTap: () {
                                          navigateTo(context, HomeActivities());
                                        },
                                        child: Text(
                                          'show_All'.tr(),
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xff207954),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 120,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: eventsList.length,
                                    itemBuilder: (context, index) {
                                      final item = eventsList[index];
                                      return Container(
                                        width: 110, // ✅ عرض مضغوط
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 12),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.15),
                                              blurRadius: 4,
                                              offset: const Offset(0, 2),
                                            ),
                                          ],
                                        ),
                                        child: Column(
                                          mainAxisSize: MainAxisSize
                                              .min, // ✅ يخلي الارتفاع على قد المحتوى
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.vertical(
                                                      top: Radius.circular(10)),
                                              child: Image.network(
                                                item.img,
                                                height: 85, // ✅ صورة مضبوطة
                                                width: double.infinity,
                                                fit: BoxFit.cover,
                                                errorBuilder: (context, error,
                                                        stackTrace) =>
                                                    const Icon(
                                                        Icons.broken_image,
                                                        size: 40,
                                                        color: Colors.grey),
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 4),
                                              child: Text(
                                                item.name,
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            const SizedBox(height: 6),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                )
                              ],
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 10),
                                child: Row(
                                  children: [
                                    Text(
                                      'Matches'.tr(),
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Spacer(),
                                    GestureDetector(
                                      onTap: () {
                                        navigateTo(context, MatchesScreen());
                                      },
                                      child: Text(
                                        'show_All'.tr(),
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xff207954)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // المباريات
                              if (matchList.isNotEmpty) ...[

                                SizedBox(
                                  height: MediaQuery.of(context).size.height * 0.14,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    physics: const BouncingScrollPhysics(),
                                    padding: const EdgeInsets.symmetric(horizontal: 8),
                                    itemCount: matchList.length,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        width: MediaQuery.of(context).size.width * 0.6, // ✅ عرض ثابت يمنع الزيادة
                                        margin: EdgeInsets.only(right: index == matchList.length - 1 ? 0 : 8),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(12),
                                          color: Colors.white,
                                        ),
                                        clipBehavior: Clip.hardEdge, // ✅ يمنع خروج المحتوى
                                        child: MatchWidget(
                                          matchList: matchList,
                                          index: index,
                                        ),
                                      );
                                    },
                                  ),
                                )

                              ],

                              // اللاعبين
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 8),
                                child: Row(
                                  children: [
                                    Text(
                                      'Players'.tr(),
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Spacer(),
                                    GestureDetector(
                                      onTap: () {
                                        navigateTo(context, PlayersScreen());
                                      },
                                      child: Text(
                                        "show_All".tr(),
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xff207954)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.11,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: playerList.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 8.0),
                                      decoration: BoxDecoration(
                                        color: Colors.grey.withOpacity(0.1),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      child: PlayerWidget(
                                          model: playerList[index]),
                                    );
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 8),
                                child: Row(
                                  children: [
                                    Text(
                                      'Trainers'.tr(),
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Spacer(),
                                    GestureDetector(
                                      onTap: () {
                                        navigateTo(context, TrainersScreen());
                                      },
                                      child: Text(
                                        "show_All".tr(),
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xff207954)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.11,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: trainersList.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 8.0),
                                      decoration: BoxDecoration(
                                        color: Colors.grey.withOpacity(0.1),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      child: PlayerWidget(
                                          model: trainersList[index]),
                                    );
                                  },
                                ),
                              ),

                              // الفرق
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 8),
                                child: Row(
                                  children: [
                                    Text(
                                      'Teams'.tr(),
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Spacer(),
                                    GestureDetector(
                                      onTap: () {
                                        navigateTo(context, ClubScreen());
                                      },
                                      child: Text(
                                        'show_All'.tr(),
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xff207954),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.11,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: TeamList.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      height: 60,
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 8.0),
                                      decoration: BoxDecoration(
                                        color: Colors.grey.withOpacity(0.1),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      child: Teamdesign(model: TeamList[index]),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          );
          // } else if (state is PlayerDataFailure) {
          //   return const Center(
          //     child: Text("حدث خطأ أثناء تحميل البيانات"),
          //   );
          // }
          // return const Center(
          //   child: Text("لا توجد بيانات"),
          // );
        },
      ),
    );
  }

  void navigateTo(context, widget) => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => widget,
        ),
      );
}
// void openMapScreen(BuildContext context) {
//   Navigator.push(
//     context,
//     MaterialPageRoute(
//       builder: (context) => MapScreen(
//         onLocationSelected: (LatLng location) {
//           print("Selected Location: ${location.latitude}, ${location.longitude}");
//           // يمكنك حفظ الإحداثيات هنا
//         },
//       ),
//     ),
//   );
// }
