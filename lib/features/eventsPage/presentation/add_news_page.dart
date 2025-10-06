
import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lacrosse/features/eventsPage/data/manager/cubit/manager_cubit.dart';
import 'package:lacrosse/features/eventsPage/data/manager/cubit/manager_states.dart';

import 'package:lacrosse/features/eventsPage/widgets/custom_drop_down.dart';

import '../../layout/Tabs/BaseScreen.dart';

import '../data/model/IntentityNewsModel.dart';
import '../widgets/bottom_sheet_main.dart';
import '../widgets/button_default.dart';
import '../widgets/textFeild_default.dart';

class Add_news_page extends StatefulWidget {
  const Add_news_page({super.key});

  @override
  State<Add_news_page> createState() => _Add_news_pageState();
}

class _Add_news_pageState extends State<Add_news_page> {
  List<Widget> buildText_imagePickerList = [];
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var _detailsController = TextEditingController();
  var _titleControler = TextEditingController();
  var _descriptionControler = TextEditingController();

  bool newText = false;
  bool newImage = false;
  bool isSelectMainImage = false;
  String mainImageLink = "";
  List<NewsDetailModel> listDetails = [];


  File? selectedImage1;
  File? selectedImage2;
  final ImagePicker _picker = ImagePicker();
  List<File> list_selected_mediaFile = [];
  List<String> list_uploaded_link = [];

  Widget build(BuildContext context) {
    return BlocConsumer<managerCubit, ManagerStates>(
      listener: (context, state) {
        String link = "";

        if (state is Image_videoSuccess) {
          link = state.Image_videoLink;
          if (isSelectMainImage) {
            mainImageLink = link;
          } else {
            listDetails.add(NewsDetailModel(
                type: 1, newsId: 0, content:link));
          }
        }
        if (state is AddNewsEventSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("news_added_success".tr()),
              backgroundColor: Colors.green,
              behavior: SnackBarBehavior.floating,
            ),
          );
        }




      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
            body: Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.13,
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    image: DecorationImage(
                      image: AssetImage('assets/images/top bar.png'),
                      // Replace with your asset path
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
                        children: [
                          Row(
                            children: [
                              GestureDetector(
                                onTap: (){
                                  Navigator.of(context).pop();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 0.0, top: 0),
                                  child: Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.6),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(8),
                                      ),
                                    ),
                                    child: Icon(
                                        Icons.arrow_back_ios_outlined,
                                        color: Color(0xff185A3F),
                                        size: 24),
                                  ),
                                ),
                              ),
                              Text(
                                "add_news".tr(),
                                style: TextStyle(
                                  color: Color(0xff207954),
                                  fontSize: 24,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.height * 0.037),

                          // الجزء القابل للتمرير
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  // عناصر أخرى
                                  Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(16),
                                        child: Container(
                                          height: 160,
                                          width: double.infinity,
                                          child: list_selected_mediaFile.isNotEmpty
                                              ? Image.file(list_selected_mediaFile[0],
                                              fit: BoxFit.cover)
                                              : Image.asset("assets/images/photo.png",
                                              fit: BoxFit.cover),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 10,
                                        left: 10,
                                        child: GestureDetector(
                                          onTap: () {
                                            _showPickerDialog(context);
                                            isSelectMainImage=true;

                                            setState(() {});
                                          },
                                          child: CircleAvatar(
                                            backgroundColor: Colors.white,
                                            radius: 19,
                                            child: Image.asset(
                                                "assets/images/upload1.png"),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                      height:
                                      MediaQuery.of(context).size.height * 0.02),
                                  DefaultFormField(
                                    label: "news_title".tr(),
                                    type: TextInputType.text,
                                    controller: _titleControler,
                                    validate: (value) {
                                      if (value!.isEmpty) {
                                        return 'Required'.tr();
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(
                                      height:
                                      MediaQuery.of(context).size.height * 0.02),
                                  DefaultFormField(
                                    label: "news_text".tr(),
                                    controller: _descriptionControler,
                                    validate: (value) {
                                      if (value!.isEmpty) {
                                        return 'Required'.tr();
                                      }
                                      return null;
                                    },
                                    type: TextInputType.text,
                                    minLines: 5,
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          isSelectMainImage=false;
                                          if(list_selected_mediaFile.isNotEmpty){
                                          showCustomBottomSheet(context);
                                          }else{
                                            showSnackbar(context,"complete main data first");
                                          }

                                        },
                                        child: Container(
                                          height: 56,
                                          // زيادة ارتفاع الحاوية لضمان احتواء النص والصورة
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(16),
                                            border: Border.all(
                                              color: Colors.grey
                                                  .withOpacity(.1), // لون الحدود
                                              width: 1, // سمك الحدود
                                            ),
                                          ),
                                          padding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                          // حشو داخلي أفقي
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            // توزيع العناصر
                                            crossAxisAlignment: CrossAxisAlignment
                                                .center, // محاذاة العناصر في المنتصف رأسيًا
                                            children: [
                                              Image.asset(
                                                "assets/images/add.png",
                                                fit: BoxFit.cover,
                                                width: 24, // عرض الصورة
                                                height: 24, // ارتفاع الصورة
                                              ),
                                              SizedBox(
                                                  width: 8), // مسافة بين الصورة والنص
                                              Text(
                                                "add_text_photo".tr(),
                                                style: TextStyle(
                                                  fontSize: 16, // حجم النص
                                                  color: Colors.black, // لون النص
                                                ),
                                                // النقاط إذا كان النص طويلًا
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Flexible(
                                        child: SizedBox(
                                          height: 88,
                                          child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount:
                                            (list_selected_mediaFile.length > 1)
                                                ? list_selected_mediaFile.length -
                                                1
                                                : 0,
                                            itemBuilder: (context, index) {
                                              final fileIndex = index +
                                                  1;
                                              if (fileIndex <
                                                  list_selected_mediaFile.length) {
                                                return Stack(
                                                  children: [
                                                    ClipRRect(
                                                      borderRadius:
                                                      BorderRadius.circular(20),
                                                      child: Container(
                                                        width:
                                                        (list_selected_mediaFile
                                                            .length) >
                                                            1
                                                            ? 88
                                                            : 0,
                                                        margin: EdgeInsets.symmetric(
                                                            horizontal: 5),
                                                        color: Colors.blue,
                                                        child: Image.file(
                                                          list_selected_mediaFile[
                                                          fileIndex],
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),
                                                    Positioned(
                                                      top: 0,
                                                      left: 0,
                                                      child: Row(
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                        children: [
                                                          GestureDetector(
                                                            onTap: () {
                                                              list_selected_mediaFile
                                                                  .removeAt(
                                                                  fileIndex);
                                                              setState(() {});
                                                            },
                                                            child: CircleAvatar(
                                                              backgroundColor:
                                                              Colors.white,
                                                              radius: 10,
                                                              child: Icon(
                                                                Icons.close_outlined,
                                                                color: Colors.red,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              } else {
                                                return Container(); // تجنب الأخطاء عند تجاوز الفهرس
                                              }
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  newText ? _buildTextField() : Container(),
                                  SizedBox(
                                      height:
                                      MediaQuery.of(context).size.height * .01),

                                  // العناصر الإضافية
                                  SizedBox(
                                      height:
                                      MediaQuery.of(context).size.height * 0.00),
                                  // CustomDropdownButton(
                                  //   items: items,
                                  //   hint: 'news_share'.tr(),
                                  //   onChanged: (value) {},
                                  // ),
                                  SizedBox( height:!newText?
                                  MediaQuery.of(context).size.height * 0.12:0),
                                  GestureDetector(
                                    onTap:(state is AddNewsEventLoading)?null: () async {
                                      if (newText) {
                                        listDetails.add(NewsDetailModel(
                                            type: 0,
                                            newsId: 0,
                                            content: _detailsController.text));
                                      }
                                      if (formKey.currentState!.validate()) {
                               await         context.read<managerCubit>().addNewsEvent(
                                            listNewsDetails: listDetails,
                                            description: _descriptionControler.text,
                                            title: _titleControler.text,
                                            image: selectedImage1.toString()??"");

                                        _titleControler.text = "";
                                        _descriptionControler.text ="";
                                        _detailsController.text="";
                                        list_selected_mediaFile.clear();
                                      }
                                    },

                                    child: Button_default(
                                      height: 48,
                                      title: "adding_news".tr(),
                                      color: Color(0xff207954),
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )

                ),
              ],
            ));
      },
    );
  }

  Widget _buildImagePicker(
      {required VoidCallback onTap_upload, required onTap_cancle}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Container(
              height: 160,
              width: double.infinity,
              child: selectedImage2 != null
                  ? Image.file(
                selectedImage2!,
                fit: BoxFit.cover,
              )
                  : Image.asset(
                "assets/images/photo_2.png",
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: 10,
            left: 10,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: onTap_cancle,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 16,
                    child: Icon(Icons.close_outlined, color: Colors.red),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 10,
            left: 10,
            child: GestureDetector(
              onTap: onTap_upload,
              child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 19,
                  child: Image.asset(
                    "assets/images/upload1.png",
                  )),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Stack(children: [
        DefaultFormField(
            controller: _detailsController,
            label: "news_text".tr(),
            type: TextInputType.text,
            validate: (value) {
              if (value!.isEmpty) {
                return 'Required'.tr();
              }
              return null;
            },
            minLines: 5),
        Positioned(
          top: 10,
          left: 10,
          child: GestureDetector(
            onTap: () {
              newText = false;
              setState(() {
                //print("jooo");
              });
            },
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 16,
              child: Icon(Icons.close_outlined, color: Colors.red),
            ),
          ),
        ),
      ]),
    );
  }

  Widget _buildText_Image(int type) {
    if (type == 0) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Stack(children: [
          DefaultFormField(
              label: "news_text".tr(), type: TextInputType.text, minLines: 5),
          Positioned(
            top: 10,
            left: 10,
            child: GestureDetector(
              onTap: () {
                newText = false;
                setState(() {
                  //print("jooo");
                });
              },
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 16,
                child: Icon(Icons.close_outlined, color: Colors.red),
              ),
            ),
          ),
        ]),
      );
    } else
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Container(
                height: 160,
                width: double.infinity,
                child: selectedImage2 != null
                    ? Image.file(
                  selectedImage2!,
                  fit: BoxFit.cover,
                )
                    : Image.asset(
                  "assets/images/photo_2.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              top: 10,
              left: 10,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 16,
                      child: Icon(Icons.close_outlined, color: Colors.red),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 10,
              left: 10,
              child: GestureDetector(
                onTap: () {},
                child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 19,
                    child: Image.asset(
                      "assets/images/upload1.png",
                    )),
              ),
            ),
          ],
        ),
      );
  }

  Future<File?> _pickImage(ImageSource source) async {
    try {
      final pickedFile = await _picker.pickImage(
        source: source,
      );
      if (pickedFile != null) {
        BlocProvider.of<managerCubit>(context)
            .uploadImage_video(file: File(pickedFile.path));

  if(isSelectMainImage==true && list_selected_mediaFile.isNotEmpty){

    list_uploaded_link.removeAt(0);
    list_selected_mediaFile.removeAt(0);
list_selected_mediaFile.insert(0, File(pickedFile.path));
  }else {
        list_selected_mediaFile.add(File(pickedFile.path));
  }
        return File(pickedFile.path);
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
                  selectedImage1 = await _pickImage(ImageSource.gallery);

                  setState(() {});
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void showCustomBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return CustomBottomSheet(
          hight: 246.0,
          title: 'add_text_photo'.tr(),
          items: [
            Text(
              'add_photo'.tr(),
              style: const TextStyle(fontSize: 16, color: Color(0xffDE3030),

                fontWeight: FontWeight.w500,),
            ),
            Text(
              'add_text'.tr(),
              style: const TextStyle(fontSize: 16, color: Color(0xffDE3030),

                fontWeight: FontWeight.w500,),
            ),


          ],
          onItemTap: (index) async {
            Navigator.pop(context);
            setState(() {});
            if (index == 0) {
             _showPickerDialog(context);
            }
            if (index == 1) {
              !newText
                  ? newText = true
                  : showSnackbar(context, 'END THIS NEWS FIRST !');

            }

          },
        );
      },
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
  void _showAwesomeDialog(BuildContext context) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.success, // success, error, warning, info
      animType: AnimType.leftSlide,  // fade, leftSlide, rightSlide, scale
      title: 'success'.tr(),
      desc: 'Gob_done_successfully'.tr(),
      btnOkOnPress: () {},

    ).show();

  }
  void showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message), // نص الرسالة
        duration: Duration(seconds: 2), // مدة عرض الرسالة
        action: SnackBarAction(
          label: 'Undo', // زر الإجراء
          onPressed: () {
            // إجراء عند النقر على الزر
          },
        ),
      ),
    );
  }

  void navigateTo(BuildContext context, Widget widget) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => widget,
      ),
    );
  }
}
