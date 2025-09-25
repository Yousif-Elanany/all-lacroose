import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OriginalActivityWidget extends StatelessWidget {
  final dynamic eventModel; // يمكن تغييره إلى نوع محدد إذا كان لديك Model

  const OriginalActivityWidget(this.eventModel, {super.key});

  @override
  Widget build(BuildContext context) {
    // تحويل التاريخ من String إلى DateTime
    DateTime? fromDate =
    eventModel.fromDay != null ? DateTime.tryParse(eventModel.fromDay) : null;
    DateTime? toDate =
    eventModel.toDay != null ? DateTime.tryParse(eventModel.toDay) : null;

    String formattedDate = fromDate != null
        ? DateFormat('EEEE d MMMM', Localizations.localeOf(context).languageCode)
        .format(fromDate)
        : "";

    String timeRange = "";
    if (eventModel.fromTime != null && eventModel.toTime != null) {
      timeRange = "${eventModel.fromTime} - ${eventModel.toTime}";
    }

    return Card(
      color: Colors.white,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // الصورة
            if (eventModel.img != null && eventModel.img.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  eventModel.img,
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 180,
                      color: Colors.grey[300],
                      child: Center(child: Icon(Icons.image, size: 50)),
                    );
                  },
                ),
              ),
            SizedBox(height: 8),
            // الاسم
            Text(
              eventModel.name ?? "",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.green[900]),
            ),
            SizedBox(height: 6),
            // الموقع
            if (eventModel.location != null)
              Row(
                children: [
                  Icon(Icons.location_on, size: 16, color: Colors.grey[600]),
                  SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      eventModel.location,
                      style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            SizedBox(height: 6),
            // التاريخ والوقت
            if (formattedDate.isNotEmpty || timeRange.isNotEmpty)
              Row(
                children: [
                  Icon(Icons.calendar_today, size: 16, color: Colors.grey[600]),
                  SizedBox(width: 4),
                  Text(
                    formattedDate,
                    style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                  ),
                  if (timeRange.isNotEmpty) ...[
                    SizedBox(width: 10),
                    Icon(Icons.access_time, size: 16, color: Colors.grey[600]),
                    SizedBox(width: 4),
                    Text(
                      timeRange,
                      style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                    ),
                  ],
                ],
              ),
            SizedBox(height: 6),
            // الوصف
            if (eventModel.description != null)
              Text(
                eventModel.description,
                style: TextStyle(fontSize: 14, color: Colors.grey[800]),
              ),
            SizedBox(height: 6),
            // الملاحظات
            if (eventModel.notes != null)
              Text(
                eventModel.notes,
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
            // SizedBox(height: 10),
            // // زر الخريطة
            // if (eventModel.mapLink != null && eventModel.mapLink.isNotEmpty)
            //   GestureDetector(
            //     onTap: () async {
            //       // استخراج رابط Google Maps من iframe
            //
            //     },
            //     child: Container(
            //       width: double.infinity,
            //       padding: EdgeInsets.symmetric(vertical: 12),
            //       decoration: BoxDecoration(
            //           color: Colors.green[100],
            //           borderRadius: BorderRadius.circular(8)),
            //       child: Center(
            //         child: Text(
            //           "View Map",
            //           style: TextStyle(
            //               color: Colors.green[900], fontWeight: FontWeight.bold),
            //         ),
            //       ),
            //     ),
            //   ),
          ],
        ),
      ),
    );
  }
}
