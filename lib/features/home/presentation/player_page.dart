import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lacrosse/features/eventsPage/data/manager/cubit/manager_cubit.dart';
import 'package:lacrosse/features/eventsPage/data/manager/cubit/manager_states.dart';
import 'package:lacrosse/features/home/data/manager/cubit/home_cubit.dart';
import 'package:lacrosse/features/home/data/models/PlayerModel.dart';
import 'package:lacrosse/features/home/presentation/EditPlayerScreen.dart';

import '../../accountPage/presention/account_page_manager.dart';
import '../widgets/customPlayerWidget.dart';

class PlayersScreen extends StatefulWidget {
  @override
  _PlayersScreenState createState() => _PlayersScreenState();
}

class _PlayersScreenState extends State<PlayersScreen> {
  List<PlayerModel> allPlayers = [];

  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().fetchAllPlayerData(); // جلب البيانات
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
        if (state is PlayerDataSuccess) {
          allPlayers = state.playerData;
        }
      },
      builder: (context, state) {
        if (allPlayers.isNotEmpty) {
          return Stack(children: [
            Stack(children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.16,
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
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 45.0),
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
                              padding: const EdgeInsets.only(left: 0.0, top: 0),
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
                            "Players".tr(),
                            style: TextStyle(
                              color: Color(0xff185A3F),
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Icon(Icons.search, color: Color(0xff185A3F), size: 30),
                  ],
                ),
              ),
            ]),
            // محتوى الشاشة
            Container(
                padding: EdgeInsets.all(16),
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.13),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          "${allPlayers.length} ",
                          style: TextStyle(fontSize: 18, color: Colors.green),
                        ),
                        Text(
                          "player".tr(),
                          style: TextStyle(
                            //  color: Color(0xff185A3F),
                            fontSize: 16,
                            //  fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                        child: ListView.builder(
                            padding: const EdgeInsets.all(8.0),
                            itemCount: allPlayers.length,
                            itemBuilder: (context, index) {
                              final usermodel = allPlayers[index];
                              return Customplayerwidget(usermodel);
                            }))
                  ],
                ))
          ]);
        } else
          return Center(child: CircularProgressIndicator());
      },
    ));
  }
}
