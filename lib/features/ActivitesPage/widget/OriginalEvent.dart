import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../data/Local/sharedPref/sharedPref.dart';
import '../../home/data/manager/cubit/home_cubit.dart';
import '../../home/presentation/editEvent.dart';
import '../data/manager/cubit/activities_cubit.dart';
import '../data/models/activityModel.dart'; // ✅ غيّر المسار حسب مكان CacheHelper عندك

class OriginalActivityWidget extends StatelessWidget {
  final EventModel eventModel;

  const OriginalActivityWidget(this.eventModel, {super.key});

  @override
  Widget build(BuildContext context) {
    // ✅ قراءة الدور (role) من SharedPreferences
    final String? role = CacheHelper.getData(key: "roles");
    final bool isAdmin = role == "Admin";
    DateTime? fromDate = eventModel.fromDay != null
        ? DateTime.tryParse(eventModel.fromDay)
        : null;
    DateTime? toDate =
        eventModel.toDay != null ? DateTime.tryParse(eventModel.toDay) : null;

    String formattedDate = fromDate != null
        ? DateFormat(
                'EEEE d MMMM', Localizations.localeOf(context).languageCode)
            .format(fromDate)
        : "";

    String timeRange = "";
    if (eventModel.fromTime != null && eventModel.toTime != null) {
      timeRange = "${eventModel.fromTime} - ${eventModel.toTime}";
    }

    return Card(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Stack(
          children: [
            /// ✅ المحتوى الرئيسي
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: (eventModel.img != null &&
                          eventModel.img.trim().isNotEmpty)
                      ? Image.network(
                          eventModel.img,
                          height: 180,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            // لو فشل التحميل من الإنترنت
                            return Container(
                              height: 180,
                              width: double.infinity,
                              color: Color(0xff185A3F), // خلفية خضراء
                              child: const Center(
                                child: Icon(
                                  Icons.block, // أيقونة علامة الحجب
                                  color: Colors.white,
                                  size: 50,
                                ),
                              ),
                            );
                          },
                        )
                      : Container(
                          height: 180,
                          width: double.infinity,
                          color: Color(0xff185A3F), // خلفية خضراء
                          child: const Center(
                            child: Icon(
                              Icons
                                  .warning_amber_outlined, // أيقونة علامة الحجب
                              color: Colors.white,
                              size: 50,
                            ),
                          ),
                        ),
                ),
                const SizedBox(height: 8),
                Text(
                  eventModel.name ?? "",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.green[900],
                  ),
                ),
                const SizedBox(height: 6),
                if (eventModel.location != null)
                  Row(
                    children: [
                      Icon(Icons.location_on,
                          size: 16, color: Colors.grey[600]),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          eventModel.location,
                          style:
                              TextStyle(fontSize: 14, color: Colors.grey[700]),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                const SizedBox(height: 6),
                if (formattedDate.isNotEmpty || timeRange.isNotEmpty)
                  Row(
                    children: [
                      Icon(Icons.calendar_today,
                          size: 16, color: Colors.grey[600]),
                      const SizedBox(width: 4),
                      Text(
                        formattedDate,
                        style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                      ),
                      if (timeRange.isNotEmpty) ...[
                        const SizedBox(width: 10),
                        Icon(Icons.access_time,
                            size: 16, color: Colors.grey[600]),
                        const SizedBox(width: 4),
                        Text(
                          timeRange,
                          style:
                              TextStyle(fontSize: 14, color: Colors.grey[700]),
                        ),
                      ],
                    ],
                  ),
                const SizedBox(height: 6),
                if (eventModel.description != null)
                  Text(
                    eventModel.description,
                    style: TextStyle(fontSize: 14, color: Colors.grey[800]),
                  ),
                const SizedBox(height: 6),
                if (eventModel.notes != null)
                  Text(
                    eventModel.notes,
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
              ],
            ),

            /// ✅ أزرار الأدمن (تعديل / حذف)
            if (isAdmin)
              Positioned(
                  top: 5,
                  left: 5,
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {

                          _showDeleteDialog(context, eventModel.id);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(
                              4), // 👈 يقلل المسافة حوالين الأيقونة
                          constraints: const BoxConstraints(
                            minWidth: 36,
                            minHeight: 36,
                          ), // 👈 يخلي الفريم صغير وثابت
                          decoration: BoxDecoration(
                            color: Colors.red
                                .withOpacity(0.8), // 👈 لون خلفية قوي شوية
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.red.withOpacity(0.3),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.delete,
                            color: Colors.white,
                            size: 20, // 👈 أيقونة صغيرة ومتناسبة
                          ),
                        ),
                      ),

                      const SizedBox(width: 12),

                      // زر التعديل
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditActivityPage(eventModel: eventModel),
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(4), // يقلل المساحة حوالين الأيقونة
                          constraints: const BoxConstraints(
                            minWidth: 36,
                            minHeight: 36,
                          ), // حجم صغير وثابت
                          decoration: BoxDecoration(
                            color: Colors.blue.withOpacity(0.8),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.blue.withOpacity(0.3),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.edit,
                            color: Colors.white,
                            size: 20, // صغرنا الأيقونة كمان
                          ),
                        ),
                      )


                      // زر الحذف
                    ],
                  )),
          ],
        ),
      ),
    );
  }
  void _showDeleteDialog(BuildContext context, int eventId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("delete_activity_title".tr()), // 🔸 ترجمة لعنوان حذف الفاعلية
        content: Text("delete_activity".tr()), // 🔸 ترجمة نص الحذف
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("cancel".tr()),
          ),
          BlocConsumer<ActivitiesCubit, ActivitiesState>(
            listener: (context, state) {
              if (state is DeleteEventSuccess) {
                Navigator.pop(context); // إغلاق الـ Dialog
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("activity_deleted_success".tr())),
                );
              } else if (state is DeleteEventFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.errorMessage)),
                );
              }
            },
            builder: (context, state) {
              if (state is DeleteEventLoading) {
                return const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: CircularProgressIndicator(),
                );
              }

              return TextButton(
                onPressed: () {
                  context.read<ActivitiesCubit>().deleteEvent(id: eventId);
                },
                child: Text(
                  "delete".tr(),
                  style: const TextStyle(color: Colors.red),
                ),
              );
            },
          ),
        ],
      ),
    );
  }


}
