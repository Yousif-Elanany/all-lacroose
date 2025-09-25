import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:lacrosse/features/home/data/models/PlayerModel.dart';

import '../../home/widgets/customPlayerWidget.dart';
import '../data/manager/cubit/manager_cubit.dart';
import '../data/manager/cubit/manager_states.dart';
import '../data/model/reservationsNodel.dart';




class ParticipatorsPage extends StatefulWidget {
  final int id;

  ParticipatorsPage(this.id);

  @override
  _ParticipatoresPageState createState() => _ParticipatoresPageState();
}

class _ParticipatoresPageState extends State<ParticipatorsPage> {


  @override
  void initState() {
    super.initState();
    context.read<managerCubit>().getExperienceReservations(experienceId:widget.id );
   // ); // جلب البيانات
  }

  List<Reservation> listReservation=[];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocConsumer< managerCubit,ManagerStates>(
          listener: (context, state) {
            if(state is GetExperienceReservationsSuccess){
              listReservation=state.model.reservations;

            }
          },
          builder: (context, state) {

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
                              GestureDetector (
                                onTap: (){
                                  Navigator.pop(context);
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
                                "Participates".tr(),
                                style: TextStyle(
                                  color: Color(0xff185A3F),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Icon(Icons.search, color: Color(0xff185A3F), size: 30),
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
                        Row(children: [
                          Text(
                            "${listReservation.length} ",
                            style: TextStyle(fontSize: 18, color: Colors.green),
                          ),
                          Text(
                            "Participate".tr(),
                            style: TextStyle(
                              //  color: Color(0xff185A3F),
                              fontSize: 16,
                              //  fontWeight: FontWeight.bold,
                            ),
                          ),

                        ],),
                        Expanded(
                            child: ListView.builder(
                                padding: const EdgeInsets.all(0.0),
                                itemCount: listReservation.length,
                                itemBuilder: (context, index) {

                                  return ParticipantCard(
                                      name:  listReservation[index].name,
                                      phone:  listReservation[index].phoneNumber,);
                               // return Customplayerwidget(usermodel);
                                }))
                      ],
                    ))
              ]);
            }


        ));
  }
}




class ParticipantCard extends StatelessWidget {
  final String name;
  final String phone;

  const ParticipantCard({required this.name, required this.phone});
  @override
  Widget build(BuildContext context) {
    return Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: GestureDetector(
              onTap: (){


              },
              child: Container(

                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
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
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(


                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                          Image.asset("assets/images/part2.jpeg",),
                            // Container(
                            //   height: 25,
                            //   width: 8,
                            //   decoration: BoxDecoration(
                            //     color: Colors.white,
                            //     borderRadius: BorderRadius.circular(8),
                            //     boxShadow: [
                            //       BoxShadow(
                            //         color: Color(0xff185A3F),
                            //
                            //         offset: Offset(5, 0),
                            //       ),
                            //     ],
                            //
                            //   ),
                            // ),

                            SizedBox(width: 10),
                            Text(
                              name,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(

                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Image.asset("assets/images/part.jpeg",
                                  height: 18,width: 18,),
                                  SizedBox(width: 5),
                                  Text("phone_number".tr(), style: TextStyle(
                                      fontSize: 16, color: Colors.grey)),
                                  Text(" \u200E${phone}",

                                    style: TextStyle(
                                        fontSize: 16,    color: Colors.green.shade700),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),

                            ],
                          ),

                        ],
                      ),
                      const SizedBox(height: 12),

                    ],
                  ),
                ),
              ),
            ),
          ),


        ]
    );
  }


}

