import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lacrosse/features/home/data/manager/cubit/home_cubit.dart';
import 'package:lacrosse/features/home/data/models/PlayerModel.dart';

import '../../auth/data/model/team.dart';
import '../../eventsPage/data/model/natinalityModel.dart';

class EditPlayerScreen extends StatefulWidget {
  final String playerId;

  const EditPlayerScreen({
    super.key,
    required this.playerId,
  });

  @override
  State<EditPlayerScreen> createState() => _EditPlayerScreenState();
}

class _EditPlayerScreenState extends State<EditPlayerScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController birthDateController = TextEditingController();

  int? selectedTeamId;
  int? selectedNationalityId;

  List<TeamModel> teamsList = [];
  List<NationalityModel> nationalityList = [];
  File? _pickedImage;
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery, // أو ImageSource.camera
      imageQuality: 70, // لتقليل الحجم
    );

    if (pickedFile != null) {
      setState(() {
        _pickedImage = File(pickedFile.path);
      });
    }
  }
  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().fetchAllEditPlayerData(widget.playerId);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("editPersonData".tr()),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {
      if (state is getPlayerDataFailure) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(state.errorMessage)),
        );
      }

      if (state is EditPlayerLoaded) {
        setState(() {
          teamsList = state.teams;
          nationalityList = state.nationalities;
          selectedTeamId = state.player.teamId;
          selectedNationalityId = state.player.nationalityId;
          birthDateController.text =state.player.birthDate ;
        });
      }},
        builder: (context, state) {
          if (state is getPlayerDataLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (state is getPlayerDataFailure) {
            return Center(child: Text(state.errorMessage));
          }

          if (state is EditPlayerLoaded) {
            final player = state.player;

            return Padding(
              padding: const EdgeInsets.all(16),
              child: ListView(
                children: [
                  // صورة اللاعب
                  Center(
                    child: InkWell(
                      onTap: _pickImage, // عند الضغط يفتح المعرض/الكاميرا
                      child: Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        clipBehavior: Clip.hardEdge,
                        child: _pickedImage != null
                            ? Image.file(_pickedImage!, fit: BoxFit.fill) // لو اختار صورة جديدة
                            : Image.network(
                          player.image,
                          fit: BoxFit.fill,
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              'assets/images/reg.png',
                              fit: BoxFit.cover,
                            );
                          },
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 20),

                  TextField(
                    controller: nameController..text = player.displayName,
                    decoration: InputDecoration(labelText: "name".tr()),
                  ),
                  SizedBox(height: 10),

                  TextField(
                    controller: emailController..text = player.email,
                    decoration: InputDecoration(labelText: "email".tr()),
                  ),
                  SizedBox(height: 10),

                  // تاريخ الميلاد
                  TextField(
                    readOnly: true,
                    controller: birthDateController,
                    decoration: InputDecoration(labelText: "birthday".tr()),
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.tryParse(birthDateController.text) ?? DateTime.now(),
                        firstDate: DateTime(1950),
                        lastDate: DateTime.now(),
                      );
                      if (pickedDate != null) {
                        birthDateController.text =
                            pickedDate.toIso8601String().split("T").first; // yyyy-MM-dd
                      }
                    },
                  ),

                  SizedBox(height: 10),

                  // الفريق
                  DropdownButtonFormField<int>(
                    value: selectedTeamId,
                    decoration: InputDecoration(labelText: "team".tr(),),
                    items: teamsList.map((team) {
                      return DropdownMenuItem<int>(
                        value: team.id,
                        child: Text(team.name),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() => selectedTeamId = value!);
                    },
                  ),
                  SizedBox(height: 10),

                  // الجنسية
                  DropdownButtonFormField<int>(
                    value: selectedNationalityId,
                    decoration: InputDecoration(labelText: "nationality".tr(),  ),
                    items: nationalityList.map((nat) {
                      return DropdownMenuItem<int>(
                        value: nat.id,
                        child: Text(nat.nationalityName),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() => selectedNationalityId = value!);
                    },
                  ),
                  SizedBox(height: 10),

                  TextField(
                    controller: cityController..text = player.city,
                    decoration: InputDecoration(labelText: "city".tr()),
                  ),
                  SizedBox(height: 10),

                  TextField(
                    controller: areaController..text = player.area,
                    decoration: InputDecoration(labelText: "area".tr()),
                  ),
                  SizedBox(height: 10),

                  TextField(
                    controller: addressController..text = player.address,
                    decoration: InputDecoration(labelText: "address".tr()),
                  ),
                  SizedBox(height: 20),

                  ElevatedButton(
                    onPressed: () {
                      final cubit = context.read<HomeCubit>();

                      cubit.updatePlayerData(
                        id: player.id, // لازم دايمًا

                        // هنستخدم اللي جوّه الـ controllers على طول
                        displayName: nameController.text,
                        birthDate: birthDateController.text, // لو عملتله controller يبقى نفس الفكرة
                        city: cityController.text,
                        area: areaController.text,
                        address: addressController.text,

                        teamId: selectedTeamId ?? player.teamId,
                        nationalityId: selectedNationalityId ?? player.nationalityId,

                        imageFile: _pickedImage, // لو اختار صورة هتتبعت، لو لأ هتتبعت null
                      );
                      Navigator.pop(context);

                    },
                    child: Text("Save Edit".tr()),
                  ),
                ],
              ),
            );
          }

          return SizedBox.shrink();
        },

      ),
    );
  }
}
