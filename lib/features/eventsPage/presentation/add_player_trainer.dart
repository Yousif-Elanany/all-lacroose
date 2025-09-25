import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lacrosse/features/eventsPage/data/manager/cubit/manager_states.dart';
import 'package:lacrosse/features/orders/presentation/orders_page.dart';
import '../../../data/Local/sharedPref/sharedPref.dart';

import '../../accountPage/widgets/textFeild_default.dart';
import '../../auth/data/manager/cubit/auth_cubit.dart';
import '../../auth/data/manager/cubit/auth_states.dart';
import '../../auth/data/model/natinalityModel.dart';
import '../../auth/data/model/team.dart';
import '../data/manager/cubit/manager_cubit.dart';
import '../widgets/button_default.dart';
import '../widgets/button_select_register.dart';
import '../widgets/textFeild_default.dart';
import 'add_player.dart';

class Add_player_trainer extends StatefulWidget {
  const Add_player_trainer({super.key});

  @override
  State<Add_player_trainer> createState() => _Add_player_trainerState();
}

class _Add_player_trainerState extends State<Add_player_trainer> {
  var _birthdateController = TextEditingController();

  var nameController = TextEditingController();
  var cityController = TextEditingController();
  var areaController = TextEditingController();
  var addressController = TextEditingController();
  var phoneController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool is_player = true;
  List<TeamModel> teamsList = [];
  List<NationalityModel> nationality = [];
  bool selected_register = true; // القيمة المختارة

  NationalityModel? selectedNationality;
  TeamModel? selectedTeam;
  int selected_user_type = 1;
  int selected_clubID = 3;
  int selected_nationalityID = 0;
  int selected_TeamID = 0;
  int selectedtype = 0;
  File? selectedImage1;
  final ImagePicker _picker = ImagePicker();

  DateTime selectedDate = DateTime.now();
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate)
      if (!mounted) return; // ⚠️ منع setState بعد dispose

    setState(() {
        selectedDate = picked!;
        // print("fgfgfgfgfgfff$selectedDate");
      });
  }

  File? _selectedImage; // لتخزين الصورة المختارة

  Future<void> _pickImage(ImageSource source) async {
    try {
      // اختيار الصورة
      final pickedFile = await _picker.pickImage(source: source);

      if (pickedFile != null) {
        if (!mounted) return; // ⚠️ منع setState بعد dispose

        setState(() {
          _selectedImage = File(pickedFile.path);
          //  context.read<managerCubit>().uploadImage_video(file:  File(pickedFile.path));
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
              title: Text("Choose from Gallery"),
              onTap: () {
                Navigator.pop(context); // إغلاق الـ BottomSheet
                _pickImage(ImageSource.gallery);
              },
            ),
            ListTile(
              leading: Icon(Icons.camera_alt),
              title: Text("Take a Photo"),
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
  void initState() {
    super.initState();
    context.read<AuthCubit>().fetchAllTeams();
    context.read<AuthCubit>().fetchAllNationality();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: BlocConsumer<AuthCubit, AuthStates>(listener: (context, state) {
          if (!mounted) return; // ⚠️ منع setState بعد dispose

          if (state is fetch_team_success) {
            teamsList = state.TeamData;
            // print("gooooooooooooooooooo");
            // print(widget.teamsList.length);
            // print(widget.teamsList[0].name);
          }
          if (state is fetch_Nationality_success) {
            nationality = state.NationalityData;
          }
          if (state is addUserSuccess) {
            _showAwesomeDialog(context);
          }
        }, builder: (context, state) {
          return Stack(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.12,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          'assets/images/top bar.png'), // Replace with your asset path
                      fit: BoxFit.cover, // Adjust to control how the image fits
                    ),
                    gradient: LinearGradient(
                      colors: [Colors.white, Colors.white60],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 45),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 0.0, top: 0),
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
                      "add_player_trainer".tr(),
                      style: TextStyle(
                        color: Color(0xff207954), //999999
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        // navigateTo(context, Order_page());
                      },
                      child: Text(
                        "join_order".tr(),
                        style: TextStyle(
                          color: Color(0xff207954), //999999
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.12,
                    right: MediaQuery.of(context).size.width * .05,
                    left: MediaQuery.of(context).size.width * .05),
                child: Form(
                  key: formKey,
                  child: Column(
                    //mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // SizedBox(
                      //   height: MediaQuery.of(context).size.height * .03,
                      // ),
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
                            "1",
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
                            "  2".tr(),
                            style: TextStyle(
                              ///  color: Color(0xff328361),
                              fontSize: 16,
                              //fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          _showImageSourceSelector(context);
                        },
                        child: Stack(
                          alignment: CacheHelper.getData(key: "lang") == "1"
                              ? Alignment.bottomLeft
                              : Alignment.bottomRight,
                          children: [
                            Container(
                              padding: EdgeInsets.only(top: 10, bottom: 10),
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
                                          width: double.infinity,
                                          height: double.infinity,
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
                        height: 24,
                      ),
                      Text(
                        "reg_as".tr(),
                        style: TextStyle(
                          ///  color: Color(0xff328361),
                          fontSize: 16,
                          //fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(children: [
                        Button_select_register(
                          text: "player".tr(),
                          is_Player: true,
                          groupValue: selected_register,
                          onChanged: (value) {
                            selected_register = value!;
                            setState(() {
                              selectedtype = 0;
                              print(selectedtype);
                            });
                          },
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Button_select_register(
                          text: "trainer".tr().tr(),
                          is_Player: false,
                          groupValue: selected_register,
                          onChanged: (value) {
                            selected_register = value!;
                            setState(() {
                              selectedtype = 1;
                              print(selectedtype);
                            });
                          },
                        )
                      ]),
                      SizedBox(
                        height: 20,
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                DefaultFormField(
                                  label: "name".tr(),
                                  type: TextInputType.text,
                                  controller: nameController,
                                  validate: (value) {
                                    if (value!.isEmpty) {
                                      return 'Required'.tr();
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                // DefaultFormField(
                                //   label: "birthday".tr(),
                                //   type: TextInputType.text,
                                // ),
                                GestureDetector(
                                  onTap: () async {
                                    await _selectDate(context);
                        
                                    String formattedDate =
                                        DateFormat('yyyy-MM-dd')
                                            .format(selectedDate);
                                    _birthdateController.text =
                                        formattedDate;
                        
                                    setState(() {});
                                  },
                                  child: AbsorbPointer(
                                    child: defaultFormField(
                                      //  hint: "hhhh",
                                      label: "birthday".tr(),
readOnly: true,
                                      type: TextInputType.text,

                                      controller: _birthdateController,
                                      validate: (value) {
                                        if (value!.isEmpty) {
                                          return 'Required'.tr();
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                DefaultFormField(
                                  label: "phone_number".tr(),
                                  controller: phoneController,
                                  type: TextInputType.phone,
                                  validate: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'enter_saudi_number'.tr();
                                    }
                        
                                    final pattern =
                                        r'^5\d{8}$'; // يبدأ بـ 5 ويتبعه 8 أرقام
                                    final regex = RegExp(pattern);
                        
                                    if (!regex.hasMatch(value)) {
                                      return 'enter_saudi_number'.tr();
                                    }
                        
                                    return null;
                                  },
                                ),
                                SizedBox(
                                  height: 20,
                                ), // CustomDropdownButton(
                                //   items: items,
                                //   hint: 'club'.tr(),
                                //   //initialValue: 'Option 1',
                                //   onChanged: (value) {
                                //     // print('القيمة المختارة: $value');
                                //   },
                                // ),
                                build_Teams_dropDown_bottom(
                                    hint: 'club'.tr()),
                                SizedBox(
                                  height: 20,
                                ),
                                /*     CustomDropdownButton(
                                                    items: items,
                                                    hint: 'nationality'.tr(),
                                                    //initialValue: 'Option 1',
                                                    onChanged: (value) {
                            // print('القيمة المختارة: $value');
                                                    },
                                                  ), */
                                build_Nationality_dropDown_bottom(
                                    hint: 'nationality'.tr()),
                                SizedBox(
                                  height: 20,
                                ),
                                // CustomDropdownButton(
                                //   items: items,
                                //   hint: 'city'.tr(),
                                //   //initialValue: 'Option 1',
                                //   onChanged: (value) {
                                //     // print('القيمة المختارة: $value');
                                //   },
                                // ),
                                DefaultFormField(
                                  label: "city".tr(),
                                  controller: cityController,
                                  type: TextInputType.text,
                                  validate: (value) {
                                    if (value!.isEmpty) {
                                      return 'Required'.tr();
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                // CustomDropdownButton(
                                //   items: items,
                                //   hint: 'area'.tr(),
                                //   //initialValue: 'Option 1',
                                //   onChanged: (value) {
                                //     // print('القيمة المختارة: $value');
                                //   },
                                // ),
                                DefaultFormField(
                                  label: "area".tr(),
                                  controller: areaController,
                                  type: TextInputType.text,
                                  validate: (value) {
                                    if (value!.isEmpty) {
                                      return 'Required'.tr();
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                DefaultFormField(
                                  label: "address".tr(),
                                  type: TextInputType.text,
                                  validate: (value) {
                                    if (value!.isEmpty) {
                                      return 'Required'.tr();
                                    }
                                    return null;
                                  },
                                  controller: addressController,
                                  //  hint: "رقم الجوال"
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                          onTap: () {
                            print("address ${addressController.text}");
                            print('area ${areaController.text}');
                            print("city ${cityController.text}");
                            print("date ${_birthdateController.text}");
                            print(nameController.text);
                            print(selected_nationalityID);
                            print(selectedtype);
                            print(selected_TeamID);

                            if (formKey.currentState!.validate()) {
                              if (_selectedImage == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("please_select_image".tr())),
                                );
                                return;
                              }

                              navigateTo(
                                context,
                                Add_player_trainer2(
                                  userPhone: phoneController.text,
                                  userAddress: addressController.text,
                                  userArea: areaController.text,
                                  userCity: cityController.text,
                                  userDate: _birthdateController.text,
                                  displayName: nameController.text,
                                  userNationalityId: selected_nationalityID,
                                  userType: selectedtype,
                                  userTeamId: selected_TeamID,
                                  userImage: _selectedImage,
                                ),
                              );
                            }
                          }
                          ,
                          child: Button_default(
                            height: 48,
                            title: "next".tr(),
                            color: Color(0xff207954),
                          )),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                    ],
                  ),
                ),
              )
            ],
          );
        }));
  }

  Widget build_Teams_dropDown_bottom({required String hint}) {
    final uniqueTeamsList = teamsList.toSet().toList();

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
              fontWeight: FontWeight.w700),
        ),
        onChanged: (TeamModel? newValue) {
          setState(() {
            selectedTeam = newValue;
            selected_TeamID = selectedTeam!.id;
            print(selected_TeamID);
          });
          setState(() {

          });
        },
        validator: (value) {
          if (value == null) {
            return 'Please_select_a_team'.tr();
          }
          return null;
        },
        items:
            uniqueTeamsList.map<DropdownMenuItem<TeamModel>>((TeamModel value) {
          return DropdownMenuItem<TeamModel>(
            value: value,
            child: Text(value.name),
          );
        }).toList(),
        dropdownColor: const Color(0xfff9f9f9),
        borderRadius: BorderRadius.circular(12),
        icon:
            const Icon(Icons.keyboard_arrow_down_outlined, color: Colors.black),
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
          contentPadding:
              EdgeInsets.symmetric(vertical: 10), // ضبط المحاذاة عموديًا
        ),
        hint: Text(
          hint,
          style: const TextStyle(
              color: Color(0xff999999),
              fontSize: 16,
              fontWeight: FontWeight.w700),
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
        items: nationality
            .map<DropdownMenuItem<NationalityModel>>((NationalityModel value) {
          return DropdownMenuItem<NationalityModel>(
            value: value,
            child: Text(value.nationalityName),
          );
        }).toList(),
        dropdownColor: const Color(0xfff9f9f9),
        borderRadius: BorderRadius.circular(12),
        icon:
            const Icon(Icons.keyboard_arrow_down_outlined, color: Colors.black),
        iconSize: 24,
        style: const TextStyle(color: Colors.black, fontSize: 16),
      ),
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
}

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );
