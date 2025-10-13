import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lacrosse/data/Local/sharedPref/sharedPref.dart';
import 'package:lacrosse/features/eventsPage/data/manager/cubit/manager_cubit.dart';
import 'package:lacrosse/features/eventsPage/data/manager/cubit/manager_states.dart';
import 'package:lacrosse/features/home/data/manager/cubit/home_cubit.dart';
import 'package:lacrosse/features/home/data/models/PlayerModel.dart';
import 'package:lacrosse/features/home/widgets/editClubSheet.dart';

import '../../../core/component/snackBar.dart';
import '../data/models/model_team.dart';
import '../widgets/customPlayerWidget.dart';

class ClubScreen extends StatefulWidget {
  @override
  _ClubScreenState createState() => _ClubScreenState();
}

class _ClubScreenState extends State<ClubScreen> {
  List<teamModels> allClub = [];

  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().fetchAlltEAMS(); // جلب البيانات
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: BlocConsumer<HomeCubit, HomeStates>(
          listener: (context, state) {
            if (state is TeamsDataSuccess) {
              allClub = state.teamsData;
              // print("mmmmmmmmmmm");
              // print(allClub);
            }
          },
          builder: (context, state) {
            if (allClub.isNotEmpty) {
              return Stack(children: [
                Stack(children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.16,
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                              'assets/images/top bar.png'), // Replace with your asset path
                          fit: BoxFit
                              .cover, // Adjust to control how the image fits
                        ),
                        gradient: LinearGradient(
                          colors: [
                            Colors.green.shade900,
                            Colors.green.shade700
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 45.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(left: 0.0, top: 0),
                                  child: Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.6),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(8),
                                      ),
                                    ),
                                    child: Icon(Icons.arrow_back_ios_outlined,
                                        color: Color(0xff185A3F), size: 20),
                                  ),
                                ),
                              ),
                              Text(
                                "Teams".tr(),
                                style: TextStyle(
                                  color: Color(0xff185A3F),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        //   Icon(Icons.search, color: Color(0xff185A3F), size: 30),
                      ],
                    ),
                  ),
                ]),
                // محتوى الشاشة
                Container(
                  padding: EdgeInsets.all(16),
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.13),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "${allClub.length} ",
                            style: TextStyle(fontSize: 18, color: Colors.green),
                          ),
                          Text(
                            "club1".tr(),
                            style: TextStyle(
                              //  color: Color(0xff185A3F),
                              fontSize: 16,
                              //  fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Expanded(
                        child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, // عدد الأعمدة
                            crossAxisSpacing: 10, // المسافة الأفقية بين العناصر
                            mainAxisSpacing: 10, // المسافة العمودية بين العناصر
                            childAspectRatio: 0.8, // النسبة بين العرض والارتفاع
                          ),
                          itemCount: allClub.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {},
                              child: ClubItem(model: allClub[index]),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                )
              ]);
            } else
              return Center(child: CircularProgressIndicator());
          },
        ));
  }
}

class ClubItem extends StatelessWidget {
  final teamModels? model;

  ClubItem({super.key, this.model});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          // ✅ الصورة تملأ العنصر بالكامل
          Positioned.fill(
            child: (model!.img.trim().isNotEmpty)
                ? Image.network(
                    model!.img,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => errorImage(),
                  )
                : errorImage(),
          ),

          // ✅ خلفية غامقة للنص
          Container(
            width: double.infinity,
            color: Colors.black.withOpacity(0.4),
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Text(
              model?.name ?? "",
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // ✅ أزرار التعديل والحذف (تظهر فقط لو ممرر callbacks)
          // ✅ الأزرار تظهر فقط لو المستخدم Admin
          if (CacheHelper.getData(key: "roles") == "Admin")
            Positioned(
                top: 10,
                left: 10,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        showDeleteDialog(context, model!.id);
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
                        showEditClubSheet(context, model!);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(
                            4), // يقلل المساحة حوالين الأيقونة
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
    );
  }

  Widget errorImage() {
    return Container(
      color: const Color(0xff185A3F),
      child: const Center(
        child: Icon(
          Icons.warning_amber_outlined,
          color: Colors.white,
          size: 40,
        ),
      ),
    );
  }

  void showDeleteDialog(BuildContext context, int teamId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("delete_team_title".tr()), // 🔸 ترجمة لعنوان حذف الفاعلية
        content: Text("delete_team".tr()), // 🔸 ترجمة نص الحذف
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("cancel".tr()),
          ),
          BlocConsumer<HomeCubit, HomeStates>(
            listener: (context, state) {
              if (state is DeleteTeamSuccess) {
                Navigator.pop(context); // ✅ إغلاق الـ Dialog
                showSuccessSnackBar(context, "Gob_done_successfully".tr());
              } else if (state is DeleteTeamFailure) {
                Navigator.pop(context); // ✅ إغلاق الـ Dialog
                showErrorSnackBar(context, "errorDeleteToClub".tr());
              }

            },
            builder: (context, state) {
              if (state is DeleteTeamLoading) {
                return const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: CircularProgressIndicator(),
                );
              }

              return TextButton(
                onPressed: () {
                  context.read<HomeCubit>().deleteClub(id: teamId);
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
