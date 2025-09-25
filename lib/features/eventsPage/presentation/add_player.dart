import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lacrosse/features/eventsPage/data/manager/cubit/manager_cubit.dart';

import '../../../data/Local/sharedPref/sharedPref.dart';

import '../../layout/Tabs/BaseScreen.dart';
import '../data/manager/cubit/manager_states.dart';
import '../widgets/button_default.dart';
import '../widgets/textFeild_default.dart';
import 'add_player_trainer.dart';

class Add_player_trainer2 extends StatefulWidget {
  int userType;
  String displayName;
  File? userImage;
  String userDate;
  String userPhone;
  int userNationalityId;
  int userTeamId;
  String userCity;
  String userArea;
  String userAddress;
  Add_player_trainer2({
    required this.userAddress,
    required this.userArea,
    required this.userCity,
    required this.userPhone,
    required this.userDate,
    required this.displayName,
    required this.userNationalityId,
    required this.userTeamId,
    required this.userType,
    this.userImage,
  });

  @override
  State<Add_player_trainer2> createState() => _Add_player_trainer2State();
}

class _Add_player_trainer2State extends State<Add_player_trainer2> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool is_player = true;

  bool selected_register = true; // القيمة المختارة
  String selectedValue = 'Option 1';

  var emailController = TextEditingController();
  var passController = TextEditingController();
  var confirmPassController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: BlocConsumer<managerCubit, ManagerStates>(
          listener: (context, state) {
            if (state is addUserSuccess) {
              _showAwesomeDialog(context);
            }
            if (state is addUserFailure) {
              _showDialog(context, state.errorMessage);
            }
          },
          builder: (context, state) {
            return Stack(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.14,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                            'assets/images/top bar.png'), // Replace with your asset path
                        fit: BoxFit
                            .cover, // Adjust to control how the image fits
                      ),
                      gradient: LinearGradient(
                        colors: [Colors.white, Colors.white60],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                  ),
                ),
                SingleChildScrollView(
                  padding: EdgeInsets.only(
                    right: 16, // MediaQuery.of(context).size.width * 0.04,
                    left: 16, //MediaQuery.of(context).size.width * 0.04,
                    top: 48, //MediaQuery.of(context).size.height * 0.14
                  ),
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
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
                              "add_player_trainer".tr(),
                              style: TextStyle(
                                color: Color(0xff207954), //999999
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Spacer(),
                            Text(
                              "join_order".tr(),
                              style: TextStyle(
                                color: Color(0xff207954), //999999
                                fontSize: 16,
                                // fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .05,
                        ),
                        Row(
                          children: [
                            Text(
                              "step".tr(),
                              style: TextStyle(
                                ///  color: Color(0xff328361),
                                fontSize: 16,
                                // fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "2",
                              style: TextStyle(
                                color: Color(0xff207954), //999999
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "from".tr(),
                              style: TextStyle(
                                ///  color: Color(0xff328361),
                                fontSize: 16,
                                //fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              " 2",
                              style: TextStyle(
                                ///  color: Color(0xff328361),
                                fontSize: 16,
                                //fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        DefaultFormField(
                          label: "email".tr(),
                          controller: emailController,
                          type: TextInputType.text,
                          validate: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Required'.tr();
                            }
                            if (!EmailValidator.validate(value)) {
                              return 'inـvalidـemail'.tr();
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        DefaultFormField(
                          label: "password".tr(),
                          controller: passController,
                          type: TextInputType.text,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'Required'.tr();
                            } else if (!RegExp(
                                    r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[!@#$%^&*(),.?":{}|<>])[A-Za-z\d!@#$%^&*(),.?":{}|<>]{8,}$')
                                .hasMatch(value))
                              return "inـvalid_password"
                                  .tr(); //"Password must be at least 8 characters, include upper/lowercase, a number, and a special character";

                            return null;
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        DefaultFormField(
                          label: "confirm_pass".tr(),
                          controller: confirmPassController,
                          type: TextInputType.text,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'Required'.tr();
                            } else if (value.isEmpty ||
                                passController.text !=
                                    confirmPassController.text) {
                              return 'password_not_same'.tr();
                            }
                            return null;
                          },

                          //  hint: "رقم الجوال"
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.45,
                        ),
                        GestureDetector(
                            onTap: (state is addUserSuccess)
                                ? null
                                : () {
                                    if (widget.userImage != null)
                                      print("  dmjjjjjjjjjjjjj");
                                    print("  yyyyyyyyyyyyyy");
                                    if (formKey.currentState!.validate()) {
                                      if (passController.text ==
                                          confirmPassController.text) {
                                        BlocProvider.of<managerCubit>(context)
                                            .addUserByManager(
                                                email: emailController.text,
                                                pass: passController.text,
                                                name: widget.displayName,
                                                birthdate: widget.userDate,
                                                phone:
                                                    "+966${widget.userPhone}",
                                                city: widget.userCity,
                                                area: widget.userArea,
                                                address: widget.userAddress,
                                                type: widget.userType,
                                                teamId: widget.userTeamId,
                                                nationality_id:
                                                    widget.userNationalityId,
                                                file: widget.userImage);
                                      }
                                      // print();
                                      //   widge
                                    }
                                  },
                            child: Button_default(
                              height: 56,
                              title: widget.userType == 0
                                  ? "reg_player".tr()
                                  : "reg_trainer".tr(),
                              color: Color(0xff207954),
                            )),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            );
          },
        ));
  }
}

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );
void _showAwesomeDialog(BuildContext context) {
  AwesomeDialog(
    context: context,
    dialogType: DialogType.success, // success, error, warning, info
    animType: AnimType.leftSlide, // fade, leftSlide, rightSlide, scale
    title: 'success'.tr(),
    desc: 'Gob_done_successfully'.tr(),
    btnOkOnPress: () {},
  ).show();
}

void _showDialog(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        contentPadding: EdgeInsets.all(16), // يمكنك تخصيص الحواف هنا
        title: Text(message, textAlign: TextAlign.center),
        content: Column(
          mainAxisSize: MainAxisSize.min, // لتقليص الحجم حسب المحتوى
          children: [
            GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  //navigateAndFinish(context, LoginPage());
                },
                child: CircleAvatar(
                  radius: 30,
                  child: Text(
                    "ok",
                    style: TextStyle(fontSize: 16),
                  ),
                ))
          ],
        ),
      );
    },
  );
}
