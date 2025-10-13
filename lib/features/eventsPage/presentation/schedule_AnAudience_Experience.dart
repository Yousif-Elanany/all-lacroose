import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';

import '../data/manager/cubit/manager_cubit.dart';
import '../data/manager/cubit/manager_states.dart';

import '../widgets/button_default.dart';

import '../widgets/textFeild_default.dart';
import 'mapePage.dart';

class Schedule_AnAudience_Experience extends StatefulWidget {
  const Schedule_AnAudience_Experience({super.key});

  @override
  State<Schedule_AnAudience_Experience> createState() =>
      _Schedule_AnAudience_ExperienceState();
}

class _Schedule_AnAudience_ExperienceState
    extends State<Schedule_AnAudience_Experience> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
bool loading = false;
  var _eventTime = TextEditingController();
  var _eventdate = TextEditingController();
  var _eventLocatioin = TextEditingController();

  DateTime? appointmentDate;
  TimeOfDay? firstTime;
  TimeOfDay? secondTime;

  String? latitude;
  String? longitude;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<managerCubit, ManagerStates>(
      listener: (context, state) {
        if (state is CreateExperienceSuccess) _showAwesomeDialog(context);

        if (state is CreateExperienceLoading){
          setState(() {
            loading = true;
          });
        } else {
          setState(() {
            loading = false;
          });
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
                    child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 0.0, top: 0),
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
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
                              "Schedule_AnAudience_Experience".tr(),
                              style: TextStyle(
                                color: Color(0xff207954), //999999
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .03,
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  DefaultFormField(
                                      onTap: () {
                                        _selectTime(context);
                                      },
                                      readOnly: true,
                                      label: "selectTime".tr(),
                                      controller: _eventTime,
                                      type: TextInputType.text,
                                      validate: (value) {
                                        if (value!.isEmpty) {
                                          return 'Required'.tr();
                                        }
                                        return null;
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
                                      label: "selectDate".tr(),
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
                                  DefaultFormField(
                                    onTap: () {
                                      _navigateToMapPage(context);
                                    },
                                    readOnly: true,
                                    label: "experience_location".tr(),
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
                                        MediaQuery.of(context).size.height * .5,
                                  ),
                                  GestureDetector(
                                    onTap: (state is CreateExperienceLoading)
                                        ? null
                                        : () async {
                                            if (formKey.currentState!
                                                .validate()) {
                                              await context
                                                  .read<managerCubit>()
                                                  .createExperience(
                                                      appointment:
                                                          _eventdate.text,
                                                      fromTime:
                                                          convertTimeOfDayTo24(
                                                              firstTime!),
                                                      toTime:
                                                          convertTimeOfDayTo24(
                                                              secondTime!),
                                                      longitude: longitude!,
                                                      latitude: latitude!);

                                              _eventTime.clear();
                                              _eventdate.clear();
                                              _eventLocatioin.clear();
                                            }
                                          },
                                    child: loading ? Center(child: CircularProgressIndicator()) :Button_default(
                                      height: 56,
                                      title: "add_this_time".tr(),
                                      color: Color(0xff207954),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                ]),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ));
      },
    );
  }

  String convertTimeOfDayTo24(TimeOfDay time) {
    // Ensure hours and minutes are always two digits (e.g., 09:05 instead of 9:5)
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }

  Future<void> _navigateToMapPage(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MapPage()),
    );

    if (result != null && result is Map<String, double>) {
      latitude = result['latitude']!.toStringAsFixed(6);
      longitude = result['longitude']!.toStringAsFixed(6);
      // Get location name asynchronously before updating state
      String locationName = await getLocationName(
        lat: result['latitude']!,
        lon: result['longitude']!,
      );

      setState(() {
        _eventLocatioin.text = locationName;
      });
    }
  }
  Future<void> _selectTime(BuildContext context) async {
    // اختيار الوقت الأول
    final pickedFirstTime = await showTimePicker(
      helpText: "start_time".tr(), // يبدأ / Start
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedFirstTime != null) {
      firstTime = pickedFirstTime;

      // اختيار الوقت الثاني
      final pickedSecondTime = await showTimePicker(
        helpText: "end_time".tr(), // ينتهي / End
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (pickedSecondTime != null) {
        secondTime = pickedSecondTime;

        // تحديث النص في TextField
        _eventTime.text =
        "${"from".tr()}: ${firstTime!.format(context)}   ${"to".tr()}: ${secondTime!.format(context)}";
      }
    }
  }


  Future<void> _selectDate(BuildContext context) async {
    final pickedFirstDate = await showDatePicker(
      // helpText: helpText: 'اختر تاريخ البدايه',,
      context: context,

      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedFirstDate != null) {
      appointmentDate = pickedFirstDate;
      _eventdate.text =
          "${appointmentDate!.toLocal().toString().split(' ')[0]}";
    }
  }

  Future<String> getLocationName(
      {required double lat, required double lon}) async {
    try {
      // Perform reverse geocoding
      List<Placemark> placemarks = await placemarkFromCoordinates(lat, lon);

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        return "${place.locality}, ${place.country}"; // Example: "Cairo, Egypt"
      } else {
        return "noLocation".tr();
      }
    } catch (e) {
      return "Error: ${e.toString()}";
    }
  }
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

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );
