import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import '../data/manager/cubit/manager_cubit.dart';
import '../data/manager/cubit/manager_states.dart';
import '../data/model/experienceModel.dart';
import '../widgets/button_default.dart';
import '../widgets/textFeild_default.dart';
import 'mapePage.dart';

class EditExperienceScreen extends StatefulWidget {
  final ExperiencesModel model; // الموديل اللي هيتم التعديل عليه

  const EditExperienceScreen({super.key, required this.model});

  @override
  State<EditExperienceScreen> createState() => _EditExperienceScreenState();
}

class _EditExperienceScreenState extends State<EditExperienceScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late TextEditingController _eventTime;
  late TextEditingController _eventDate;
  late TextEditingController _eventLocation;

  DateTime? appointmentDate;
  TimeOfDay? firstTime;
  TimeOfDay? secondTime;

  String? latitude;
  String? longitude;

  @override
  void initState() {
    super.initState();

    _eventDate = TextEditingController(text: widget.model.appointment ?? "");
    _eventTime = TextEditingController(
        text: "${widget.model.fromTime ?? ''} - ${widget.model.toTime ?? ''}");
    _eventLocation = TextEditingController();

    latitude = widget.model.latitude.toString() ?? '';
    longitude = widget.model.longitude.toString() ?? '';

    // تحويل الوقت من string إلى TimeOfDay
    firstTime = _stringToTimeOfDay(widget.model.fromTime);
    secondTime = _stringToTimeOfDay(widget.model.toTime);

    // لو فيه latitude و longitude موجودين، نجيب اسم المكان
    if (latitude!.isNotEmpty && longitude!.isNotEmpty) {
      _setLocationName(double.parse(latitude!), double.parse(longitude!));
    }
  }

  Future<void> _setLocationName(double lat, double lon) async {
    String locationName = await getLocationName(lat: lat, lon: lon);
    setState(() {
      _eventLocation.text = locationName;
    });
  }

  TimeOfDay? _stringToTimeOfDay(String? timeStr) {
    if (timeStr == null || timeStr.isEmpty) return null;
    final parts = timeStr.split(':');
    if (parts.length != 2) return null;
    return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
  }


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<managerCubit, ManagerStates>(
      listener: (context, state) {
        if (state is UpdateExperienceSuccess) _showAwesomeDialog(context);
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.13,
                width: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/top bar.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * .06,
                  right: 8,
                  left: 8,
                ),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: const Icon(Icons.arrow_back_ios_outlined,
                                color: Color(0xff185A3F), size: 20),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            "edit_experiment".tr(),
                            style: const TextStyle(
                              color: Color(0xff207954),
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              DefaultFormField(
                                onTap: () => _selectTime(context),
                                readOnly: true,
                                label: "selectTime".tr(),
                                controller: _eventTime,
                                type: TextInputType.text,
                                validate: (value) =>
                                value!.isEmpty ? 'Required'.tr() : null,
                                suffix: Icons.timer,
                              ),
                              const SizedBox(height: 20),
                              DefaultFormField(
                                onTap: () => _selectDate(context),
                                readOnly: true,
                                label: "selectDate".tr(),
                                controller: _eventDate,
                                type: TextInputType.text,
                                validate: (value) =>
                                value!.isEmpty ? 'Required'.tr() : null,
                                suffix: Icons.calendar_month_outlined,
                              ),
                              const SizedBox(height: 20),
                              DefaultFormField(
                                onTap: () => _navigateToMapPage(context),
                                readOnly: true,
                                label: "experience_location".tr(),
                                controller: _eventLocation,
                                type: TextInputType.text,
                                validate: (value) =>
                                value!.isEmpty ? 'Required'.tr() : null,
                                suffix: Icons.location_on_outlined,
                              ),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.45),
                              GestureDetector(
                                onTap: (state is UpdateExperienceLoading)
                                    ? null
                                    : () async {
                                  if (formKey.currentState!.validate()) {
                                    await context
                                        .read<managerCubit>()
                                        .updateExperience(
                                      experienceId: widget.model.id!,
                                      appointment: _eventDate.text,
                                      fromTime: convertTimeOfDayTo24(
                                          firstTime!),
                                      toTime: convertTimeOfDayTo24(
                                          secondTime!),
                                      latitude: latitude!,
                                      longitude: longitude!,
                                    );

                                    _eventDate.clear();
                                    _eventTime.clear();
                                    _eventLocation.clear();
                                  }
                                },
                                child: Button_default(
                                  height: 56,
                                  title: "save_changes".tr(),
                                  color: const Color(0xff207954),
                                ),
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  String convertTimeOfDayTo24(TimeOfDay time) {
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

      String locationName = await getLocationName(
        lat: result['latitude']!,
        lon: result['longitude']!,
      );

      setState(() {
        _eventLocation.text = locationName;
      });
    } else {
      // لو المستخدم لم يختار موقع جديد
      latitude ??= widget.model.latitude?.toString();
      longitude ??= widget.model.longitude?.toString();
      //  _eventLocation.text = widget.model.locationName ?? '';
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final pickedFirstTime = await showTimePicker(
      helpText: "start_time".tr(),
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedFirstTime != null) {
      firstTime = pickedFirstTime;

      final pickedSecondTime = await showTimePicker(
        helpText: "end_time".tr(),
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (pickedSecondTime != null) {
        secondTime = pickedSecondTime;
        _eventTime.text =
        "${"from".tr()}: ${firstTime!.format(context)}   ${"to".tr()}: ${secondTime!.format(context)}";
      }
    }
  }


  Future<void> _selectDate(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      appointmentDate = pickedDate;
      // ✅ تنسيق التاريخ بالشكل المطلوب: 2024-10-08
      final formattedDate = DateFormat('yyyy-MM-dd').format(appointmentDate!);
      _eventDate.text = formattedDate;
    }
  }


  Future<String> getLocationName(
      {required double lat, required double lon}) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(lat, lon);

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        return "${place.locality}, ${place.country}";
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
    dialogType: DialogType.success,
    animType: AnimType.leftSlide,
    title: 'success'.tr(),
    desc: 'changes_saved_successfully'.tr(),
    btnOkOnPress: () {},
  ).show();
}