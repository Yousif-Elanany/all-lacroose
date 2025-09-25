import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lacrosse/features/eventsPage/data/manager/cubit/manager_cubit.dart';
import 'package:lacrosse/features/eventsPage/data/manager/cubit/manager_states.dart';

import '../../auth/widgets/button_default.dart';
import '../../orders/widget/custom_joining_orders.dart';

import '../data/models/userAttendenceModel.dart';
import '../widget/buil_attendace_widget.dart';

class AttendanceScreen extends StatefulWidget {
  int? eventid;
  AttendanceScreen({required this.eventid});
  @override
  _AttendanceScreenState createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  // Define the selected filter
  String selectedFilter = "all";
  List<UserAttendenceModel> allUserRequests=[];



  @override
  void initState() {
    super.initState();
    context.read<managerCubit>().allreguestsAboutEventByManager(
        EventId: widget.eventid!, classification: 0); // جلب البيانات
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocConsumer<managerCubit, ManagerStates>(
      listener: (context, state) {
        if(state is getAttendenceRequestsSuccess){
          allUserRequests =state.userRequests;
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
                          "checkAttendance".tr(),
                          style: TextStyle(
                            color: Color(0xff185A3F),
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 10,),
                  Icon(Icons.search, color: Color(0xff185A3F), size: 30),
                ],
              ),
            ),
          ]),
          // محتوى الشاشة
          Container(
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
                  // App Bar Row

                  // Filter Chips Row
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                       // mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          // All Chip
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: ChoiceChip(
                              label: Text(
                                "all".tr(),
                                style: TextStyle(
                                  fontSize: 14, // Smaller font size
                                  color: Colors.black, // Always black text
                                ),
                              ),
                              padding: EdgeInsets.zero, // Smaller padding
                              selected: selectedFilter == "all",
                              backgroundColor: Colors
                                  .grey.shade200, // Default background color
                              selectedColor: Colors.grey
                                  .shade200, // Keeps background grey when selected
                              side: BorderSide(
                                color: selectedFilter == "all"
                                    ? Colors.green
                                    : Colors
                                        .transparent, // Green border when selected
                                width: 1.5, // Border width
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(12), // Circular shape
                              ),
                              showCheckmark: false, // No checkmark
                              onSelected: (bool selected) {
                                setState(() {
                                  selectedFilter = "all";
                                });
                                context.read<managerCubit>().allreguestsAboutEventByManager(
                                    EventId: widget.eventid!, classification: 0);
                              },
                            ),
                          ),
                          // Present Chip
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: ChoiceChip(
                              label: Text(
                                "attend".tr(),
                                style: TextStyle(
                                  fontSize: 14, // Smaller font size
                                  color: Colors.black, // Always black text
                                ),
                              ),
                              padding: EdgeInsets.zero, // Smaller padding
                              selected: selectedFilter == "present",
                              backgroundColor: Colors
                                  .grey.shade200, // Default background color
                              selectedColor: Colors.grey
                                  .shade200, // Keeps background grey when selected
                              side: BorderSide(
                                color: selectedFilter == "present"
                                    ? Colors.green
                                    : Colors
                                        .transparent, // Green border when selected
                                width: 1.5, // Border width
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(12), // Circular shape
                              ),
                              showCheckmark: false, // No checkmark
                              onSelected: (bool selected) {
                                setState(() {
                                  selectedFilter = "present";
                                });
                                context.read<managerCubit>().allreguestsAboutEventByManager(
                                    EventId: widget.eventid!, classification: 1);
                              },
                            ),
                          ),
                          // Absent Chip
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: ChoiceChip(
                              label: Text(
                                "absent".tr(),
                                style: TextStyle(
                                  fontSize: 14, // Smaller font size
                                  color: Colors.black, // Always black text
                                ),
                              ),
                              padding: EdgeInsets.zero,
                              selected: selectedFilter == "absent",
                              backgroundColor: Colors
                                  .grey.shade200, // Default background color
                              selectedColor: Colors.grey
                                  .shade200, // Keeps background grey when selected
                              side: BorderSide(
                                color: selectedFilter == "absent"
                                    ? Colors.green
                                    : Colors
                                        .transparent, // Green border when selected
                                width: 1.5, // Border width
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(12), // Circular shape
                              ),
                              showCheckmark: false, // No checkmark
                              onSelected: (bool selected) {
                                setState(() {
                                  selectedFilter = "absent";
                                });
                                context.read<managerCubit>().allreguestsAboutEventByManager(
                                    EventId: widget.eventid!, classification: 2);
                              },
                            ),
                          ),
                          // No Action Taken Chip
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: ChoiceChip(
                              label: Text(
                                "noDecision_taken".tr(),
                                style: TextStyle(
                                  fontSize: 14, // Smaller font size
                                  color: Colors.black, // Always black text
                                ),
                              ),
                              padding: EdgeInsets.zero, // Smaller padding
                              selected: selectedFilter == "no_action",
                              backgroundColor: Colors
                                  .grey.shade200, // Default background color
                              selectedColor: Colors.grey
                                  .shade200, // Keeps background grey when selected
                              side: BorderSide(
                                color: selectedFilter == "no_action"
                                    ? Colors.green
                                    : Colors
                                        .transparent, // Green border when selected
                                width: 1.5, // Border width
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(12), // Circular shape
                              ),
                              showCheckmark: false, // No checkmark
                              onSelected: (bool selected) {
                                setState(() {
                                  selectedFilter = "no_action";
                                });
                                context.read<managerCubit>().allreguestsAboutEventByManager(
                                    EventId: widget.eventid!, classification: 3);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // List of Players
                  Expanded(
                      child: ListView.builder(
                          padding: const EdgeInsets.all(16.0),
                          itemCount: allUserRequests.length,
                          itemBuilder: (context, index) {
                            final userreq = allUserRequests[index];
                            return AttendanceWidget(userreq,widget.eventid!);
                          }))
                ],
              ))
        ]);
      },
    ));
  }
}
