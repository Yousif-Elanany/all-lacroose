import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:lacrosse/features/ActivitesPage/data/models/InternalEvent.dart';
import '../../../data/Local/sharedPref/sharedPref.dart';
import '../data/manager/cubit/activities_cubit.dart';
import '../widget/customCarouselSlider.dart';
import '../widget/textFeild_default.dart';
import 'LoginattendencePage.dart';
import '../../auth/widgets/button_default.dart';

class ActivityDetailScreen extends StatefulWidget {
  final int eventID;

  ActivityDetailScreen(this.eventID);

  @override
  State<ActivityDetailScreen> createState() => _ActivityDetailScreenState();
}

class _ActivityDetailScreenState extends State<ActivityDetailScreen> {
  InternalEventModel? event;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<ActivitiesCubit>().getInternalEventDataById(widget.eventID);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<ActivitiesCubit, ActivitiesState>(
        listener: (context, state) {
          if (state is AddInternalEventReservationSuccess) {
            _showAwesomeDialog(context);
          } else if (state is InternalEventByIdSuccess) {
            event = state.internalEventData;
          } else if (state is AddInternalEventReservationFailure) {
            _showAwesomeErrorDialog(context, state.errorMessage);
          } else if (state is DeleteInternalEventSuccess) {
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          if (state is InternalEventByIdLoading || event == null) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.green),
            );
          } else {
            return Column(
              children: [
                Stack(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.13,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.green.shade900, Colors.green.shade700],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                          image: const DecorationImage(
                            image: AssetImage('assets/images/top bar.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 57),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.6),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(
                                Icons.arrow_back_ios_outlined,
                                color: Color(0xff185A3F),
                                size: 20,
                              ),
                            ),
                          ),
                          Text(
                            "activitiesDetail".tr(),
                            style: const TextStyle(
                              color: Color(0xff185A3F),
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          CacheHelper.getData(key: "roles") == "Admin"
                              ? GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text("تأكيد الحذف"),
                                  content: Text("هل أنت متأكد من رغبتك في الحذف؟"),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: Text("رجوع"),
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                        Navigator.pop(context);
                                        await context
                                            .read<ActivitiesCubit>()
                                            .deleteInternalEvent(widget.eventID);
                                      },
                                      child: Text("تأكيد"),
                                    ),
                                  ],
                                ),
                              );
                            },
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                color: Colors.red.withOpacity(0.6),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(
                                Icons.delete_outline,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          )
                              : const SizedBox(width: 40),
                        ],
                      ),
                    ),
                  ],
                ),
                MediaCarousel(
                  mediaUrls: event!.internalEventFiles.isNotEmpty
                      ? event!.internalEventFiles
                      .where((model) => model.file != null)
                      .map((file) => file.file)
                      .toList()
                      : [
                    "http://app774.uat.toq.sa/LacrosseApi/Images/InternalEventImage/f6ceb9a8-ce11-4689-a7ac-51586c2e3290.png"
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12, right: 12, top: 20, bottom: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        event!.eventName,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Icon(Icons.calendar_month_outlined,
                                        size: 16, color: Color(0xff207954)),
                                    const SizedBox(width: 5.0),
                                    Expanded(
                                      child: Text(
                                        DateFormat('yyyy-MM-dd').format(event!.from),
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Color(0xff207954),
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  children: [
                                    const Icon(Icons.location_on_outlined,
                                        size: 16, color: Colors.grey),
                                    const SizedBox(width: 5.0),
                                    Expanded(
                                      child: Text(
                                        event!.eventLocation.toString(),
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Icon(Icons.access_time,
                                        size: 16, color: Colors.grey),
                                    const SizedBox(width: 8.0),
                                    Expanded(
                                      child: Text(
                                        "${DateFormat('hh:mm a').format(event!.to ?? DateTime.now())} - ${DateFormat('hh:mm a').format(event!.from)}",
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  children: [
                                    const Icon(Icons.groups,
                                        size: 16, color: Colors.grey),
                                    const SizedBox(width: 4.0),
                                    Expanded(
                                      child: Text(
                                        "${event!.applicationUserInternalEvents.length}",
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const Divider(thickness: 0.5, color: Colors.grey),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          event!.description.toString(),
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                if (CacheHelper.getData(key: "roles") == "Admin")
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        navigateTo(
                          context,
                          AttendanceScreen(eventid: event!.id),
                        );
                      },
                      child: Container(
                        width: double.infinity,
                        height: 40,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color(0xff207954),
                            width: 1.0,
                          ),
                          color: Colors.white,
                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Center(
                          child: Text(
                            "checkAttendance".tr(),
                            style: const TextStyle(
                              fontSize: 14,
                              color: Color(0xff207954),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                if (CacheHelper.getData(key: "roles") == "Visitor")
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () => showCustomBottomSheet(context),
                      child: Container(
                        width: double.infinity,
                        height: 40,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color(0xff207954),
                            width: 1.0,
                          ),
                          color: Colors.white,
                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Center(
                          child: Text(
                            "ReserveSeat".tr(),
                            style: const TextStyle(
                              fontSize: 14,
                              color: Color(0xff207954),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                const SizedBox(height: 20),
              ],
            );
          }
        },
      ),
    );
  }

  void showCustomBottomSheet(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AnimatedPadding(
              duration: const Duration(milliseconds: 250),
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Container(
                height: 370,
                width: double.infinity,
                decoration: BoxDecoration(
                  boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.2), blurRadius: 6, offset: const Offset(0, 1))],
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
                ),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: const Image(
                        image: AssetImage("assets/images/sheet.jpeg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                    Form(
                      key: formKey,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(height: 29),
                              Text(
                                "confirmReservation".tr(),
                                style: const TextStyle(
                                  color: Color(0xff207954),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 15),
                              DefaultFormField(
                                label: "name".tr(),
                                controller: _nameController,
                                type: TextInputType.text,
                                validate: (value) => value!.isEmpty ? 'Required'.tr() : null,
                              ),
                              const SizedBox(height: 20),
                              DefaultFormField(
                                label: "phone_number".tr(),
                                controller: _phoneController,
                                type: TextInputType.phone,
                                validate: (value) => value!.isEmpty ? 'Required'.tr() : null,
                              ),
                              const SizedBox(height: 20),
                              BlocBuilder<ActivitiesCubit, ActivitiesState>(
                                builder: (context, state) {
                                  if (state is AddExperienceReservationLoading) {
                                    return Button_default(
                                      height: 56,
                                      title: "confirmReservation".tr(),
                                      color: const Color(0xff207954),
                                      colortext: Colors.white,
                                    );
                                  }
                                  return GestureDetector(
                                    onTap: () {
                                      if (formKey.currentState!.validate()) {
                                        context.read<ActivitiesCubit>().addInternalEventReservation(
                                          internalEventId: widget.eventID,
                                          name: _nameController.text,
                                          phoneNumber: _phoneController.text,
                                        );
                                        Navigator.pop(context);
                                        _nameController.clear();
                                        _phoneController.clear();
                                      }
                                    },
                                    child: Button_default(
                                      height: 56,
                                      title: "confirmReservation".tr(),
                                      color: const Color(0xff207954),
                                      colortext: Colors.white,
                                    ),
                                  );
                                },
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _showAwesomeDialog(BuildContext context) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.leftSlide,
      title: 'success'.tr(),
      desc: 'Gob_done_successfully'.tr(),
      btnOkOnPress: () {},
    ).show();
  }

  void _showAwesomeErrorDialog(BuildContext context, text) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      animType: AnimType.leftSlide,
      title: 'error'.tr(),
      desc: text.toString(),
      btnOkOnPress: () {},
    ).show();
  }
}

void navigateTo(context, widget) => Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => widget),
);
