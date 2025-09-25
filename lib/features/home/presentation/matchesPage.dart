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
      height: MediaQuery.of(context).size.height * 0.2,
      // padding: EdgeInsets.all(10),
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
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
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(model.firstTeamName,
                    style: TextStyle(
                        //  fontWeight: FontWeight.bold
                        fontSize: 16)),
                // CircleAvatar(
                //   backgroundColor: Colors.white,
                //   radius: 15,
                //   child: ClipOval(
                //     child: Image.network(
                //       matchList[index].firstTeamImage,
                //       fit: BoxFit.cover, // لجعل الصورة تغطي الدائرة بشكل مناسب
                //       width: 30, // يجب أن يكون أكبر أو يساوي `2 * radius`
                //       height: 30, // يجب أن يكون أكبر أو يساوي `2 * radius`
                //     ),
                //   ),
                // ),
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.transparent,
                  child: ClipOval(
                    child: model.firstTeamImage.isNotEmpty
                        ? Image.network(
                      model.firstTeamImage,
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        // لو الرابط فشل، نعرض الصورة من assets
                        return Image.asset(
                          "assets/images/c2.png",
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        );
                      },
                    )
                        : Image.asset(
                      "assets/images/c2.png",
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                SizedBox(height: 8.0),
                Text(
                  model.totalFirstTeamGoals.toString(),
                  style: TextStyle(
                      // fontWeight: FontWeight.bold)
                      fontSize: 14),
                ),
                Row(
                  children: [
                    Text(DateFormat("a h:mm").format(model.appointment),
                        style: TextStyle(fontSize: 14, color: Colors.grey)),
                    Icon(
                      Icons.access_time_outlined,
                      size: 16,
                      color: Colors.grey,
                    )
                  ],
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(' VS',
                  style: TextStyle(fontSize: 16, color: Colors.grey)),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  model.secondTeamName,
                  style: TextStyle(
                      // fontWeight: FontWeight.bold)
                      fontSize: 16),
                ),
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.white,
                  child: ClipOval(
                    child: model.secondTeamImage.isNotEmpty
                        ? Image.network(
                      model.secondTeamImage,
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        // لو الرابط فشل، نعرض الصورة من assets
                        return Image.asset(
                          "assets/images/c2.png",
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        );
                      },
                    )
                        : Image.asset(
                      "assets/images/c2.png",
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                SizedBox(height: 8.0),
                Text(
                  model.totalSecondTeamGoals.toString(),
                  style: TextStyle(
                      // fontWeight: FontWeight.bold)
                      fontSize: 14),
                ),
                SizedBox(height: 8.0),
                Row(children: [
                  Text(DateFormat("MMM d").format(model.appointment),
                      style: TextStyle(fontSize: 14, color: Colors.grey)),
                  Icon(
                    Icons.calendar_month_outlined,
                    size: 16,
                    color: Colors.grey,
                  )
                ]),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
