import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lacrosse/data/Local/sharedPref/sharedPref.dart';
import 'package:lacrosse/features/home/data/manager/cubit/home_cubit.dart';
import 'package:lacrosse/features/home/data/models/PlayerModel.dart';
import 'package:lacrosse/features/home/presentation/EditPlayerScreen.dart';

import '../../../order/widgets/buildOrder.dart';

class Customplayerwidget extends StatefulWidget {
  final PlayerModel userModel;

  const Customplayerwidget(this.userModel, {super.key});

  @override
  State<Customplayerwidget> createState() => _CustomplayerWidgetState();
}

class _CustomplayerWidgetState extends State<Customplayerwidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        /// 🔹 الكارت الأساسي
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: GestureDetector(
            onTap: () {
              // if (CacheHelper.getData(key: "roles") == "Admin") {
              //   navigateTo(
              //     context,
              //     EditPlayerScreen(
              //       playerId: widget.userModel.id,
              //     ),
              //   );
              // }
            },
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Colors.grey.withOpacity(.2),
                  width: 1,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
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
                              width: 44,
                              height: 44,
                              errorBuilder: (context, error, stackTrace) {
                                return Image.asset(
                                  'assets/images/reg.png',
                                  height: 44,
                                  width: 44,
                                  fit: BoxFit.cover,
                                );
                              },
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          widget.userModel.displayName,
                          style: const TextStyle(
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
                                  const Icon(Icons.flag_outlined,
                                      size: 16, color: Colors.grey),
                                  const SizedBox(width: 5),
                                  Text("club_n".tr(),
                                      style: const TextStyle(
                                          fontSize: 14, color: Colors.grey)),
                                  Expanded(
                                    child: Text(
                                      widget.userModel.nameOfTeam ??
                                          "غير معروف",
                                      style: const TextStyle(
                                          fontSize: 14, color: Colors.grey),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  const Icon(Icons.calendar_month_outlined,
                                      size: 16, color: Colors.grey),
                                  const SizedBox(width: 5),
                                  Text("birth_date".tr(),
                                      style: const TextStyle(
                                          fontSize: 14, color: Colors.grey)),
                                  Expanded(
                                    child: Text(
                                      formatDate(widget.userModel.birthDate),
                                      style: const TextStyle(
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
                                  const Icon(Icons.language,
                                      size: 16, color: Colors.grey),
                                  const SizedBox(width: 8),
                                  Text("nationality1".tr(),
                                      style: const TextStyle(
                                          fontSize: 14, color: Colors.grey)),
                                  Expanded(
                                    child: Text(
                                      widget.userModel.nameOfNationality ??
                                          "غير معروف",
                                      style: const TextStyle(
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

        /// 🔹 أيقونات التعديل والحذف فوق الكارت
        if (CacheHelper.getData(key: "roles") == "Admin") ...[
          Positioned(
            top: 2,
            left: 8, // لو اللغة عربية
            child: Row(
              children: [
                // أيقونة التعديل داخل دائرة
                _buildIconButton(
                  icon: Icons.edit,
                  color: Colors.blue,
                  onTap: () {
                    navigateTo(
                      context,
                      EditPlayerScreen(playerId: widget.userModel.id),
                    );
                  },
                ),

                const SizedBox(width: 12),

                // أيقونة الحذف داخل دائرة
                _buildIconButton(
                  icon: Icons.delete,
                  color: Colors.red,
                  onTap: () {
                    _showDeleteDialog(
                      context,
                      widget.userModel.id ,
                    );
                  },
                ),
              ],
            ),
          ),
        ]
      ],
    );
  }

  Widget _buildIconButton({
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.withOpacity(0.3)),
        ),
        child: Icon(icon, color: color, size: 18),
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, String playerId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("delete_player_title".tr()), // 🔸 ترجمة
        content: Text("delete_player".tr()), // 🔸 ترجمة
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("cancel".tr()),
          ),
          BlocConsumer<HomeCubit, HomeStates>(
            listener: (context, state) {
              if (state is DeletePlayerSuccess) {
                Navigator.pop(context); // إغلاق الـ Dialog
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("User_deleted_success".tr())),
                );
              } else if (state is DeletePlayerFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.error)),
                );
              }
            },
            builder: (context, state) {
              if (state is DeletePlayerLoading) {
                return const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: CircularProgressIndicator(),
                );
              }

              return TextButton(
                onPressed: () {
                  context.read<HomeCubit>().deletePlayer(id: playerId);
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

  String formatDate(String inputDate) {
    DateTime date = DateTime.parse(inputDate);
    return DateFormat('d MMMM yyyy', 'ar').format(date);
  }
}
