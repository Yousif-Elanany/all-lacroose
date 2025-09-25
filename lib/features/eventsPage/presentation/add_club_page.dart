import 'dart:convert';
import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lacrosse/features/eventsPage/data/manager/cubit/manager_cubit.dart';
import 'package:lacrosse/features/eventsPage/data/manager/cubit/manager_states.dart';

import '../../../data/Local/sharedPref/sharedPref.dart';
import '../../auth/pressntation/loginPage.dart';
import '../../layout/Tabs/BaseScreen.dart';
import '../widgets/button_default.dart';
import '../widgets/custom_drop_down.dart';
import '../widgets/textFeild_default.dart';
import 'add_player_trainer.dart';

class Add_club_page extends StatefulWidget {
  @override
  State<Add_club_page> createState() => _Add_club_pageState();
}

class _Add_club_pageState extends State<Add_club_page> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var ClubNameController = TextEditingController();

  File? _selectedImage; // لتخزين الصورة المختارة
  File? selectedImage1;
  final ImagePicker _picker = ImagePicker();
  Future<void> _pickImage(ImageSource source) async {
    try {
      // اختيار الصورة
      final pickedFile = await _picker.pickImage(source: source);

      if (pickedFile != null) {
        setState(() {
          _selectedImage = File(pickedFile.path); // تحديث الصورة المختارة
        });
        print("Image Path: ${pickedFile.path}");

        // تحويل الصورة إلى نص Base64 وطباعة النص
        String base64Image =
            base64Encode(await File(pickedFile.path).readAsBytes());
        print("Base64 String: $base64Image");
      } else {
        print("No image selected.");
      }
    } catch (e) {
      print("Error picking image: $e");
    }
  }

  void _showImageSourceSelector(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Wrap(
          children: [
            ListTile(
              leading: Icon(Icons.photo_library),
              title: Text("select_from_galary".tr()),
              onTap: () {
                Navigator.pop(context); // إغلاق الـ BottomSheet
                _pickImage(ImageSource.gallery);
              },
            ),
            ListTile(
              leading: Icon(Icons.camera_alt),
              title: Text('pick_image'.tr()),
              onTap: () {
                Navigator.pop(context); // إغلاق الـ BottomSheet
                _pickImage(ImageSource.camera);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: BlocConsumer<managerCubit, ManagerStates>(
          listener: (BuildContext context, ManagerStates state) {
            if (state is addClubSuccess) {
              _showAwesomeDialog(context);
            }
          },
          builder: (BuildContext context, ManagerStates state) {
            return Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.13,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          'assets/images/top bar.png'), // Replace with your asset path
                      fit: BoxFit.cover, // Adjust to control how the image fits
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * .06,
                      right: 8,
                      left: 8),
                  child: Form(
                    key: formKey,
                    child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.end,
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
                                      color: Color(0xff185A3F), size: 24),
                                ),
                              ),
                            ),
                            Text(
                              "add_club".tr(),
                              style: TextStyle(
                                color: Color(0xff207954), //999999
                                fontSize: 24,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .03,
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      _showImageSourceSelector(context);
                                    },
                                    child: Stack(
                                      alignment:
                                          CacheHelper.getData(key: "lang") ==
                                                  "1"
                                              ? Alignment.bottomLeft
                                              : Alignment.bottomRight,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.only(
                                              top: 10, bottom: 10),
                                          height: 92,
                                          width: 82,
                                          child: CircleAvatar(
                                            backgroundColor: Colors.white,
                                            child: _selectedImage == null
                                                ? Image(
                                                    image: AssetImage(
                                                        "assets/images/reg.png"),
                                                    fit: BoxFit.cover,
                                                  )
                                                : ClipOval(
                                                    child: Image.file(
                                                      _selectedImage!,
                                                      fit: BoxFit.cover,
                                                      // width: double.infinity,
                                                      // height: double.infinity,
                                                    ),
                                                  ),
                                          ),
                                        ),
                                        CircleAvatar(
                                          backgroundColor: Colors.white,
                                          radius: 19,
                                          child: Image.asset(
                                            "assets/images/upload1.png",
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  DefaultFormField(
                                    label: "club_name".tr(),
                                    controller: ClubNameController,
                                    type: TextInputType.text,
                                    validate: (value) {
                                      if (value!.isEmpty) {
                                        return 'Required'.tr();
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        .58,
                                  ),
                                  GestureDetector(
                                      onTap: (state is addClubLoading)
                                          ? null
                                          : () {
                                              if (formKey.currentState!
                                                  .validate()) {
                                                if (_selectedImage == null) {
                                                  ScaffoldMessenger.of(context).showSnackBar(
                                                    SnackBar(content: Text("please_select_image".tr())),
                                                  );
                                                  return;
                                                }
                                                BlocProvider.of<
                                                        managerCubit>(context)
                                                    .addClubByManager(
                                                        name: ClubNameController
                                                            .text,
                                                        file: _selectedImage ==
                                                                null
                                                            ? null
                                                            : _selectedImage);
                                              }
                                              ClubNameController.text = "";
                                              _selectedImage = null;
                                              setState(() {});
                                            },
                                      child: Button_default(
                                        height: 48,
                                        title: "adding_club".tr(),
                                        color: Color(0xff207954),
                                      )),
                                  SizedBox(
                                    height: 30,
                                  ),
                                ]),
                          ),
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
}

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );
