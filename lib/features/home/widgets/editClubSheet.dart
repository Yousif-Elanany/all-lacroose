import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lacrosse/features/ActivitesPage/data/manager/cubit/activities_cubit.dart';
import 'package:lacrosse/features/home/data/manager/cubit/home_cubit.dart';
import 'package:lacrosse/features/home/data/models/model_team.dart';

void showEditClubSheet(BuildContext context, teamModels club) {
  final _nameController = TextEditingController(text: club.name);

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {
          if (state is EdiTeamSuccess) {
            Navigator.pop(context); // إغلاق الشيت بعد النجاح
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Club name updated successfully")),
            );
          } else if (state is EditTeamFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage)),
            );
          }
        },
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // الصورة الدائرية للفريق
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey[200],
                    child: ClipOval(
                      child: Image.network(
                        club.img ?? "", // الرابط أو نص فاضي
                        fit: BoxFit.cover,
                        width: 100,
                        height: 100,
                        errorBuilder: (context, error, stackTrace) => Container(
                          color: const Color(0xff185A3F),
                          child: const Center(
                            child: Icon(
                              Icons.warning_amber_outlined,
                              color: Colors.white,
                              size: 40,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 20),

                  // حقل تعديل الاسم
                  TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: "Club Name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),

                  // زر الحفظ
                  state is EditTeamLoading
                      ? CircularProgressIndicator()
                      : ElevatedButton(
                    onPressed: () {
                      // استدعاء Cubit لتعديل اسم النادي
                      context.read<HomeCubit>().editClub(
                        id:  club.id!,
                       name:
                        _nameController.text,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:Color(0xff185A3F),
                      minimumSize: Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      "Save".tr(),
                      style: TextStyle(
                          fontSize: 16, color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}
