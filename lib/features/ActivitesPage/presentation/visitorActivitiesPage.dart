import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lacrosse/features/ActivitesPage/data/models/activityModel.dart';
import 'package:lacrosse/features/ActivitesPage/widget/OriginalEvent.dart';
import '../../auth/widgets/button_default.dart';
import '../../eventsPage/data/model/experienceModel.dart';
import '../data/manager/cubit/activities_cubit.dart';
import '../data/models/InternalEvent.dart';
import '../widget/CustomActivityWidget.dart';
import '../widget/customdropdownExpriences.dart';
import '../widget/textFeild_default.dart';

class VisitorActivities extends StatefulWidget {
  @override
  _AttendanceScreenState createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<VisitorActivities> {
  // Define the selected filter
  String selectedFilter = "all";
  int eventType = 3;
  List<InternalEventModel> allActivities = [];
  List<EventModel> other = [];
  List<InternalEventModel> matches = [];
  List<InternalEventModel> training = [];
  List<ExperiencesModel> allExp = [];

  // List<InternalEventModel> allActivities = [
  //   InternalEventModel(
  //     id: 1,
  //     eventType: 0,
  //     eventName: "Tech Conference",
  //     from: DateTime(2024, 3, 10, 9, 0), // 9:00 AM
  //     to: DateTime(2024, 3, 10, 17, 0), // 5:00 PM
  //     eventLocation: "Cairo Convention Center",
  //     description: "Annual tech meetup and conference.",
  //     firstTeamId: 1,
  //     firstTeamName: "Team Alpha",
  //     secondTeamId: 2,
  //     secondTeamName: "Team Beta",
  //     applicationUserInternalEvents: [],
  //     internalEventFiles: [],
  //   ),
  //   InternalEventModel(
  //     id: 2,
  //     eventType: 1,
  //     eventName: "Flutter Workshop",
  //     from: DateTime(2024, 4, 5, 14, 0), // 2:00 PM
  //     to: DateTime(2024, 4, 5, 18, 0), // 6:00 PM
  //     eventLocation: "Online",
  //     description: "Hands-on Flutter development session.",
  //     firstTeamId: null,
  //     firstTeamName: null,
  //     secondTeamId: null,
  //     secondTeamName: null,
  //     applicationUserInternalEvents: [],
  //     internalEventFiles: [],
  //   ),
  //   InternalEventModel(
  //     id: 1,
  //     eventType: 2,
  //     eventName: "jooooo Conference",
  //     from: DateTime(2024, 3, 10, 9, 0), // 9:00 AM
  //     to: DateTime(2024, 3, 10, 17, 0), // 5:00 PM
  //     eventLocation: "Cairo Convention Center",
  //     description: "Annual tech meetup and conference.",
  //     firstTeamId: 1,
  //     firstTeamName: "Team Alpha",
  //     secondTeamId: 2,
  //     secondTeamName: "Team Beta",
  //     applicationUserInternalEvents: [],
  //     internalEventFiles: [],
  //   ),
  // ];
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  var _nameController = TextEditingController();
  var _phoneController = TextEditingController();

  // var _timeController = TextEditingController();

  var _LocatioinController = TextEditingController();

  DateTime? appointmentDate;
  TimeOfDay? firstTime;
  TimeOfDay? secondTime;
  int? experienceId;

  @override
  void initState() {
    super.initState();
    context.read<ActivitiesCubit>().getAllInternalEventsForNationalTeam();
    context.read<ActivitiesCubit>().getAllExperiences();
    context.read<ActivitiesCubit>().getFutureEvents();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ActivitiesCubit, ActivitiesState>(
        listener: (context, state) {
      if (state is GetAllInternalEventsForNationalTeamSuccess) {
        allActivities = state.internalEventData;
        print(allActivities.length);
        print(allActivities[0].eventName);
        matches = allActivities.where((event) {
          return event.eventType == 0;
        }).toList();
        training = allActivities.where((event) {
          return event.eventType == 1;
        }).toList();
        // other = allActivities.where((event) {
        //   return event.eventType == 2;
        // }).toList();
      }
      if (state is GetAllExperienceSuccess) {
        allExp = state.listModel;
      }
      if (state is AddExperienceReservationSuccess) {
        _showAwesomeDialog(context);
      }
      if (state is AddInternalEventReservationFailure) {
        _showAwesomeDialog2(context, state.errorMessage);
      }
      if (state is GetEventsSuccess) {
        other = state.listModel;
      }
    }, builder: (context, state) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(children: [
          Stack(children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.16,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/top bar.png'),
                    // Replace with your asset path
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
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 59.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Row(
                      children: [
                        Text(
                          "activities".tr(),
                          style: TextStyle(
                            color: Color(0xff185A3F),
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
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
              child: SingleChildScrollView(
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4),
                              child: ChoiceChip(
                                label: Text(
                                  "all".tr(),
                                  style: TextStyle(
                                      fontSize: 14, // Smaller font size

                                      fontWeight: FontWeight.w400),
                                ),
                                padding: EdgeInsets.zero,
                                // Smaller padding
                                selected: selectedFilter == "all",
                                backgroundColor: Color(0xffF0F4F5),
                                // Default background color
                                selectedColor:
                                    Color(0xffF0F4F5).withOpacity(.25),
                                side: BorderSide(
                                  color: selectedFilter == "all"
                                      ? Colors.green
                                      : Colors.transparent,
                                  // Green border when selected
                                  width: 1, // Border width
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      12), // Circular shape
                                ),
                                showCheckmark: false,
                                // No checkmark
                                onSelected: (bool selected) {
                                  setState(() {
                                    selectedFilter = "all";
                                    eventType = 3;
                                  });
                                  context
                                      .read<ActivitiesCubit>()
                                      .getAllInternalEventsForNationalTeam();
                                },
                              ),
                            ),
                            // teamMatchs Chip
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4),
                              child: ChoiceChip(
                                label: Text(
                                  "teamMatches".tr(),
                                  style: TextStyle(
                                      fontSize: 14, // Smaller font size
                                      fontWeight: FontWeight.w400),
                                ),
                                padding: EdgeInsets.zero,
                                // Smaller padding
                                selected: selectedFilter == "teamMatchs",
                                backgroundColor: Color(0xffF0F4F5),
                                selectedColor:
                                    Color(0xffF0F4F5).withOpacity(.25),
                                side: BorderSide(
                                  color: selectedFilter == "teamMatchs"
                                      ? Colors.green
                                      : Colors.transparent,
                                  // Green border when selected
                                  width: 1, // Border width
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      12), // Circular shape
                                ),
                                showCheckmark: false,
                                // No checkmark
                                onSelected: (bool selected) {
                                  setState(() {
                                    selectedFilter = "teamMatchs";
                                    eventType = 0;
                                  });
                                },
                              ),
                            ),
                            // teamTraining Chip
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4),
                              child: ChoiceChip(
                                label: Text(
                                  "teamTraining".tr(),
                                  style: TextStyle(
                                      fontSize: 14, // Smaller font size
                                      fontWeight: FontWeight.w400),
                                ),
                                padding: EdgeInsets.zero,
                                selected: selectedFilter == "teamTraining",
                                backgroundColor: Color(0xffF0F4F5),
                                selectedColor:
                                    Color(0xffF0F4F5).withOpacity(.25),
                                side: BorderSide(
                                  color: selectedFilter == "teamTraining"
                                      ? Colors.green
                                      : Colors.transparent,
                                  // Green border when selected
                                  width: 1, // Border width
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      12), // Circular shape
                                ),
                                showCheckmark: false,
                                // No checkmark
                                onSelected: (bool selected) {
                                  setState(() {
                                    selectedFilter = "teamTraining";
                                    eventType = 1;
                                  });
                                },
                              ),
                            ),
                            // No Action Taken Chip
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4),
                              child: ChoiceChip(
                                label: Text(
                                  "other".tr(),
                                  style: TextStyle(
                                      fontSize: 14, // Smaller font size
                                      fontWeight: FontWeight.w400),
                                ),
                                padding: EdgeInsets.zero,
                                // Smaller padding
                                selected: selectedFilter == "other",
                                backgroundColor: Color(0xffF0F4F5),
                                selectedColor:
                                    Color(0xffF0F4F5).withOpacity(.25),
                                side: BorderSide(
                                  color: selectedFilter == "other"
                                      ? Colors.green
                                      : Colors.transparent,
                                  // Green border when selected
                                  width: 1, // Border width
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      12), // Circular shape
                                ),
                                showCheckmark: false,
                                // No checkmark
                                onSelected: (bool selected) async {
                                  await context
                                      .read<ActivitiesCubit>()
                                      .getFutureEvents();

                                  setState(() {
                                    selectedFilter = "other";
                                    eventType = 2;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (eventType == 3 || eventType == 0)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Text("teamMatches".tr(),
                            style: TextStyle(
                                color: Colors.grey[600],
                                fontWeight: FontWeight.w500,
                                fontSize: 16)),
                      ),
                    // List of match
                    if (eventType == 3 || eventType == 0)
                      ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          padding: const EdgeInsets.all(8.0),
                          itemCount: matches.length,
                          itemBuilder: (context, index) {
                            //  final userreq = allActivities[index];
                            return acticityWidget(matches[index]);
                          }),

                    // if (matches.isEmpty && eventType == 0)
                    //   Center(
                    //     child: Text("no_teamMatches".tr(),
                    //         style: TextStyle(
                    //             color: Colors.grey.shade300,
                    //             fontWeight: FontWeight.w500,
                    //             fontSize: 20)),
                    //   ),
                    if (eventType == 3 || eventType == 1)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Text("teamTraining".tr(),
                            style: TextStyle(
                                color: Colors.grey.shade600,
                                fontWeight: FontWeight.w500,
                                fontSize: 16)),
                      ),
                    if (eventType == 3 || eventType == 1)
                      ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          padding: const EdgeInsets.all(8.0),
                          itemCount: training.length,
                          itemBuilder: (context, index) {
                            //  final userreq = allActivities[index];
                            return acticityWidget(training[index]);
                          }),
                    // if (eventType == 3 ||
                    //     (training.isEmpty && eventType == 1))
                    //   Center(
                    //     child: Text("no_teamTraining".tr(),
                    //         style: TextStyle(
                    //             color: Colors.grey.shade300,
                    //             fontWeight: FontWeight.w500,
                    //             fontSize: 20)),
                    //   ),
                    if (eventType == 3 || eventType == 2)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Text("other".tr(),
                            style: TextStyle(
                                color: Colors.grey.shade600,
                                fontWeight: FontWeight.w500,
                                fontSize: 16)),
                      ),
                    if (eventType == 3 || eventType == 2)
                      ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          padding: const EdgeInsets.all(8.0),
                          itemCount: other.length,
                          itemBuilder: (context, index) {
                            //  final userreq = allActivities[index];
                            return OriginalActivityWidget(other[index]);
                          }),
                    if (eventType == 3 || (other.isEmpty && eventType == 2))
                      Center(
                        child: Text("no_other".tr(),
                            style: TextStyle(
                                color: Colors.grey.shade300,
                                fontWeight: FontWeight.w500,
                                fontSize: 20)),
                      )
                  ],
                ),
              )),
        ]),

        floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            //  await context.read<ActivitiesCubit>().getAllExperiences();
            showCustomBottomSheet(context);
            // context.read<ActivitiesCubit>().addExperienceReservation(experienceId: 2,name:"mahdy",phoneNumber: "565432345");
          },
          backgroundColor: Color(0xff207954),
          // Green color from your image
          shape: RoundedRectangleBorder(
              borderRadius: const BorderRadius.all(Radius.circular(30))),
          label: Row(
            children: [
              Icon(
                Icons.add,
                color: Colors.white,
                size: 16,
              ),
              SizedBox(width: 5),
              Text(
                "reserveExperience".tr(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              // Space between text and icon
            ],
          ),
          elevation: 0, // Optional: Adds shadow effect
        ),
        // Places it at the bottom right
        floatingActionButtonLocation:
            FloatingActionButtonLocation.startFloat, // Moves FAB to the right
      );
    });
  }

  void showCustomBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // يسمح بتمدد الـ Bottom Sheet عند ظهور الكيبورد
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AnimatedPadding(
              duration:
                  Duration(milliseconds: 250), // حركة سلسة عند ظهور الكيبورد
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.5, // ارتفاع ثابت
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      blurRadius: 6,
                      offset: Offset(0, 1),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Stack(children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(30), // تحديد شكل القص
                      child: const Image(
                        image: AssetImage("assets/images/sheet.jpeg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                    Form(
                      key: formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(height: 20),
                          Text(
                            "bookAppointment".tr(),
                            style: TextStyle(
                              color: Color(0xff207954),
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 15),
                          Row(
                            children: [
                              Text(
                                "aboutYou".tr(),
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 15),
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  DefaultFormField(
                                    label: "name".tr(),
                                    controller: _nameController,
                                    type: TextInputType.text,
                                    validate: (value) =>
                                        value!.isEmpty ? 'Required'.tr() : null,
                                  ),
                                  SizedBox(height: 15),
                                  DefaultFormField(
                                    label: "phone_number".tr(),
                                    type: TextInputType.phone,
                                    controller: _phoneController,
                                    validate: (value) =>
                                        value!.isEmpty ? 'Required'.tr() : null,
                                  ),
                                  SizedBox(height: 15),
                                  CustomDropdownButton_Expriences(
                                    items: allExp,
                                    hint: "selectFromDates".tr(),
                                    onChanged: (value) async {
                                      setState(() {
                                        experienceId = value!.id;
                                      });
                                      _LocatioinController.text = await context
                                          .read<ActivitiesCubit>()
                                          .getLocationName(
                                              value!.latitude, value.longitude);
                                    },
                                  ),
                                  SizedBox(height: 15),
                                  DefaultFormField(
                                    label: "experience_location".tr(),
                                    type: TextInputType.text,
                                    readOnly: true,
                                    controller: _LocatioinController,
                                    validate: (value) =>
                                        value!.isEmpty ? 'Required'.tr() : null,
                                  ),
                                  SizedBox(height: 20),
                                  BlocBuilder<ActivitiesCubit, ActivitiesState>(
                                      builder: (context, state) {
                                    if (state
                                        is AddExperienceReservationLoading)
                                      return Button_default(
                                        height: 56,
                                        title: "confirmReservation".tr(),
                                        color: Color(0xff207954),
                                        colortext: Colors.white,
                                      );
                                    return GestureDetector(
                                      onTap: () async {
                                        if (formKey.currentState!.validate()) {
                                          context
                                              .read<ActivitiesCubit>()
                                              .addExperienceReservation(
                                                experienceId: experienceId!,
                                                name: _nameController.text,
                                                phoneNumber:
                                                    _phoneController.text,
                                              );

                                          Navigator.pop(context);
                                          _phoneController.clear();
                                          _nameController.clear();
                                          _LocatioinController.clear();
                                        }
                                      },
                                      child: Button_default(
                                        height: 56,
                                        title: "confirmReservation".tr(),
                                        color: Color(0xff207954),
                                        colortext: Colors.white,
                                      ),
                                    );
                                  }),
                                  SizedBox(height: 20),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]),
                ),
              ),
            );
          },
        );
      },
    );
  }

  void showCustomBottomSheet2(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // يسمح بتمدد الـ Bottom Sheet عند ظهور الكيبورد
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.5, // مرونة أفضل
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/sheet.jpeg"),
                ),
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 6,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.only(
                  left: 16,
                  right: 16,
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: Form(
                  key: formKey, // تأكد من تعريفه خارج الدالة
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 20),
                      Text(
                        "bookAppointment".tr(),
                        style: TextStyle(
                          color: Color(0xff207954),
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 15),
                      Row(
                        children: [
                          Text(
                            "aboutYou".tr(),
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              DefaultFormField(
                                label: "name".tr(),
                                controller: _nameController,
                                type: TextInputType.text,
                                validate: (value) =>
                                    value!.isEmpty ? 'Required'.tr() : null,
                              ),
                              SizedBox(height: 15),
                              DefaultFormField(
                                label: "phone_number".tr(),
                                type: TextInputType.phone,
                                controller: _phoneController,
                                validate: (value) =>
                                    value!.isEmpty ? 'Required'.tr() : null,
                              ),
                              SizedBox(height: 15),
                              CustomDropdownButton_Expriences(
                                items: allExp,
                                hint: "selectFromDates".tr(),
                                onChanged: (value) async {
                                  experienceId = value!.id;

                                  _LocatioinController.text =
                                      //await getLocationName(value!.latitude, value.longitude);
                                      await context
                                          .read<ActivitiesCubit>()
                                          .getLocationName(
                                              value.latitude, value.longitude);
                                },
                              ),
                              SizedBox(height: 15),
                              DefaultFormField(
                                label: "experience_location".tr(),
                                type: TextInputType.text,
                                controller: _LocatioinController,
                                validate: (value) =>
                                    value!.isEmpty ? 'Required'.tr() : null,
                              ),
                              SizedBox(height: 20),
                              BlocBuilder<ActivitiesCubit, ActivitiesState>(
                                  builder: (context, state) {
                                if (state is AddExperienceReservationLoading)
                                  return Button_default(
                                    height: 56,
                                    title: "confirmReservation".tr(),
                                    color: Color(0xff207954),
                                    colortext: Colors.white,
                                  );
                                return GestureDetector(
                                  onTap: () async {
                                    if (formKey.currentState!.validate()) {
                                      context
                                          .read<ActivitiesCubit>()
                                          .addExperienceReservation(
                                            experienceId: experienceId!,
                                            name: _nameController.text,
                                            phoneNumber: _phoneController.text,
                                          );

                                      Navigator.pop(context);
                                      _phoneController.clear();
                                      _nameController.clear();
                                      _LocatioinController.clear();
                                    }
                                  },
                                  child: Button_default(
                                    height: 56,
                                    title: "confirmReservation".tr(),
                                    color: Color(0xff207954),
                                    colortext: Colors.white,
                                  ),
                                );
                              }),
                              SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _showAwesomeDialog2(BuildContext context, text) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.error, // success, error, warning, info
      animType: AnimType.leftSlide, // fade, leftSlide, rightSlide, scale
      title: 'error'.tr(),
      desc: text.toString(),
      btnOkOnPress: () {},
    ).show();
  }

  void _showAwesomeDialog(BuildContext context) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.success, // success, error, warning, info
      animType: AnimType.leftSlide, // fade, leftSlide, rightSlide, scale
      title: 'success'.tr(),
      desc: 'Gob_done_successfully'.tr(),
      btnOkOnPress: () {},
    ).show();
  }
}
