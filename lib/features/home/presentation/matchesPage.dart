import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lacrosse/data/Local/sharedPref/sharedPref.dart';
import 'package:lacrosse/features/home/data/manager/cubit/home_cubit.dart';
import 'package:lacrosse/features/home/data/models/matchModel.dart';
import 'package:lacrosse/features/home/data/models/model_team.dart';
import 'package:lacrosse/features/home/widgets/EditSheetScore.dart';

import '../widgets/addmatchSheet.dart';

class MatchesScreen extends StatefulWidget {
  @override
  _MatchesScreenState createState() => _MatchesScreenState();
}

class _MatchesScreenState extends State<MatchesScreen> {
  List<MatchModel> allMatches = [];
  List<teamModels> allTeams = [];

  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().fetchAllmatches();
    context.read<HomeCubit>().fetchAlltEAMS();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {
          if (state is MatchSuccess) {
            allMatches = state.matchData;
          }
          if(state is TeamsDataSuccess){
            allTeams = state.teamsData;
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              // ✅ الهيدر
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.14,
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
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 58),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Row(
                        children: [
                          Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.6),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(Icons.arrow_back_ios_outlined,
                                color: Color(0xff185A3F), size: 20),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            "Matches".tr(),
                            style: const TextStyle(
                              color: Color(0xff185A3F),
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    CacheHelper.getData(key: "roles") == "Admin"
                        ? IconButton(
                      icon: const Icon(Icons.add, color: Color(0xff185A3F)),
                      onPressed: () {
                        showMatchBottomSheet(context,model: allTeams);
                      },
                    )
                        : const SizedBox(),
                  ],
                ),
              ),

              // ✅ المحتوى الرئيسي
              Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.16),
                padding: const EdgeInsets.all(8),
                child: Builder(
                  builder: (_) {
                    if (state is MatchLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (allMatches.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/images/Fire.png", // 🔹 تقدر تحط أي صورة فاضية عندك
                              width: 60,
                              height: 60,
                              fit: BoxFit.contain,
                            ),
                            const SizedBox(height: 12),
                            Text(
                              "no_matches".tr(), // ترجمها في ملفات اللغة
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.grey,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    // ✅ لو في مباريات
                    return ListView.builder(
                      padding: const EdgeInsets.all(0),
                      itemCount: allMatches.length,
                      itemBuilder: (context, index) {
                        return buildMatch(allMatches[index]);
                      },
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void showDeleteDialog(BuildContext context, int teamId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("delete_match_title".tr()),
        content: Text("delete_match".tr()),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("cancel".tr()),
          ),
          BlocConsumer<HomeCubit, HomeStates>(
            listener: (context, state) {
              if (state is DeleteMatchSuccess) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("Gob_done_successfully".tr(),
                      style: const TextStyle(color: Colors.white)),
                  backgroundColor: Colors.green.shade600,
                ));
              } else if (state is DeleteMatchFailure) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("error".tr(),
                      style: const TextStyle(color: Colors.white)),
                  backgroundColor: Colors.red.shade600,
                ));
              }
            },
            builder: (context, state) {
              if (state is DeleteMatchLoading) {
                return const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: CircularProgressIndicator(),
                );
              }
              return TextButton(
                onPressed: () =>
                    context.read<HomeCubit>().deleteMatch(id: teamId),
                child: Text("delete".tr(),
                    style: const TextStyle(color: Colors.red)),
              );
            },
          ),
        ],
      ),
    );
  }


  Widget buildMatch( MatchModel model) {
    final bool isAdmin = CacheHelper.getData(key: "roles") == "Admin";

    return AspectRatio(
      aspectRatio: 2.0,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12),
        child: Stack(
          clipBehavior: Clip.none, // ✅ يسمح بخروج الأزرار برة حدود الكارت لو لزم
          children: [
            // ✅ الكارت الرئيسي
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
                border: Border.all(color: Colors.grey.withOpacity(.2), width: 1),
              ),
              // ✅ padding علشان نسيب مساحة فوق للأزرار
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 30, 16, 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // ✅ الفريق الأول
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Text(
                              model.firstTeamName,
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 14),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(height: 6),
                          CircleAvatar(
                            radius: 28,
                            backgroundColor: Colors.transparent,
                            child: ClipOval(
                              child: model.firstTeamImage.isNotEmpty
                                  ? Image.network(
                                model.firstTeamImage,
                                width: 55,
                                height: 55,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) =>
                                    Image.asset("assets/images/c2.png"),
                              )
                                  : Image.asset("assets/images/c2.png"),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            model.totalFirstTeamGoals.toString(),
                            style: const TextStyle(fontSize: 14),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                DateFormat("a h:mm").format(model.appointment),
                                style: const TextStyle(
                                    fontSize: 12, color: Colors.grey),
                              ),
                              const SizedBox(width: 4),
                              const Icon(Icons.access_time_outlined,
                                  size: 14, color: Colors.grey),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4),
                      child: Text(
                        'VS',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ),

                    // ✅ الفريق الثاني
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Text(
                              model.secondTeamName,
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 14),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(height: 6),
                          CircleAvatar(
                            radius: 28,
                            backgroundColor: Colors.transparent,
                            child: ClipOval(
                              child: model.secondTeamImage.isNotEmpty
                                  ? Image.network(
                                model.secondTeamImage,
                                width: 55,
                                height: 55,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) =>
                                    Image.asset("assets/images/c2.png"),
                              )
                                  : Image.asset("assets/images/c2.png"),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            model.totalSecondTeamGoals.toString(),
                            style: const TextStyle(fontSize: 14),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                DateFormat("MMM d").format(model.appointment),
                                style: const TextStyle(
                                    fontSize: 12, color: Colors.grey),
                              ),
                              const SizedBox(width: 4),
                              const Icon(Icons.calendar_month_outlined,
                                  size: 14, color: Colors.grey),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // ✅ زرار التعديل والحذف (للأدمن فقط)
            if (isAdmin)
              Positioned(
                top: -5, // 🔹 فوق الكارت بشوية
                left: 10,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => showDeleteDialog(context, model.id),
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.red.withOpacity(0.85),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child:
                        const Icon(Icons.delete, color: Colors.white, size: 18),
                      ),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () => showScoreInputSheet(
                          context, model, context.read<HomeCubit>()),
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.85),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child:
                        const Icon(Icons.edit, color: Colors.white, size: 18),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
