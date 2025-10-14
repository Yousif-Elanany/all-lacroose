// ignore_for_file: deprecated_member_use
import 'dart:ui' as ui;
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lacrosse/features/NewsPage/data/manager/cubit/news_states.dart';

import 'package:lacrosse/features/auth/data/manager/cubit/auth_cubit.dart';
import 'package:lacrosse/features/auth/data/manager/cubit/auth_states.dart';

import '../../NewsPage/data/manager/cubit/news_cubit.dart';
import '../../NewsPage/data/model/newsModel.dart';
import '../widgets/button_default.dart';
import '../widgets/queationDesign.dart';
import '../widgets/textFeild_default.dart';

class ChangePasswordPage extends StatefulWidget {
  ChangePasswordPage();
  @override
  State<ChangePasswordPage> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<ChangePasswordPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //context.read<QuestionCubit>().fetchAllQuestionData();
  }

  bool loading = false;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  var _emailController = TextEditingController();

  var _currentPasswordController = TextEditingController();
  var _newPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: BlocConsumer<AuthCubit, AuthStates>(listener: (context, state) {
          if (state is ChangPassSuccess) {
            _showAwesomeDialog(context);

            // مسح الحقول
            _emailController.clear();
            _currentPasswordController.clear();
            _newPasswordController.clear();
          }
          if (state is ChangPassLoading) {
            setState(() {
              loading = true;
            });
          } else {
            setState(() {
              loading = false;
            });
          }

          if (state is ChangPassFailure) {
            _showDialog(context, state.errorMessage);
          }
          setState(() {});
        }, builder: (context, state) {
          return Stack(
            children: [
              Stack(children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.14,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                            "assets/images/top bar.png"), // Replace with your asset path
                        fit: BoxFit
                            .cover, // Adjust to control how the image fits
                      ),
                      gradient: LinearGradient(
                        colors: [Colors.green.shade900, Colors.green.shade700],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 45.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
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
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'change_password'.tr(),
                              style: TextStyle(
                                color: Color(0xff185A3F),
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(),
                    ],
                  ),
                ),
              ]),
              Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SingleChildScrollView(
                      child: Form(
                        key: formKey,
                        child: Column(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * .03,
                            ),
                            defaultFormField(
                              label: "email".tr(),
                              type: TextInputType.text,
                              controller: _emailController,

                              validate: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Required'.tr();
                                }
                                if (!EmailValidator.validate(value)) {
                                  return 'inـvalidـemail'.tr();
                                }
                                return null;
                              },

                              //  hint: "رقم الجوال"
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * .02,
                            ),
                            defaultFormField(
                              label: "current_password".tr(),
                              type: TextInputType.text,
                              controller: _currentPasswordController,
                              validate: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Required'.tr();
                                }
                                // الباترن
                                else if (!RegExp(
                                        r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[^A-Za-z0-9]).{8,}$')
                                    .hasMatch(value)) {
                                  return "inـvalid_password"
                                      .tr(); //"Password must be at least 8 characters, include upper/lowercase, a number, and a special character";
                                  // "Password must be at least 8 characters, include upper/lowercase, a number, and a special character";
                                }
                                return null;
                              },
                              // validate: (value) {
                              //   if (value!.isEmpty) {
                              //     return 'Required'.tr();
                              //   }
                              //   else if( !RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[!@#$%^&*(),.?":{}|<>])[A-Za-z\d!@#$%^&*(),.?":{}|<>]{8,}$').hasMatch(value))
                              //     return "inـvalid_password".tr();//"Password must be at least 8 characters, include upper/lowercase, a number, and a special character";
                              //
                              //   return null;
                              // },

                              //  hint: "رقم الجوال"
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * .02,
                            ),
                            defaultFormField(
                              label: "new_pass".tr(),
                              type: TextInputType.text,
                              controller: _newPasswordController,
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

                              //  hint: "رقم الجوال"
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * .46,
                            ),
                            GestureDetector(
                              onTap: (state is ChangPassLoading)
                                  ? null
                                  : () {
                                      if (formKey.currentState!.validate()) {
                                        setState(() {
                                          BlocProvider.of<AuthCubit>(context)
                                              .changePassword(
                                                  email: _emailController.text,
                                                  current:
                                                      _currentPasswordController
                                                          .text,
                                                  newPass:
                                                      _newPasswordController
                                                          .text);
                                        });
                                      }
                                    },
                              child: loading
                                  ? Center(
                                      child: CircularProgressIndicator(
                                      color: Colors.green,
                                    ))
                                  : Button_default(
                                      height: 56,
                                      title: "change_password".tr(),
                                      color: Color(0xff207954),
                                      colortext: Colors.white,
                                    ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * .02,
                            ),
                          ],
                        ),
                      ),
                    ),
                  )),
            ],
          );
        }));
  }

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
          contentPadding: EdgeInsets.all(16),
          title: Text(message, textAlign: TextAlign.center),
          content: Column(
            mainAxisSize: MainAxisSize.min,
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
}
