import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../ActivitesPage/data/manager/cubit/activities_cubit.dart';
import '../../ActivitesPage/data/models/activityModel.dart';

class EditActivityPage extends StatefulWidget {
  final EventModel eventModel;

  const EditActivityPage({super.key, required this.eventModel});

  @override
  State<EditActivityPage> createState() => _EditActivityPageState();
}

class _EditActivityPageState extends State<EditActivityPage> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  late TextEditingController locationController;
  late TextEditingController dateController;
  late TextEditingController fromTimeController;
  late TextEditingController toTimeController;

  DateTime? fromDate;
  DateTime? toDate;
  TimeOfDay? fromTime;
  TimeOfDay? toTime;
  File? pickedImage;

  @override
  void initState() {
    super.initState();

    titleController = TextEditingController(text: widget.eventModel.name);
    descriptionController = TextEditingController(text: widget.eventModel.description);
    locationController = TextEditingController(text: widget.eventModel.location);

    if (widget.eventModel.fromDay != null) {
      fromDate = DateTime.tryParse(widget.eventModel.fromDay);
    }
    if (widget.eventModel.toDay != null) {
      toDate = DateTime.tryParse(widget.eventModel.toDay);
    }

    if (widget.eventModel.fromTime != null) {
      final parts = widget.eventModel.fromTime.split(":");
      fromTime = TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
    }

    if (widget.eventModel.toTime != null) {
      final parts = widget.eventModel.toTime.split(":");
      toTime = TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
    }

    dateController = TextEditingController(
        text: (fromDate != null && toDate != null)
            ? "${DateFormat('yyyy-MM-dd').format(fromDate!)} إلى ${DateFormat('yyyy-MM-dd').format(toDate!)}"
            : "");

    // هنا نهيئ Controllers فارغة أولاً
    fromTimeController = TextEditingController();
    toTimeController = TextEditingController();

    // بعد انتهاء initState وتوفر context
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fromTimeController.text = fromTime?.format(context) ?? "";
      toTimeController.text = toTime?.format(context) ?? "";
    });
  }


  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        pickedImage = File(image.path);
      });
    }
  }

  Future<void> pickDate() async {
    final pickedFrom = await showDatePicker(
      context: context,
      initialDate: fromDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedFrom != null) {
      final pickedTo = await showDatePicker(
        context: context,
        initialDate: toDate ?? pickedFrom,
        firstDate: pickedFrom,
        lastDate: DateTime(2100),
      );

      if (pickedTo != null) {
        setState(() {
          fromDate = pickedFrom;
          toDate = pickedTo;
          dateController.text =
          "${DateFormat('yyyy-MM-dd').format(fromDate!)} إلى ${DateFormat('yyyy-MM-dd').format(toDate!)}";
        });
      }
    }
  }

  Future<void> pickTime({required bool isFrom}) async {
    final initialTime = isFrom ? fromTime ?? TimeOfDay.now() : toTime ?? TimeOfDay.now();
    final picked = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );
    if (picked != null) {
      setState(() {
        if (isFrom) {
          fromTime = picked;
          fromTimeController.text = fromTime!.format(context);
        } else {
          toTime = picked;
          toTimeController.text = toTime!.format(context);
        }
      });
    }
  }

  String formatTimeForApi(TimeOfDay? time, String? originalTime) {
    if (time != null) {
      // تحويل TimeOfDay إلى HH:mm
      return "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}";
    }
    if (originalTime != null && originalTime.isNotEmpty) {
      // لو الوقت موجود من الـ model ممكن يكون بصيغة AM/PM أو م/ص
      final lower = originalTime.toLowerCase().trim();
      if (lower.contains('م') || lower.contains('pm')) {
        final parts = lower.replaceAll(RegExp(r'[مapm\s:]'), ' ').split(' ');
        int hour = int.parse(parts[0]);
        int minute = parts.length > 1 ? int.parse(parts[1]) : 0;
        if (hour < 12) hour += 12;
        return "${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}";
      } else if (lower.contains('ص') || lower.contains('am')) {
        final parts = lower.replaceAll(RegExp(r'[صapm\s:]'), ' ').split(' ');
        int hour = int.parse(parts[0]);
        int minute = parts.length > 1 ? int.parse(parts[1]) : 0;
        if (hour == 12) hour = 0;
        return "${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}";
      }
      return originalTime; // لو الوقت أصلاً 24 ساعة
    }
    return "";
  }

  void saveChanges() {
    final id = widget.eventModel.id ?? 0;
    final name = titleController.text.trim().isNotEmpty
        ? titleController.text.trim()
        : widget.eventModel.name ?? "";
    final description = descriptionController.text.trim().isNotEmpty
        ? descriptionController.text.trim()
        : widget.eventModel.description ?? "";
    final location = locationController.text.trim().isNotEmpty
        ? locationController.text.trim()
        : widget.eventModel.location ?? "";

    final fromDay = fromDate != null
        ? DateFormat('yyyy-MM-dd').format(fromDate!)
        : widget.eventModel.fromDay;
    final toDay = toDate != null
        ? DateFormat('yyyy-MM-dd').format(toDate!)
        : widget.eventModel.toDay;

    final fromTimeStr = formatTimeForApi(fromTime, widget.eventModel.fromTime);
    final toTimeStr = formatTimeForApi(toTime, widget.eventModel.toTime);

    print("id: ${id}");
    print("name: ${name}");
    print("description: ${description}");
    print("location: ${location}");
    print("fromDay: ${fromDay}");
    print("toDay: ${toDay}");
    print("fromTime: ${fromTimeStr}");
    print("toTime: ${toTimeStr}");
    print("img: ${widget.eventModel.img}");

    context.read<ActivitiesCubit>().editEvent(
      id: id,
      name: name,
      description: description,
      location: location,
      fromDay: fromDay,
      toDay: toDay,
      fromTime: fromTimeStr,
      toTime: toTimeStr,
      image: pickedImage,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("تعديل الفاعلية"),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            GestureDetector(
              onTap: pickImage,
              child: Container(
                height: 180,
                width: double.infinity,
                decoration: BoxDecoration(
                  color:  Color(0xff185A3F),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey, width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                  image: pickedImage != null
                      ? DecorationImage(
                    image: FileImage(pickedImage!),
                    fit: BoxFit.cover,
                  )
                      : (widget.eventModel.img != null &&
                      widget.eventModel.img.isNotEmpty
                      ? DecorationImage(
                    image: NetworkImage(widget.eventModel.img),
                    fit: BoxFit.cover,
                  )
                      : null),
                ),
                child: pickedImage == null &&
                    (widget.eventModel.img == null ||
                        widget.eventModel.img.isEmpty)
                    ? const Center(
                  child: Icon(Icons.warning_amber_outlined, size: 50, color: Colors.white),
                )
                    : null,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: "العنوان",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: Color(0xff185A3F), width: 2),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: Color(0xff185A3F), width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: Color(0xff185A3F), width: 2),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: descriptionController,
              maxLines: 3,
              decoration: InputDecoration(
                labelText: "الوصف",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: Color(0xff185A3F), width: 2),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: Color(0xff185A3F), width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: Color(0xff185A3F), width: 2),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: locationController,
              decoration: InputDecoration(
                labelText: "المكان",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: Color(0xff185A3F), width: 2),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: Color(0xff185A3F), width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: Color(0xff185A3F), width: 2),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              readOnly: true,
              controller: dateController,
              decoration: InputDecoration(
                labelText: "التاريخ",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: Color(0xff185A3F), width: 2),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: Color(0xff185A3F), width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: Color(0xff185A3F), width: 2),
                ),
              ),
              onTap: pickDate,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: fromTimeController,
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: "من وقت",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(color: Color(0xff185A3F), width: 2),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(color: Color(0xff185A3F), width: 2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(color: Color(0xff185A3F), width: 2),
                      ),
                    ),
                    onTap: () => pickTime(isFrom: true),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: toTimeController,
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: "إلى وقت",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(color: Color(0xff185A3F), width: 2),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(color: Color(0xff185A3F), width: 2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(color: Color(0xff185A3F), width: 2),
                      ),
                    ),
                    onTap: () => pickTime(isFrom: false),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            GestureDetector(
              onTap: saveChanges,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: const Color(0xff185A3F),
                  borderRadius: BorderRadius.circular(50),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: const Text(
                  "حفظ التعديلات",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
