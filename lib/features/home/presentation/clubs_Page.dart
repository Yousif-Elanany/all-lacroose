import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lacrosse/features/eventsPage/data/manager/cubit/manager_cubit.dart';
import 'package:lacrosse/features/eventsPage/data/manager/cubit/manager_states.dart';
import 'package:lacrosse/features/home/data/manager/cubit/home_cubit.dart';
import 'package:lacrosse/features/home/data/models/PlayerModel.dart';
import 'package:lacrosse/features/home/widgets/editClubSheet.dart';

import '../data/models/model_team.dart';
import '../widgets/customPlayerWidget.dart';



class ClubScreen extends StatefulWidget {

  @override
  _ClubScreenState createState() => _ClubScreenState();
}

class _ClubScreenState extends State<ClubScreen> {

  List<teamModels> allClub=[];



  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().fetchAlltEAMS(
    ); // جلب البيانات
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        body: BlocConsumer<HomeCubit, HomeStates>(
          listener: (context, state) {
            if(state is TeamsDataSuccess){
              allClub=state.teamsData;
              // print("mmmmmmmmmmm");
              // print(allClub);

            }
          },
          builder: (context, state) {
            if  ( allClub.isNotEmpty){
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
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 45.0),
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
                              Text(
                                "Teams".tr(),
                                style: TextStyle(
                                  color: Color(0xff185A3F),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                    //   Icon(Icons.search, color: Color(0xff185A3F), size: 30),
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
                      
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(children: [
                          Text(
                            "${allClub.length} ",
                            style: TextStyle(fontSize: 18, color: Colors.green),
                          ),
                          Text(
                            "club1".tr(),
                            style: TextStyle(
                              //  color: Color(0xff185A3F),
                              fontSize: 16,
                              //  fontWeight: FontWeight.bold,
                            ),
                          ),

                        ],),

                        SizedBox(height: 16),
                        Expanded(
                          child: GridView.builder(
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4, // عدد الأعمدة
                              crossAxisSpacing: 10, // المسافة الأفقية بين العناصر
                              mainAxisSpacing: 10, // المسافة العمودية بين العناصر
                              childAspectRatio: 0.8, // النسبة بين العرض والارتفاع
                            ),
                            itemCount: allClub.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: (){
                                  showEditClubSheet(context, allClub[index]);
                                },
                                child: ClubItem(
                                  name: allClub[index].name!,
                                  image: allClub[index].img!,
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                )
              ]);
            }else return Center(child: CircularProgressIndicator());

          },
        ));
  }
}




class ClubItem extends StatelessWidget {
  final String name;
  final String image;

  ClubItem({required this.name, required this.image});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.network(
          fit: BoxFit.fill,
          image,
          height: 50,
          width: 50,
          errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
            // في حالة حدوث خطأ، هات صورة من assets
            return Center(child: Image.asset('assets/images/c1.png',height: 50,width: 50,));  // ضع اسم الصورة في assets
          },

        ),
        // Container(
        //   decoration: BoxDecoration(
        //     shape: BoxShape.circle,
        //     image: DecorationImage(
        //       image: AssetImage("assets/images/photo.png"),
        //       fit: BoxFit.cover,
        //     ),
        //   ),
        //   width: 70,
        //   height: 70,
        // ),
        SizedBox(height: 8),
        Text(
          name,
          style: TextStyle(fontSize: 14, color: Colors.black),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}