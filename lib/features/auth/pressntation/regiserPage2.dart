import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lacrosse/features/auth/data/manager/cubit/auth_cubit.dart';
import 'package:lacrosse/features/auth/data/manager/cubit/auth_states.dart';
import 'package:lacrosse/features/auth/pressntation/loginPage.dart';
import 'package:lacrosse/features/auth/pressntation/registerPage1.dart';

import '../data/model/natinalityModel.dart';
import '../data/model/team.dart';
import '../widgets/button_default.dart';
import '../widgets/button_select_register.dart';
import '../widgets/custom_drop_down.dart';
import '../widgets/textFeild_default.dart';

class Registerpage2 extends StatefulWidget {
  String? password;
  String? email;
  File? file;
  Registerpage2({
    String? email,
    String? pass,
    File? file,
  }) {
    this.email = email;
    this.password = pass;
    this.file = file;
  }
  List<TeamModel> teamsList = [];
  List<NationalityModel> nationality = [];

  @override
  State<Registerpage2> createState() => _Registerpage2State();
}

class _Registerpage2State extends State<Registerpage2> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool is_player = true;
  bool selected_register = true; //
  NationalityModel? selectedNationality;
  TeamModel? selectedTeam; // القيمة المختارة
  // String selectedValue = 'Option 1';
  // final List<String> items = ['Option 1', 'Option 2', 'Option 3', 'Option 4'];

  var _nameController = TextEditingController();
  var _birthdateController = TextEditingController();
  var _cityController = TextEditingController();
  var _areaController = TextEditingController();
  var _addressController = TextEditingController();
  var _phonNumberController = TextEditingController();
  int selected_user_type = 0;
  int selected_clubID = 3;
  int selected_nationalityID = 1;
  int selected_TeamID = 1;
  bool is_loading = false;
  @override
  void initState() {
    super.initState();
    context.read<AuthCubit>().fetchAllTeams();
    context.read<AuthCubit>().fetchAllNationality();

    setState(() {});
  }

  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        print("date$selectedDate");
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16.0),
          child: GestureDetector(
            onTap: () {
              if (formKey.currentState!.validate()) {
                BlocProvider.of<AuthCubit>(context).registerUserData(
                  email: widget.email!,
                  pass: widget.password!,
                  name: _nameController.text,
                  birthdate: _birthdateController.text,
                  phone: "+966${_phonNumberController.text}",
                  city: _cityController.text,
                  area: _areaController.text,
                  address: _addressController.text,
                  type: selected_user_type,
                  teamId: selected_TeamID,
                  nationality_id: selected_clubID,
                  file: widget.file,
                );
              }
            },
            child: Button_default(
              height: 48,
              title: is_loading ? null : "register".tr(),
              color: const Color(0xff207954),
              colortext: Colors.white,
              child: is_loading
                  ? const SizedBox(
                height: 24,
                width: 24,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
                  : null,
            )
          ),
        ),

        body: BlocConsumer<AuthCubit, AuthStates>(
      listener: (context, state) {
        if (state is fetch_team_success) {
          widget.teamsList = state.TeamData;
          // print("gooooooooooooooooooo");
          // print(widget.teamsList.length);
          // print(widget.teamsList[0].name);
        }
        if (state is fetch_Nationality_success) {
          widget.nationality = state.NationalityData;
          // print(widget.nationality.length);
          // print(widget.nationality[0].nationalityName);
          // print("gooooooooooooooooooo2222222");
        }
        if (state is RegisterLoading) is_loading = true;
        if (state is RegisterSuccess) {
          is_loading = false;
          _showAwesomeDialog1(context);
          Future.delayed(Duration(seconds: 2), () {
            Navigator.pop(context);
            navigateAndFinish(context, LoginPage());
          });
        }

        if (state is RegisterFailure) {
          is_loading = false;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.errorMessage,
                style: const TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.red,
              behavior: SnackBarBehavior.floating,
              duration: const Duration(seconds: 3),
            ),
          );
        }

        setState(() {});
      },
      builder: (context, state) {
        return Stack(
          children: [
            Image.asset("assets/images/auth.jpeg",width: double.infinity,height: double.infinity,),
            // SizedBox(
            //   height: MediaQuery.of(context).size.height * 0.14,
            //   child: Container(
            //     decoration: BoxDecoration(
            //       image: DecorationImage(
            //         image: AssetImage(
            //             'assets/images/top bar.png'), // Replace with your asset path
            //         fit: BoxFit.cover, // Adjust to control how the image fits
            //       ),
            //       gradient: LinearGradient(
            //         colors: [Colors.green.shade700, Colors.green.shade100],
            //         begin: Alignment.bottomCenter,
            //         end: Alignment.topCenter,
            //       ),
            //     ),
            //   ),
            // ),
            SafeArea(
              child: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// زر الرجوع
                      GestureDetector(
                        child: const Image(
                          width: 70,
                          height: 70,
                          image: AssetImage("assets/images/arrow.png"),
                        ),
                        onTap: () {
                          navigateTo(context, Registerpage1());
                        },
                      ),

                      const SizedBox(height: 8),

                      /// الخطوات
                      Row(
                        children: [
                          Text("step".tr(), style: const TextStyle(fontSize: 16)),
                          const SizedBox(width: 4),
                          const Text("2",
                              style: TextStyle(fontSize: 16, color: Color(0xff207954))),
                          const SizedBox(width: 4),
                          Text("from".tr(), style: const TextStyle(fontSize: 16)),
                          const SizedBox(width: 4),
                          const Text("2", style: TextStyle(fontSize: 16)),
                        ],
                      ),

                      const SizedBox(height: 12),

                      Text(
                        "create_new_account".tr(),
                        style: const TextStyle(
                          color: Color(0xff207954),
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      SizedBox(height: MediaQuery.of(context).size.height * 0.02),

                      Text("reg_as".tr(), style: const TextStyle(fontSize: 16)),

                      SizedBox(height: MediaQuery.of(context).size.height * 0.02),

                      /// زرار اختيار نوع التسجيل
                      Row(
                        children: [
                          Button_select_register(
                            text: "player".tr(),
                            is_Player: true,
                            groupValue: selected_register,
                            onChanged: (value) {
                              selected_register = value!;
                              setState(() {});
                              selected_user_type = 0;
                            },
                          ),
                          SizedBox(width: MediaQuery.of(context).size.width * 0.04),
                          Button_select_register(
                            text: "trainer".tr(),
                            is_Player: false,
                            groupValue: selected_register,
                            onChanged: (value) {
                              selected_register = value!;
                              setState(() {});
                              selected_user_type = 1;
                            },
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      /// الحقول داخل Scroll
                      Expanded(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                defaultFormField(
                                  label: "name".tr(),
                                  type: TextInputType.text,
                                  controller: _nameController,
                                  validate: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return 'Required'.tr();
                                    }
                                    if (value.contains(" ")) {
                                      return 'Name must not contain spaces'.tr();
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 16),

                                defaultFormField(
                                  label: "phone_number".tr(),
                                  type: TextInputType.phone,
                                  controller: _phonNumberController,
                                  validate: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'enter_saudi_number'.tr();
                                    }
                                    final regex = RegExp(r'^5\d{8}$'); // يبدأ بـ 5 + 8 أرقام
                                    if (!regex.hasMatch(value)) {
                                      return 'enter_saudi_number'.tr();
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 16),

                                /// تاريخ الميلاد
                                GestureDetector(
                                  onTap: () async {
                                    await _selectDate(context);
                                    String formattedDate =
                                    DateFormat('yyyy-MM-dd').format(selectedDate);
                                    _birthdateController.text = formattedDate;
                                    setState(() {});
                                  },
                                  child: AbsorbPointer(
                                    child: defaultFormField(
                                      label: "birthday".tr(),
                                      type: TextInputType.text,
                                      controller: _birthdateController,
                                      validate: (value) =>
                                      value!.isEmpty ? 'Required'.tr() : null,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 16),

                                build_Teams_dropDown_bottom(hint: 'club'.tr()),
                                const SizedBox(height: 16),

                                build_Nationality_dropDown_bottom(hint: 'nationality'.tr()),
                                const SizedBox(height: 16),

                                defaultFormField(
                                  label: "city".tr(),
                                  type: TextInputType.text,
                                  controller: _cityController,
                                  validate: (value) =>
                                  value!.isEmpty ? 'Required'.tr() : null,
                                ),
                                const SizedBox(height: 16),

                                defaultFormField(
                                  label: "area".tr(),
                                  type: TextInputType.text,
                                  controller: _areaController,
                                  validate: (value) =>
                                  value!.isEmpty ? 'Required'.tr() : null,
                                ),
                                const SizedBox(height: 16),

                                defaultFormField(
                                  label: "address".tr(),
                                  type: TextInputType.text,
                                  controller: _addressController,
                                  validate: (value) =>
                                  value!.isEmpty ? 'Required'.tr() : null,
                                ),
                                const SizedBox(height: 30),

                                // /// زر التسجيل
                                // GestureDetector(
                                //   onTap: (state is RegisterLoading)
                                //       ? null
                                //       : () {
                                //     if (formKey.currentState!.validate()) {
                                //       BlocProvider.of<AuthCubit>(context).registerUserData(
                                //         email: widget.email!,
                                //         pass: widget.password!,
                                //         name: _nameController.text,
                                //         birthdate: _birthdateController.text,
                                //         phone: "+966${_phonNumberController.text}",
                                //         city: _cityController.text,
                                //         area: _areaController.text,
                                //         address: _addressController.text,
                                //         type: selected_user_type,
                                //         teamId: selected_TeamID,
                                //         nationality_id: selected_clubID,
                                //         file: widget.file,
                                //       );
                                //     }
                                //   },
                                //   child: Button_default(
                                //     height: 48,
                                //     title: "register".tr(),
                                //     color: const Color(0xff207954),
                                //     colortext: Colors.white,
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )

          ],
        );

      },



    )
    );
  }
  Widget build_Teams_dropDown_bottom({required String hint}) {
    final uniqueTeamsList = widget.teamsList.toSet().toList();

    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300, width: 2),
      ),
      child: DropdownButtonFormField<TeamModel>(
        isExpanded: true,
        value: selectedTeam,
        decoration: const InputDecoration(
          border: InputBorder.none, // إزالة الخط السفلي
          //  contentPadding: EdgeInsets.symmetric(vertical: 5),// ضبط المحاذاة عموديًا
        ),
        hint: Text(
          hint,
          style: const TextStyle(
              color: Color(0xff999999),
              fontSize: 16,
              fontWeight: FontWeight.w700
          ),
        ),
        onChanged: (TeamModel? newValue) {
          setState(() {
            selectedTeam = newValue;
            selected_TeamID = selectedTeam!.id;
            print(selected_TeamID);
          });
        },
        validator: (value) {
          if (value == null) {
            return 'Please_select_a_team'.tr();
          }
          return null;
        },
        items: uniqueTeamsList.map<DropdownMenuItem<TeamModel>>((TeamModel value) {
          return DropdownMenuItem<TeamModel>(
            value: value,
            child: Text(value.name),
          );
        }).toList(),
        dropdownColor: const Color(0xfff9f9f9),
        borderRadius: BorderRadius.circular(12),
        icon: const Icon(Icons.keyboard_arrow_down_outlined, color: Colors.black),
        iconSize: 24,
        style: const TextStyle(color: Colors.black, fontSize: 16),
      ),
    );
  }

  Widget build_Nationality_dropDown_bottom({required String hint}) {
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xffcccccc), width: 1),
      ),
      child: DropdownButtonFormField<NationalityModel>(
        isExpanded: true,
        value: selectedNationality,
        decoration: const InputDecoration(
          border: InputBorder.none, // إزالة الخط السفلي
          contentPadding: EdgeInsets.symmetric(vertical: 10),// ضبط المحاذاة عموديًا
        ),
        hint: Text(
          hint,
          style: const TextStyle(
              color: Color(0xff999999),
              fontSize: 16,
              fontWeight: FontWeight.w700
          ),
        ),
        onChanged: (NationalityModel? newValue) {
          setState(() {
            selectedNationality = newValue;
            selected_nationalityID = selectedNationality!.id;
          });
        },
        validator: (value) {
          if (value == null) {
            return 'Pleaseـselectـaـnationality'.tr();
          }
          return null;
        },
        items:  widget.nationality
            .map<DropdownMenuItem<NationalityModel>>((NationalityModel value) {
          return DropdownMenuItem<NationalityModel>(
            value: value,
            child: Text(value.nationalityName),
          );
        }).toList(),
        dropdownColor: const Color(0xfff9f9f9),
        borderRadius: BorderRadius.circular(12),
        icon: const Icon(Icons.keyboard_arrow_down_outlined, color: Colors.black),
        iconSize: 24,
        style: const TextStyle(color: Colors.black, fontSize: 16),
      ),
    );
  }


  void _showDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.all(16),
          title: Text(message, textAlign: TextAlign.center),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: CircleAvatar(
                  radius: 30,
                  child: Text(
                    "ok",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );
void _showAwesomeDialog(BuildContext context,text) {
  AwesomeDialog(
    context: context,
    dialogType: DialogType.error, // success, error, warning, info
    animType: AnimType.leftSlide,  // fade, leftSlide, rightSlide, scale
    title: 'error'.tr(),
    desc: text.toString(),
    btnOkOnPress: () {},

  ).show();


}
void _showAwesomeDialog1(BuildContext context) {
  AwesomeDialog(
    context: context,
    dialogType: DialogType.success, // success, error, warning, info
    animType: AnimType.leftSlide,  // fade, leftSlide, rightSlide, scale
    title: 'success'.tr(),
    desc: 'Gob_done_successfully'.tr(),
    btnOkOnPress: () {},

  ).show();

}
void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
      (route) => false,
    );
