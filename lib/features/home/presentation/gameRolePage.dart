



import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/manager/cubit/home_cubit.dart';
import '../data/models/gameReuleModel.dart';
import '../widgets/gameRoleDesign.dart';

class GameRolesPage extends StatefulWidget {

  GameRolesPage();
  @override
  State<GameRolesPage> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<GameRolesPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<HomeCubit>().fetchGameRuleData();
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: ()async{

          Navigator.of(context).pop();
          return true ;
        },
        child: Scaffold(
            backgroundColor: Colors.white,
            body:BlocBuilder<HomeCubit,HomeStates>(
                builder: (context,state){

                  if (state is GameRuleDataLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is GameRuleDataSuccess) {
                    final List<GameRuleModel> roleList = state.GameRuleData;
                    print(roleList[0].content);
                    print("roleList[0].content////////////");

                    return

                      Stack(
                        children: [
                          Stack(children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.14,
                              child: Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                        "assets/images/top bar.png"), // Replace with your asset path
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
                                  horizontal: 16.0, vertical: 45.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context);
                                    //  context.read<HomeCubit>().fetchGameRuleData();
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 15.0),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,

                                        children: [

                                          Padding(
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
                                          SizedBox(width: 10,),
                                          Text(
                                            'gameRole'.tr(),
                                            style: TextStyle(
                                              color: Color(0xff185A3F),
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(),

                                ],
                              ),
                            ),

                          ]),
                          Container(
                            margin: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.14),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30),
                              ),
                            ),
                            child:  ListView.builder(
                              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                              itemCount: roleList.length,
                              itemBuilder: (context, index) {
                                return GameRole_Item(
                                  question: roleList[index].header,
                                  answer: roleList[index].content,
                                );
                              },
                            ),
                          )
                        ],
                      );}else return Container();


                })

        )

    );
  }
}




