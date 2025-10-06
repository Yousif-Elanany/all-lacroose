import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lacrosse/data/Local/sharedPref/sharedPref.dart';
import 'package:lacrosse/features/home/data/manager/cubit/home_cubit.dart';

import 'package:lacrosse/features/home/data/models/matchModel.dart';
import 'package:lacrosse/features/home/widgets/EditSheetScore.dart';

class MatchesScreen extends StatefulWidget {
  @override
  _MatchesScreenState createState() => _MatchesScreenState();
}

class _MatchesScreenState extends State<MatchesScreen> {
  List<MatchModel> allMatches = [];

  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().fetchAllmatches(); // جلب البيانات
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
          },
          builder: (context, state) {
            if (allMatches.isNotEmpty) {
              return Stack(children: [
                Stack(children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.14,
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                              'assets/images/top bar.png'), // Replace with your asset path
                          fit: BoxFit
                              .cover, // Adjust to control how the image fits
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
                        horizontal: 8.0, vertical: 58.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(left: 0.0, top: 0),
                                  child: Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.6),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(8),
                                      ),
                                    ),
                                    child: Icon(Icons.arrow_back_ios_outlined,
                                        color: Color(0xff185A3F), size: 20),
                                  ),
                                ),
                              ),
                              Text(
                                "Matches".tr(),
                                style: TextStyle(
                                  color: Color(0xff185A3F),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        //  Icon(Icons.search, color: Color(0xff185A3F), size: 30),
                      ],
                    ),
                  ),
                ]),
                Container(
                    padding: EdgeInsets.all(8),
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.16),
                    decoration: BoxDecoration(
                      // color:  Colors.grey.withOpacity(.9),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                    ),
                    child: Column(
                      children: [
                        Expanded(
                            child: ListView.builder(
                                padding: const EdgeInsets.all(0.0),
                                itemCount: allMatches.length,
                                itemBuilder: (context, index) {
                                  final MatchModel model = allMatches[index];
                                  return GestureDetector(
                                      onTap: () {
                                        CacheHelper.getData(key: "roles")  == "Admin" ?           showScoreInputSheet(context, model,
                                            context.read<HomeCubit>()) :print("not admin");
                                      },
                                      child: buildMatch(model));
                                }))
                      ],
                    ))
              ]);
            } else
              return Center(child: CircularProgressIndicator());
          },
        ));
  }

  Widget buildMatch(MatchModel model) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.22,
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
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
        border: Border.all(
          color: Colors.grey.withOpacity(.2),
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // ✅ الفريق الأول
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    model.firstTeamName,
                    style: const TextStyle(fontSize: 14),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis, // ✅ نقط عند زيادة الاسم
                  ),
                  const SizedBox(height: 6),
                  CircleAvatar(
                    radius: 35,
                    backgroundColor: Colors.transparent,
                    child: ClipOval(
                      child: model.firstTeamImage.isNotEmpty
                          ? Image.network(
                        model.firstTeamImage,
                        width: 70,
                        height: 70,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            "assets/images/c2.png",
                            width: 70,
                            height: 70,
                            fit: BoxFit.cover,
                          );
                        },
                      )
                          : Image.asset(
                        "assets/images/c2.png",
                        width: 70,
                        height: 70,
                        fit: BoxFit.cover,
                      ),
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
                        style: const TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      const SizedBox(width: 4),
                      const Icon(Icons.access_time_outlined,
                          size: 14, color: Colors.grey),
                    ],
                  )
                ],
              ),
            ),

            // ✅ نص VS في المنتصف
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
                  Text(
                    model.secondTeamName,
                    style: const TextStyle(fontSize: 14),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis, // ✅ نقط عند زيادة الاسم
                  ),
                  const SizedBox(height: 6),
                  CircleAvatar(
                    radius: 35,
                    backgroundColor: Colors.transparent,
                    child: ClipOval(
                      child: model.secondTeamImage.isNotEmpty
                          ? Image.network(
                        model.secondTeamImage,
                        width: 70,
                        height: 70,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            "assets/images/c2.png",
                            width: 70,
                            height: 70,
                            fit: BoxFit.cover,
                          );
                        },
                      )
                          : Image.asset(
                        "assets/images/c2.png",
                        width: 70,
                        height: 70,
                        fit: BoxFit.cover,
                      ),
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
                        style: const TextStyle(fontSize: 12, color: Colors.grey),
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
    );
  }

}
