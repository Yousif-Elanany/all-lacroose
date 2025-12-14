import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lacrosse/features/auth/pressntation/loginPage.dart';
import 'package:lacrosse/features/auth/pressntation/regiserPage2.dart';

import '../../../core/RegexRules/RegexRules.dart';
import '../widgets/button_default.dart';
import '../widgets/textFeild_default.dart';

class Registerpage1 extends StatefulWidget {
  Registerpage1({super.key});

  @override
  State<Registerpage1> createState() => _Registerpage1State();
}

class _Registerpage1State extends State<Registerpage1> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  // final passwordRegex = RegExp(
  //   r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&#])[A-Za-z\d@$!%*?&#]{8,}$',
  // );
  File? selectedImage1;
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Image.asset("assets/images/auth.jpeg"),
            SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(12.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () => navigateTo(context, LoginPage()),
                        child: Container(
                          margin: const EdgeInsets.only(top: 20),
                          child: const Image(
                            image: AssetImage("assets/images/arrow.png"),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Text("step".tr(),
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w400)),
                          Text("1",
                              style: const TextStyle(
                                  color: Color(0xff207954),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400)),
                          Text("from".tr(),
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w400)),
                          const Text("2 ",
                              style:
                              TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        "create_new_account".tr(),
                        style: const TextStyle(
                          color: Color(0xff207954),
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Stack(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 36,
                            backgroundImage: selectedImage1 != null
                                ? FileImage(selectedImage1!)
                                : const AssetImage("assets/images/reg.png")
                            as ImageProvider,
                          ),
                          Positioned(
                            bottom: 0,
                            left: 0,
                            child: GestureDetector(
                              onTap: () async => _showPickerDialog(context),
                              child: const CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 19,
                                child: Image(
                                  image: AssetImage("assets/images/upload1.png"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      /// email
                      defaultFormField(
                        label: "email".tr(),
                        type: TextInputType.emailAddress,
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
                      ),
                      const SizedBox(height: 20),

                      /// password
                      defaultFormField(
                        label: "password".tr(),
                        isPassword: true,
                        maxLines: 1,
                        type: TextInputType.text,
                        controller: _passwordController,
                        validate: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Required'.tr();
                          } else if (!passwordRegex.hasMatch(value)) {
                            return "password_rules".tr();
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 20),

                      /// confirm password
                      defaultFormField(
                        label: "confirm_pass".tr(),
                        isPassword: true,
                        maxLines: 1,
                        type: TextInputType.text,
                        controller: _confirmPasswordController,
                        validate: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Required'.tr();
                          } else if (value != _passwordController.text) {
                            return 'password_not_same'.tr();
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 40),

                      /// button
                      GestureDetector(
                        child: Button_default(
                          height: 56,
                          title: "next".tr(),
                          color: const Color(0xff207954),
                          colortext: Colors.white,
                        ),
                        onTap: () {
                          if (formKey.currentState!.validate()) {

                            // if (selectedImage1 == null) {
                            //   ScaffoldMessenger.of(context).showSnackBar(
                            //     SnackBar(content: Text("please_select_image".tr())),
                            //   );
                            //   return;
                            // }
                            navigateTo(
                              context,
                              Registerpage2(
                                file: selectedImage1,
                                email: _emailController.text,
                                pass: _passwordController.text,
                              ),
                            );
                          }
                        },
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<File?> _pickImage(ImageSource source) async {
    try {
      final pickedFile = await _picker.pickImage(source: source);
      if (pickedFile != null) {
        return File(pickedFile.path);
      }
    } catch (e) {
      print("Error picking image: $e");
    }
    return null;
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
                leading: const Icon(Icons.camera),
                title: Text('pick_image'.tr()),
                onTap: () async {
                  Navigator.pop(context);
                  selectedImage1 = await _pickImage(ImageSource.camera);
                  setState(() {});
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
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
}

void navigateTo(context, widget) => Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => widget),
);
