import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lacrosse/features/SplashScreen/Presention/SplashScreen.dart';
import 'package:lacrosse/features/accountPage/data/manager/cubit/Account_State.dart';
import 'package:lacrosse/features/auth/pressntation/registerPage1.dart';

//
import '../../../data/Local/sharedPref/sharedPref.dart';
import '../data/manager/cubit/Account_cubit.dart';
import '../widgets/button_default.dart';
import '../widgets/textFeild_default.dart';

class Editeaccountpage extends StatefulWidget {
  @override
  State<Editeaccountpage> createState() => _Editeaccountpage();
}

class _Editeaccountpage extends State<Editeaccountpage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  var _userNameController = TextEditingController();

  var _phoneController = TextEditingController();
  String? imageLink;
  File? selectedImage1;
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AccountCubit, AccountState>(
        listener: (context, state) async {
      if (state is Image_videoSuccess) {
        imageLink = state.Image_videoLink;
      }
      if (state is editUserProfileSuccess) {
        _showAwesomeDialog(context);
      }
      if (state is editUserProfileFailure) {
        _showAwesomeErrorDialog(context, state.errorMessage);
      }
    }, builder: (context, state) {
      return GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
            body: Stack(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.13,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                        'assets/images/top bar.png'), // Replace with your asset path
                    fit: BoxFit.cover, // Adjust to control how the image fits
                  ),
                  gradient: LinearGradient(
                    colors: [Colors.green.shade700, Colors.green.shade100],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //     SizedBox(height: MediaQuery.of(context).size.height*0.11,),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 0.0, right: 0, bottom: 20, top: 45.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.6),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(8)),
                              ),
                              child: const Icon(
                                Icons.arrow_back_ios_outlined,
                                color: Color(0xff185A3F),
                                size: 20,
                              ),
                            ),
                          ),
                          Text(
                            "chang account data".tr(),
                            style: const TextStyle(
                              color: Color(0xff185A3F),
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 0,
                    ), //  MediaQuery.of(context).size.height * 0.140),

                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              // alignment: Alignment.bottomLeft, // المحاذاة السفلية اليسرى
                              children: [
                                Container(
                                  // color: Colors.amber,
                                  //padding: EdgeInsets.only(),

                                  child: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    radius: 40, // حجم الصورة الكبيرة
                                    // backgroundImage: NetworkImage(
                                    //   CacheHelper.getData(key: "UserPhoto")??"",
                                    // ),
                                    backgroundImage: selectedImage1 != null
                                        ? FileImage(selectedImage1!)
                                        : NetworkImage(
                                            CacheHelper.getData(
                                                    key: "UserPhoto") ??
                                                "",
                                          ),
                                  ),
                                ),
                                Positioned(
                                  bottom:
                                      0, // لضبط الأيقونة أقرب للحافة السفلية
                                  left: 0, // لضبطها أقرب للحافة اليسرى
                                  child: GestureDetector(
                                    onTap: () async {
                                      _showPickerDialog(context);

                                      setState(() {});
                                    },
                                    child: CircleAvatar(
                                      backgroundColor: Colors.white,

                                      radius: 12, // حجم الصورة الكبيرة
                                      child: Image(
                                        image: AssetImage(
                                          "assets/images/upload1.png", // الصورة الكبيرة
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 24,
                            ),
                            defaultFormField(
                              label: "userName".tr(),
                              type: TextInputType.emailAddress,
                              controller: _userNameController,
                              validate: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Required'.tr();
                                }
                                // }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            defaultFormField(
                              label: "phone_number".tr(),
                              //isPassword: true,
                              type: TextInputType.text,
                              controller: _phoneController,
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return 'Required'.tr();
                                } else if (!RegExp(
                                        r'^(?:\+966|00966|0)?5[0-9]{8}$')
                                    .hasMatch(value))
                                  return "inـvalid_phone_number"
                                      .tr(); //"Password must be at least 8 characters, include upper/lowercase, a number, and a special character";

                                return null;
                              },
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * .49,
                              // height: MediaQuery.of(context).size.height*.46,
                            ),
                            Center(
                              child: GestureDetector(
                                child: Button_default(
                                  height: 56,
                                  title: "chang account data".tr(),
                                  color: Color(0xff207954),
                                  colortext: Colors.white,
                                ),
                                onTap: (state is editUserProfileLoading)
                                    ? null
                                    : () {
                                        if (formKey.currentState!.validate()) {
                                          setState(() {
                                            // print(_userNameController.text);
                                            // print(imageLink);

                                            print(CacheHelper.getData(
                                                key: "UserName"));
                                            context
                                                .read<AccountCubit>()
                                                .editUserProfile(
                                                    image:
                                                        "Images/UserImages/08aa87af-9a45-4b8e-84d3-9eeb7830d728.png",
                                                    phoneNumber:
                                                        _phoneController.text,
                                                    displayName:
                                                        _userNameController
                                                            .text);
                                          });
                                          _phoneController.clear();
                                          _userNameController.clear();
                                          selectedImage1 = null;
                                        }
                                      },
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * .02,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        )),
      );
    });
  }

  Future<File?> _pickImage(ImageSource source) async {
    try {
      final pickedFile = await _picker.pickImage(
        source: source,
      );
      if (pickedFile != null) {
        context
            .read<AccountCubit>()
            .uploadImage_video(file: File(pickedFile.path));
        return File(pickedFile.path); // حفظ الصورة المختارة
      } else {
        print("No image selected.");
        return null; // إذا لم يتم اختيار صورة
      }
    } catch (e) {
      print("Error picking image: $e");
      return null;
    }
  }

  void _showPickerDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("selectSource".tr()),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.camera),
                title: Text('pick_image'.tr()),
                onTap: () async {
                  Navigator.pop(context);
                  selectedImage1 = await _pickImage(ImageSource.camera);
                  setState(() {});
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('select_from_galary'.tr()),
                onTap: () async {
                  Navigator.pop(context);
                  selectedImage1 = await _pickImage(ImageSource.gallery);
                  setState(() {});
                },
              ),
            ],
          ),
        );
      },
    );
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

  void _showAwesomeErrorDialog(BuildContext context, text) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.error, // success, error, warning, info
      animType: AnimType.leftSlide, // fade, leftSlide, rightSlide, scale
      title: 'error'.tr(),
      desc: text.toString(),
      btnOkOnPress: () {},
    ).show();
  }
}

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );
