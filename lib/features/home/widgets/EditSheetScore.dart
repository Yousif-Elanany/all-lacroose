import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lacrosse/features/home/data/manager/cubit/home_cubit.dart';
import 'package:lacrosse/features/home/data/models/matchModel.dart';

void showScoreInputSheet(
    BuildContext context, MatchModel match, HomeCubit cubit) {
  final TextEditingController team1Controller =
      TextEditingController(text: match.totalFirstTeamGoals.toString() ?? "");
  final TextEditingController team2Controller =
      TextEditingController(text: match.totalSecondTeamGoals.toString() ?? "");

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) => Padding(
      padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          top: 20,
          left: 20,
          right: 20),
      child: BlocConsumer<HomeCubit, HomeStates>(
        bloc: cubit,
        listener: (context, state) {
          if (state is EditMatchSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  "Gob_done_successfully".tr(),
                  style: const TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.green.shade600, // ✅ أخضر للنجاح
                behavior: SnackBarBehavior.floating,
                margin: const EdgeInsets.all(10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                duration: const Duration(seconds: 2),
              ),
            );
            Navigator.pop(context); // إغلاق الشيت بعد النجاح
          } else if (state is EditMatchFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.errorMessage,
                  style: const TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.red.shade600, // ❌ أحمر للفشل
                behavior: SnackBarBehavior.floating,
                margin: const EdgeInsets.all(10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                duration: const Duration(seconds: 2),
              ),
            );
          }

        },
        builder: (context, state) {
          final isLoading = state is EditMatchLoading;
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "EditScores".tr(),
                style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold,
                  color: Color(0xff185A3F), // اللون الأخضر
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: team1Controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "${match.firstTeamName}",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: team2Controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "${match.secondTeamName}",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              isLoading
                  ? CircularProgressIndicator()
                  : SizedBox(
                      width: double.infinity, // كامل عرض الشيت
                      height: 50, // ارتفاع الزر
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xff185A3F), // اللون الأخضر
                          foregroundColor: Colors.white, // لون النص أبيض
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(8), // زوايا مستديرة
                          ),
                        ),
                        onPressed: () {
                          final team1Goals =
                              int.tryParse(team1Controller.text) ?? 0;
                          final team2Goals =
                              int.tryParse(team2Controller.text) ?? 0;
                          cubit.editMatchScoresData(
                            id: match.id,
                            totalFirstTeamGoals: team1Goals,
                            totalSecondTeamGoals: team2Goals,
                            appointment:
                                DateTime.now().toUtc().toIso8601String(),
                          );
                        },
                        child: Text(
                          "confirm".tr(),
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
              SizedBox(height: 20),
            ],
          );
        },
      ),
    ),
  );
}
