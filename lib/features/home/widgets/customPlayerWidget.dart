import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lacrosse/features/home/data/models/PlayerModel.dart';
import 'package:lacrosse/features/home/presentation/EditPlayerScreen.dart';

import '../../auth/pressntation/loginPage.dart';
import '../../eventsPage/data/manager/cubit/manager_cubit.dart';

class Customplayerwidget extends StatefulWidget {
  PlayerModel userModel;

  // Constructor
  Customplayerwidget(this.userModel);

  @override
  State<Customplayerwidget> createState() => _CustomplayerWidgetState();
}

class _CustomplayerWidgetState extends State<Customplayerwidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: GestureDetector(
          onTap: () {
            navigateTo(
                context,
                EditPlayerScreen(
                  playerId: widget.userModel.id,
                ));
          },
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  blurRadius: 5,
                  offset: Offset(0, 2),
                ),
              ],
              border: Border.all(
                color: Colors.grey.withOpacity(.2),
                width: 1,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 22,
                        backgroundColor: Colors.white,
                        child: ClipOval(
                          child: Image.network(
                            widget.userModel.image,
                            fit: BoxFit.cover,
                            width: 44, // نفس القطر (radius * 2)
                            height: 44, // نفس القطر (radius * 2)
                            errorBuilder: (BuildContext context, Object error,
                                StackTrace? stackTrace) {
                              return Center(
                                child: Image.asset(
                                  'assets/images/reg.png',
                                  height: 44, // نفس القطر
                                  width: 44, // نفس القطر
                                  fit: BoxFit.cover,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        widget.userModel.displayName,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.flag_outlined,
                                    size: 16, color: Colors.grey),
                                SizedBox(width: 5),
                                Text("club_n".tr(),
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.grey)),
                                Expanded(
                                  child: Text(
                                    widget.userModel.nameOfTeam ?? "غير معروف",
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.grey),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Icon(Icons.calendar_month_outlined,
                                    size: 16, color: Colors.grey),
                                SizedBox(width: 5),
                                Text("birth_date".tr(),
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.grey)),
                                Expanded(
                                  child: Text(
                                    formatDate(widget.userModel.birthDate),
                                    //   widget.userReq.birthDate ?? "غير معروف",
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.grey),
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
                                Icon(Icons.language,
                                    size: 16, color: Colors.grey),
                                SizedBox(width: 8),
                                Text("nationality1".tr(),
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.grey)),
                                Expanded(
                                  child: Text(
                                    widget.userModel.nameOfNationality ??
                                        "غير معروف",
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.grey),
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
                  const SizedBox(height: 12),
                ],
              ),
            ),
          ),
        ),
      ),
    ]);
  }

  String formatDate(String inputDate) {
    // تحويل النص إلى كائن DateTime
    DateTime date = DateTime.parse(inputDate);

    // تحديد تنسيق التاريخ المطلوب
    String formattedDate = DateFormat('d MMMM yyyy', 'ar').format(date);

    return formattedDate;
  }
}
