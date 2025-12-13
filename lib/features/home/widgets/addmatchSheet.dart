import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:easy_localization/easy_localization.dart';
import '../data/manager/cubit/home_cubit.dart';
import '../data/models/model_team.dart';

void showMatchBottomSheet(
  BuildContext context, {
  List<teamModels>? model,
}) {
  // Convert list to Map containing id and name
  final List<Map<String, dynamic>> teams = model != null && model.isNotEmpty
      ? model
          .map((e) => {'id': e.id, 'name': e.name ?? 'unknown_team'.tr()})
          .toList()
      : [
          {'id': 1, 'name': 'ahly'.tr()},
          {'id': 2, 'name': 'zamalek'.tr()},
          {'id': 3, 'name': 'ittihad'.tr()},
          {'id': 4, 'name': 'pyramids'.tr()},
        ];

  Map<String, dynamic>? teamA;
  Map<String, dynamic>? teamB;
  final TextEditingController goalsAController = TextEditingController();
  final TextEditingController goalsBController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  DateTime? selectedDateTime;

  Future<void> pickDateTime(
      BuildContext context, Function(void Function()) setState) async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      locale: context.locale,
    );
    if (date == null) return;

    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (time == null) return;

    selectedDateTime = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );

    final formatted =
        DateFormat('yyyy-MM-dd HH:mm:ss').format(selectedDateTime!);

    setState(() {
      dateController.text = formatted;
    });
  }

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
              top: 16,
              left: 16,
              right: 16,
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'add_match'.tr(),
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),

                  // Teams
                  Row(
                    children: [
                      Expanded(
                        child: DropdownButtonFormField<Map<String, dynamic>>(
                          isExpanded: true,
                          decoration: InputDecoration(
                            labelText: 'team_a'.tr(),
                            border: const OutlineInputBorder(),
                          ),
                          value: teamA,
                          items: teams
                              .map(
                                (t) => DropdownMenuItem<Map<String, dynamic>>(
                                  value: t,
                                  child: Text(
                                    t['name'],
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: (v) => setState(() => teamA = v),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: DropdownButtonFormField<Map<String, dynamic>>(
                          isExpanded: true,
                          decoration: InputDecoration(
                            labelText: 'team_b'.tr(),
                            border: const OutlineInputBorder(),
                          ),
                          value: teamB,
                          items: teams
                              .map(
                                (t) => DropdownMenuItem<Map<String, dynamic>>(
                                  value: t,
                                  child: Text(
                                    t['name'],
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: (v) => setState(() => teamB = v),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // Goals
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: goalsAController,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          decoration: InputDecoration(
                            labelText: 'team_a_goals'.tr(),
                            border: const OutlineInputBorder(),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextField(
                          controller: goalsBController,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          decoration: InputDecoration(
                            labelText: 'team_b_goals'.tr(),
                            border: const OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // Date & Time
                  TextField(
                    controller: dateController,
                    readOnly: true,
                    onTap: () => pickDateTime(context, setState),
                    decoration: InputDecoration(
                      labelText: 'match_date_time'.tr(),
                      border: const OutlineInputBorder(),
                      suffixIcon: const Icon(Icons.calendar_today),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Buttons
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            if (teamA == null ||
                                teamB == null ||
                                goalsAController.text.isEmpty ||
                                goalsBController.text.isEmpty ||
                                selectedDateTime == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('please_enter_all_data'.tr()),
                                ),
                              );
                              return;
                            }

                            final String formattedDate =
                                selectedDateTime!.toUtc().toIso8601String();

                            final data = {
                              'teamA_id': teamA?['id'],
                              'teamB_id': teamB?['id'],
                              'goalsA': int.tryParse(goalsAController.text),
                              'goalsB': int.tryParse(goalsBController.text),
                              'match_date': formattedDate,
                            };

                            context.read<HomeCubit>().addMatch(
                                  matchDate: data['match_date'],
                                  teamNum1Id: data['teamA_id'],
                                  teamNum2Id: data['teamB_id'],
                                  teamNum1Goals: data['goalsA'],
                                  teamNum2Goals: data['goalsB'],
                                );

                            Navigator.pop(context);
                          },
                          child: Text('save'.tr()),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text('cancel'.tr()),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}
