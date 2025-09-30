import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lacrosse/features/eventsPage/data/model/player_model.dart';
import 'package:lacrosse/features/eventsPage/widgets/Navigator.dart';
import 'package:video_player/video_player.dart';
import '../../../data/Local/sharedPref/sharedPref.dart';
import '../data/manager/cubit/manager_cubit.dart';
import '../data/manager/cubit/manager_states.dart';
import '../data/model/eventModel.dart';
import '../data/model/team.dart';
import '../widgets/button_default.dart';
import '../widgets/dorpDown_partisipatePlayers.dart';
import '../widgets/dropDownParticipateTeams.dart';
import '../widgets/textFeild_default.dart';

class Add_event extends StatefulWidget {
  const Add_event({super.key});

  @override
  State<Add_event> createState() => _Add_eventState();
}

class _Add_eventState extends State<Add_event> {
  int selected_event = 1;
  int? selectedValue = 0; // القيمة المختارة

  List<TeamMMModel> participateTeams = [];
  List<TeamMMModel> all_teams = [];
  List<PlayerModel> eventParticipate = [];
  List<PlayerModel> all_Players = [];
  List<PlayerModel> all_Traineres = [];
  List<PlayerModel> all_Participate = [];

  bool is_match = true;
  bool is_other = true;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final CustomDropdownController dropdownController =
      CustomDropdownController();
  final CustomDropdownController_teams dropdownControllerTeams =
      CustomDropdownController_teams();
  int selectedIndex = 0; // 0 = match, 1 = training, 2 = other

  GlobalKey dropdownKey2 = GlobalKey();
  var _eventName = TextEditingController();
  var _eventTime = TextEditingController();
  var _eventdate = TextEditingController();

  var _eventdate2 = TextEditingController();
  var _eventLocatioin = TextEditingController();
  var _eventDescription = TextEditingController();
  DateTime? firstDate;
  DateTime? secondDate;
  TimeOfDay? firstTime;
  TimeOfDay? secondTime;
  File? selectedImage1 = File('file.txt');
  List<File> list_selected_mediaFile = [];
  List<String> list_uploaded_link = [];
  List<InternalEventFile> listApplicationFilesTest = [];
  List<VideoPlayerController?> videoControllers = [];
  String formatTimeOfDay(TimeOfDay time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return "$hour:$minute";
  }

  String formatTimeOfDay2(TimeOfDay time) {
    final hour = time.hour.toString().padLeft(2, '0'); // يحط صفر لو أقل من 10
    final minute = time.minute.toString().padLeft(2, '0');
    return "$hour:$minute";
  }

  String date_timeFrom2(DateTime? fromDay) {
    if (fromDay == null) return "";
    return DateFormat('yyyy-MM-dd').format(fromDay);
  }

  String date_timeTo2(DateTime? toDay) {
    if (toDay == null) return "";
    return DateFormat('yyyy-MM-dd').format(toDay);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<managerCubit>().fetchAllPlayerData();
    context.read<managerCubit>().fetchAllTrainerData();
    context.read<managerCubit>().fetchAllTeams();
  }

  @override
  void dispose() {
    // تنظيف موارد الفيديو عند التخلص من الشاشة
    for (var controller in videoControllers) {
      controller?.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<managerCubit, ManagerStates>(
      listener: (context, state) {
        if (state is fetch_team2_success) all_teams = state.Team;
        if (state is PlayerSuccess) {
          all_Players = state.playerData;
          all_Participate.addAll(all_Players);
        }
        if (state is TrainerSuccess) {
          all_Traineres = state.TrainerData;
          print("trainer/////////////");
          print(all_Traineres);
          print("trainer");

          all_Participate.addAll(all_Traineres);
          print("all_Participate////////////////");
          print(all_Participate);
        }
        if (state is Image_videoSuccess) {
          InternalEventFile NewModel = InternalEventFile(
              file: state.Image_videoLink, internalEventId: 0);
          listApplicationFilesTest.add(NewModel);
          print(listApplicationFilesTest.toString());
        }
        //   if(state is Image_videoSuccess){
        //     print(list_uploaded_link);
        // //   list_uploaded_link.add( state.Image_videoLink);
        //   print(list_uploaded_link);}
        if (state is AddNewEventSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("event_added_success".tr()),
              backgroundColor: Colors.green,
            ),
          );
        }
        if (state is AddEventSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("event_added_success".tr()),
              backgroundColor: Colors.green,
            ),
          );
        }

      },
      builder: (context, state) {
        return Scaffold(
            backgroundColor: Colors.white,
            body: Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.13,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          'assets/images/top bar.png'), // Replace with your asset path
                      fit: BoxFit.cover, // Adjust to control how the image fits
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * .06,
                      right: 8,
                      left: 8),
                  child: Form(
                    key: formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        // crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
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
                                        color: Color(0xff185A3F), size: 24),
                                  ),
                                ),
                              ),
                              Text(
                                "add_event".tr(),
                                style: TextStyle(
                                  color: Color(0xff207954), //999999
                                  fontSize: 24,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .03,
                          ),
                          SizedBox(
                            height: MediaQuery.sizeOf(context).height * 0.8,
                            child: SingleChildScrollView(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "adding_photo_video".tr(),
                                      style: TextStyle(
                                        ///  color: Color(0xff328361),
                                        fontSize: 16,
                                        // fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(width: 5),
                                        GestureDetector(
                                          onTap: () {
                                            showPickerDialog(
                                              context,
                                              onTapPhoto: () {
                                                Navigator.pop(context);
                                                _pickImage_video(true);
                                                setState(() {});
                                              },
                                              onTapVideo: () {
                                                Navigator.pop(context);
                                                _pickImage_video(false);
                                                setState(() {});
                                              },
                                            );
                                          },
                                          child: SizedBox(
                                            height: 56,
                                            width: 56,
                                            child: CircleAvatar(
                                              backgroundColor: Colors.white,
                                              child: Icon(Icons.add),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Flexible(
                                          child: SizedBox(
                                            height: 88,
                                            child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              itemCount: list_selected_mediaFile
                                                  .length,
                                              itemBuilder: (context, index) {
                                                final file =
                                                    list_selected_mediaFile[
                                                        index];
                                                final videoController =
                                                    videoControllers[index];

                                                return Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(horizontal: 5),
                                                  child:
                                                      file.path.endsWith(
                                                                  '.mp4') &&
                                                              videoController !=
                                                                  null
                                                          ? GestureDetector(
                                                              onTap: () {
                                                                setState(() {
                                                                  // تشغيل أو إيقاف الفيديو
                                                                  if (videoController
                                                                      .value
                                                                      .isPlaying) {
                                                                    videoController
                                                                        .pause();
                                                                  } else {
                                                                    videoController
                                                                        .play();
                                                                  }
                                                                });
                                                              },
                                                              child: Stack(
                                                                alignment:
                                                                    AlignmentDirectional(
                                                                        0, 0),
                                                                children: [
                                                                  ClipRRect(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            20),
                                                                    child:
                                                                        SizedBox(
                                                                      width: 88,
                                                                      height:
                                                                          88,
                                                                      child: VideoPlayer(
                                                                          videoController),
                                                                    ),
                                                                  ),
                                                                  if (!videoController
                                                                      .value
                                                                      .isPlaying)
                                                                    Center(
                                                                      child:
                                                                          Icon(
                                                                        Icons
                                                                            .play_circle_fill,
                                                                        color: Colors
                                                                            .white,
                                                                        size:
                                                                            30,
                                                                      ),
                                                                    ),
                                                                  Positioned(
                                                                    top: 0,
                                                                    left: 0,
                                                                    child: Row(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        GestureDetector(
                                                                          onTap:
                                                                              () {
                                                                            list_selected_mediaFile.removeAt(index);
                                                                            setState(() {});
                                                                          },
                                                                          child:
                                                                              CircleAvatar(
                                                                            backgroundColor:
                                                                                Colors.white,
                                                                            radius:
                                                                                10,
                                                                            child:
                                                                                Icon(
                                                                              Icons.close_outlined,
                                                                              size: 20,
                                                                              color: Colors.red,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            )
                                                          : Stack(
                                                              children: [
                                                                ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20),
                                                                  child:
                                                                      SizedBox(
                                                                    width: 88,
                                                                    child: Image
                                                                        .file(
                                                                      list_selected_mediaFile[
                                                                          index],
                                                                      fit: BoxFit
                                                                          .cover,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Positioned(
                                                                  top: 0,
                                                                  left: 0,
                                                                  child: Row(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      GestureDetector(
                                                                        onTap:
                                                                            () {
                                                                          list_selected_mediaFile
                                                                              .removeAt(index);
                                                                          setState(
                                                                              () {});
                                                                        },
                                                                        child:
                                                                            CircleAvatar(
                                                                          backgroundColor:
                                                                              Colors.white,
                                                                          radius:
                                                                              10,
                                                                          child:
                                                                              Icon(
                                                                            Icons.close_outlined,
                                                                            color:
                                                                                Colors.red,
                                                                            size:
                                                                                20,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      "event_type".tr(),
                                      style: TextStyle(
                                        ///  color: Color(0xff328361),
                                        fontSize: 16,
                                        // fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        // Match
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              is_match = true;
                                              is_other = false;
                                              // لو عندك متغير تاني للتدريب ممكن تضبطه كمان
                                            });
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: is_match
                                                  ? Color(0xffF0F6F4)
                                                  : Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                              border: Border.all(
                                                color: is_match
                                                    ? Color(0xff488B71)
                                                    : Colors.white,
                                                width: 1,
                                              ),
                                            ),
                                            padding: EdgeInsets.all(5),
                                            height: 82,
                                            width: 75,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Image.asset(
                                                  "assets/images/match.png",
                                                  width: 32,
                                                  height: 32,
                                                ),
                                                SizedBox(height: 5),
                                                Text("match".tr(),
                                                    style: TextStyle(
                                                        fontSize: 16)),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        // Training
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              is_match = false;
                                              is_other = false;
                                            });
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: !is_match && !is_other
                                                  ? Color(0xffF0F6F4)
                                                  : Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                              border: Border.all(
                                                color: !is_match && !is_other
                                                    ? Color(0xff488B71)
                                                    : Colors.white,
                                                width: 1,
                                              ),
                                            ),
                                            padding: EdgeInsets.all(5),
                                            height: 82,
                                            width: 75,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Image.asset(
                                                  "assets/images/match.png",
                                                  width: 32,
                                                  height: 32,
                                                ),
                                                SizedBox(height: 5),
                                                Text("training".tr(),
                                                    style: TextStyle(
                                                        fontSize: 16)),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        // Other
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              is_match = false;
                                              is_other = true;
                                            });
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: is_other
                                                  ? Color(0xffF0F6F4)
                                                  : Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                              border: Border.all(
                                                color: is_other
                                                    ? Color(0xff488B71)
                                                    : Colors.grey
                                                        .withOpacity(.1),
                                                width: 2,
                                              ),
                                            ),
                                            padding: EdgeInsets.all(10),
                                            height: 82,
                                            width: 75,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text("other".tr(),
                                                    style: TextStyle(
                                                        fontSize: 16)),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    !is_other
                                        ? DropdownButtonFormField<int>(
                                            decoration: InputDecoration(
                                              fillColor: Colors.white,
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 16,
                                                      vertical: 12),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: BorderSide(
                                                    color: Colors.grey),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: BorderSide(
                                                    color: Colors.grey),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: BorderSide(
                                                    color: Colors.blue),
                                              ),
                                            ),
                                            hint: Text("choose".tr()),
                                            value: selectedValue,
                                            onChanged: (newValue) {
                                              setState(() {
                                                selectedValue = newValue;
                                              });
                                            },
                                            items: [
                                              DropdownMenuItem(
                                                value: 0,
                                                child: Text(
                                                  "team".tr(),
                                                  style: TextStyle(
                                                      color: Colors.grey),
                                                ),
                                              ),
                                              DropdownMenuItem(
                                                value: 1,
                                                child: Text(
                                                  "national team".tr(),
                                                  style: TextStyle(
                                                      color: Colors.grey),
                                                ),
                                              ),
                                            ],
                                          )
                                        : SizedBox(),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    DefaultFormField(
                                        onTap: () {},
                                        label: "event_name".tr(),
                                        controller: _eventName,
                                        type: TextInputType.text,
                                        validate: (value) {
                                          if (value!.isEmpty) {
                                            return 'Required'.tr();
                                          }
                                          return null;
                                        },
                                        hint: ""),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    DefaultFormField(
                                        onTap: () {
                                          _selectTime(context);
                                        },
                                        readOnly: true,
                                        label: "event_time".tr(),
                                        controller: _eventTime,
                                        type: TextInputType.text,
                                        validate: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Required'.tr();
                                          }

                                          return null; // Validation passed
                                        },
                                        suffix: Icons.timer),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    DefaultFormField(
                                        onTap: () {
                                          _selectDate(context);
                                        },
                                        readOnly: true,
                                        label: "event_date".tr(),
                                        type: TextInputType.text,
                                        controller: _eventdate,
                                        suffix: Icons.calendar_month_outlined,
                                        validate: (value) {
                                          if (value!.isEmpty) {
                                            return 'Required'.tr();
                                          }
                                          return null;
                                        },
                                        hint: ""),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    is_other
                                        ? Column(
                                            children: [
                                              DefaultFormField(
                                                  onTap: () {
                                                    _selectDate2(context);
                                                  },
                                                  readOnly: true,
                                                  label: "event_date".tr(),
                                                  type: TextInputType.text,
                                                  controller: _eventdate2,
                                                  suffix: Icons
                                                      .calendar_month_outlined,
                                                  validate: (value) {
                                                    if (value!.isEmpty) {
                                                      return 'Required'.tr();
                                                    }
                                                    return null;
                                                  },
                                                  hint: ""),
                                              SizedBox(
                                                height: 20,
                                              ),
                                            ],
                                          )
                                        : SizedBox(),

                                    DefaultFormField(
                                      label: "event_location".tr(),
                                      type: TextInputType.text,
                                      controller: _eventLocatioin,
                                      suffix: Icons.location_on_outlined,
                                      validate: (value) {
                                        if (value!.isEmpty) {
                                          return 'Required'.tr();
                                        }
                                        return null;
                                      },
                                      //  hint: "رقم الجوال"
                                    ),
                                    SizedBox(
                                      height:
                                          10, //  height: MediaQuery.of(context).size.height * .3,
                                    ),
                                    is_match && !is_other
                                        ? CustomDropdownButton_Teams(
                                            controller: dropdownControllerTeams,
                                            items: all_teams,
                                            hint: "part_team".tr(),
                                            onChanged: (value) {
                                              if (value != null &&
                                                  !participateTeams
                                                      .contains(value) &&
                                                  participateTeams.length <=
                                                      1) {
                                                participateTeams.add(value);

                                                setState(() {});
                                              }
                                            },
                                          )
                                        : Container(),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    is_match
                                        ? Container(
                                            height: participateTeams.isEmpty
                                                ? 0
                                                : 40,
                                            // color: Colors.amber,
                                            child: ListView.builder(
                                              shrinkWrap: true,
                                              scrollDirection: Axis.horizontal,
                                              itemCount:
                                                  participateTeams.length,
                                              itemBuilder: (context, index) {
                                                final team =
                                                    participateTeams[index];
                                                return _buildTeamDetails(
                                                    team, index);
                                              },
                                            ),
                                          )
                                        : Container(),
                                    SizedBox(
                                      height:
                                          10, //  height: MediaQuery.of(context).size.height * .3,
                                    ),
                                    !is_other
                                        ? CustomDropdownButton_players(
                                            controller: dropdownController,
                                            items: all_Participate,
                                            hint: 'participate'.tr(),
                                            onChanged: (value) {
                                              if (value != null &&
                                                  !eventParticipate
                                                      .contains(value)) {
                                                setState(() {
                                                  eventParticipate.add(value);
                                                });
                                              }
                                            },
                                          )
                                        : SizedBox(),

                                    Container(
                                      height: eventParticipate.isEmpty ? 0 : 40,
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: eventParticipate.length,
                                        itemBuilder: (context, index) {
                                          final player =
                                              eventParticipate[index];
                                          return Container(
                                            margin: EdgeInsets.symmetric(
                                                horizontal:
                                                    5), // إضافة مسافة بين العناصر
                                            height: 40,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                              border: Border.all(
                                                color:
                                                    Colors.grey.withOpacity(.1),
                                                width: 2,
                                              ),
                                            ),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Row(
                                              mainAxisSize: MainAxisSize
                                                  .min, // السماح للنص باستخدام أقل مساحة ممكنة
                                              children: [
                                                CircleAvatar(
                                                  radius: 10,
                                                  backgroundImage: NetworkImage(
                                                      player.image),
                                                ),
                                                SizedBox(width: 5),
                                                ConstrainedBox(
                                                  constraints: BoxConstraints(
                                                      maxWidth: 80),
                                                  child: Text(
                                                    player.displayName,
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style:
                                                        TextStyle(fontSize: 14),
                                                  ),
                                                ),
                                                SizedBox(width: 5),
                                                GestureDetector(
                                                  onTap: () {
                                                    eventParticipate
                                                        .removeAt(index);
                                                    setState(() {});
                                                  },
                                                  child: Icon(
                                                    Icons.close,
                                                    size: 16,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              .01,
                                    ),
                                    DefaultFormField(
                                      minLines: 5,
                                      label: "event_description".tr(),
                                      controller: _eventDescription,
                                      type: TextInputType.multiline,
                                      validate: (value) {
                                        if (value!.isEmpty) {
                                          return 'Required'.tr();
                                        }
                                        return null;
                                      },
                                      //  hint: "رقم الجوال"
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    GestureDetector(
                                      onTap: (state is AddNewEventLoading)
                                          ? null
                                          : () async {
                                              if (formKey.currentState!
                                                  .validate()) {
                                                List<ApplicationUserInternalEvent>
                                                    listApplicationPlayers = [];
                                                for (int i = 0;
                                                    i < eventParticipate.length;
                                                    i++) {
                                                  listApplicationPlayers.add(
                                                    ApplicationUserInternalEvent(
                                                        applicationUserId:
                                                            eventParticipate[i]
                                                                .id,
                                                        internalEventId: 0),
                                                  );
                                                }
                                                List<InternalEventFile>
                                                    listApplicationFiles = [];
                                                for (int i = 0;
                                                    i <
                                                        list_uploaded_link
                                                            .length;
                                                    i++) {
                                                  listApplicationFiles.add(
                                                    InternalEventFile(
                                                        internalEventId: 0,
                                                        file:
                                                            list_uploaded_link[
                                                                i]),
                                                  );
                                                }
                                                //  print(listApplicationFiles[0].file);

                                                for (var model
                                                    in listApplicationFiles) {
                                                  print(model.toString());
                                                }

                                                /// print( CacheHelper.getData(key: "FcmToken"));

                                                //   add event ///

                                                if (is_match && !!is_other) {
                                                  print(
                                                      "_eventName.text   match /////////////");
                                                  BlocProvider.of<managerCubit>(
                                                          context)
                                                      .addNewMatchEvent(
                                                    eventType: 0,
                                                    startDate_Time:
                                                        date_timeFrom(),
                                                    endDate_Time: date_timeTo(),
                                                    description:
                                                        _eventDescription.text,
                                                    eventName: _eventName.text,
                                                    location:
                                                        _eventLocatioin.text,
                                                    firstTeamId:
                                                        participateTeams[0].id,
                                                    secondTeamId:
                                                        participateTeams[1].id,
                                                    listApplicationPlayers:
                                                        listApplicationPlayers,
                                                    listApplicationLink:
                                                        listApplicationFilesTest,
                                                    teamType:
                                                        selectedValue ?? 0,
                                                  );
                                                } else if (is_other &&
                                                    !is_match) {
                                                  BlocProvider.of<managerCubit>(
                                                          context)
                                                      .addEvent(
                                                          Name: _eventName.text,
                                                      file: list_selected_mediaFile.isNotEmpty ? list_selected_mediaFile[0] : null,
                                                          Description:
                                                              _eventDescription
                                                                  .text,
                                                          Location:
                                                              _eventLocatioin
                                                                  .text,
                                                          FromDay:
                                                              _eventdate.text,
                                                          ToDay:
                                                              _eventdate2.text,
                                                          FromTime: firstTime !=
                                                                  null
                                                              ? formatTimeOfDay(
                                                                  firstTime!)
                                                              : "",
                                                          ToTime: secondTime !=
                                                                  null
                                                              ? formatTimeOfDay(
                                                                  secondTime!)
                                                              : "");
                                                } else {
                                                  BlocProvider.of<
                                                          managerCubit>(context)
                                                      .addNewTrainingEvent(
                                                          teamType:
                                                              selectedValue ??
                                                                  0,
                                                          eventType: 1,
                                                          startDate_Time:
                                                              date_timeFrom(),
                                                          endDate_Time:
                                                              date_timeTo(),
                                                          description:
                                                              _eventDescription
                                                                  .text,
                                                          eventName:
                                                              _eventName.text,
                                                          location:
                                                              _eventLocatioin
                                                                  .text,
                                                          listApplicationPlayers:
                                                              listApplicationPlayers,
                                                          listApplicationLink:
                                                              listApplicationFiles);
                                                }
                                                setState(() {
                                                  _eventName.clear();
                                                  _eventLocatioin.clear();
                                                  _eventName.clear();
                                                  _eventTime.clear();
                                                  _eventdate.clear();
                                                  _eventDescription.clear();
                                                  selectedValue = null;
                                                  eventParticipate.clear();
                                                  participateTeams.clear();
                                                  list_selected_mediaFile
                                                      .clear();
                                                  dropdownController.reset();
                                                  dropdownControllerTeams
                                                      .reset();
                                                });
                                              }
                                            },
                                      child: Button_default(
                                        height: 56,
                                        title: "add_this_event".tr(),
                                        color: Color(0xff207954),
                                      ),
                                    ),
                                    // SizedBox(
                                    //   height: 20,
                                    // ),
                                  ]),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ));
      },
    );
  }

  Future<void> _pickImage_video(bool is_image) async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = is_image
        ? await picker.pickImage(source: ImageSource.gallery)
        : await picker.pickVideo(source: ImageSource.gallery);
    if (pickedFile != null) {
      selectedImage1 = File(pickedFile.path);
      list_selected_mediaFile.add(File(pickedFile.path));

      // إذا كان الملف فيديو
      if (pickedFile.path.endsWith('.mp4')) {
        final controller =
            VideoPlayerController.file(File(pickedFile.path)); // وحدة التحكم
        controller.initialize().then((_) {
          setState(() {}); // إعادة البناء بعد التهيئة
        });
        videoControllers.add(controller);
      } else {
        // إذا كان الملف صورة
        videoControllers.add(null);
      }
      setState(() {});
      await BlocProvider.of<managerCubit>(context)
          .uploadImage_video(file: File(pickedFile.path));
    }
  }

  String date_timeFrom() {
    String date_Time = "";
    if (firstDate != null) {
      if (firstTime != null) {
        setState(() {
          final DateTime dateTime = DateTime(
            firstDate!.year,
            firstDate!.month,
            firstDate!.day,
            firstTime!.hour,
            firstTime!.minute,
          );

          date_Time =
              DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").format(dateTime);
        });
      }
    }
    return date_Time;
  }

  String date_timeTo() {
    String date_Time = "";

    if (firstDate != null) {
      if (firstTime != null) {
        setState(() {
          final DateTime dateTime = DateTime(
            firstDate!.year,
            firstDate!.month,
            firstDate!.day,
            secondTime!.hour,
            secondTime!.minute,
          );

          date_Time =
              DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").format(dateTime);

          print(date_Time);
          print("yousef ////////");
        });
      }
    }
    return date_Time;
  }

  Future<void> _selectTime(BuildContext context) async {
    // اختيار الوقت الأول
    final pickedFirstTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedFirstTime != null) {
      firstTime = pickedFirstTime;

      // اختيار الوقت الثاني
      final pickedSecondTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (pickedSecondTime != null) {
        secondTime = pickedSecondTime;

        // تحديث النص في TextField
        _eventTime.text =
            //"${firstTime!.format(context)} ${'from'.tr()} - ${secondTime!.format(context)} ${'to'.tr()}";
            "${"from".tr()}: ${firstTime!.format(context)}   ${"to".tr()}: ${secondTime!.format(context)}";
      }
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    // اختيار التاريخ الأول
    final pickedFirstDate = await showDatePicker(
      context: context,

      helpText: 'select_event_date'.tr(),
      // confirmText: 'تأكيد',           // نص زر التأكيد
      // cancelText:  "نص زر الإلغاء",
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedFirstDate != null) {
      firstDate = pickedFirstDate;

      _eventdate.text = firstDate!.toLocal().toString().split(' ')[0];
      // "  من : ${firstDate!.toLocal().toString().split(' ')[0]}  الي : ${secondDate!.toLocal().toString().split(' ')[0]}";
    }
  }

  Future<void> _selectDate2(BuildContext context) async {
    // اختيار التاريخ الأول
    final pickedFirstDate = await showDatePicker(
      context: context,

      helpText: 'select_event_date'.tr(),
      // confirmText: 'تأكيد',           // نص زر التأكيد
      // cancelText:  "نص زر الإلغاء",
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedFirstDate != null) {
      secondDate = pickedFirstDate;

      _eventdate2.text = secondDate!.toLocal().toString().split(' ')[0];
      // "  من : ${firstDate!.toLocal().toString().split(' ')[0]}  الي : ${secondDate!.toLocal().toString().split(' ')[0]}";
    }
  }

  Widget _buildTeamDetails(TeamMMModel team, int index) {
    return Container(
        height: 40,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Colors.grey.withOpacity(.1), // لون الحدود
            width: 2, // سمك الحدود
          ),
        ),
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 10,
              backgroundImage: NetworkImage(
                team.img,
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              team.name,
              style: TextStyle(
                ///  color: Color(0xff328361),
                fontSize: 16,
                // fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              width: 5,
            ),
            GestureDetector(
              onTap: () {
                participateTeams.removeAt(index);
                setState(() {});
              },
              child: Icon(
                Icons.close,
                size: 16,
                color: Colors.grey,
              ),
            )
          ],
        ));
  }
}
