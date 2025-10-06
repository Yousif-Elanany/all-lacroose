import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../data/models/matchModel.dart';

class MatchWidget extends StatelessWidget {
  MatchWidget({
    super.key,
    required this.matchList,
    required this.index
  });

  final List<MatchModel> matchList;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.7, // ✅ عرض ثابت يمنع الخروج
      height: 150,
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12.0),
      ),
      clipBehavior: Clip.hardEdge, // ✅ يمنع أي عنصر يخرج بره البوكس
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center, // ✅ توازن عمودي
          children: [
            // ✅ الفريق الأول
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  matchList[index].firstTeamName,
                  style:  TextStyle(fontSize: 14),
                  maxLines: 2, // ✅ سطر واحد فقط
                  overflow: TextOverflow.clip, // ✅ يمنع النص الطويل يخرج
                  softWrap: false, // ✅ يمنع اللف للسطر الجديد
                  textAlign: TextAlign.center, // ✅ النص في المنتصف
                ),
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.white,
                  child: ClipOval(
                    child: matchList[index].firstTeamImage.isNotEmpty
                        ? Image.network(
                      matchList[index].firstTeamImage,
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          Image.asset("assets/images/c2.png",
                              width: 80, height: 80, fit: BoxFit.cover),
                    )
                        : Image.asset("assets/images/c2.png",
                        width: 80, height: 80, fit: BoxFit.cover),
                  ),
                ),
                const SizedBox(height: 6.0),
                Text(
                  matchList[index].totalFirstTeamGoals.toString(),
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 6.0),
                Row(
                  children: [
                    Text(
                      DateFormat("a h:mm").format(matchList[index].appointment),
                      overflow: TextOverflow.fade, // ✅ يمنع النص الطويل يخرج

                      style: const TextStyle(fontSize: 10, color: Colors.grey),
                    ),
                    const Icon(Icons.access_time_outlined,
                        size: 12, color: Colors.grey),
                  ],
                ),
              ],
            ),

            // ✅ النص VS
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text('VS',
                  style: const TextStyle(fontSize: 16, color: Colors.grey)),
            ),

            // ✅ الفريق الثاني
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  matchList[index].secondTeamName,
                  style: const TextStyle(fontSize: 12),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6.0),
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.white,
                  child: ClipOval(
                    child: matchList[index].secondTeamImage.isNotEmpty
                        ? Image.network(
                      matchList[index].secondTeamImage,
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          Image.asset("assets/images/c2.png",
                              width: 80, height: 80, fit: BoxFit.cover),
                    )
                        : Image.asset("assets/images/c2.png",
                        width: 80, height: 80, fit: BoxFit.cover),
                  ),
                ),
                const SizedBox(height: 6.0),
                Text(
                  matchList[index].totalSecondTeamGoals.toString(),
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 6.0),
                Row(
                  children: [
                    Text(
                      DateFormat("MMM d").format(matchList[index].appointment),
                      overflow: TextOverflow.ellipsis, // ✅ يمنع النص الطويل يخرج

                      style: const TextStyle(fontSize: 10, color: Colors.grey),
                    ),
                    const Icon(Icons.calendar_month_outlined,
                        size: 12, color: Colors.grey),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );

  }
}