// ignore_for_file: deprecated_member_use
import 'dart:io';
import 'dart:ui' as ui;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lacrosse/data/Local/sharedPref/sharedPref.dart';

import '../data/manager/cubit/news_cubit.dart';
import '../data/manager/cubit/news_states.dart';
import '../data/model/newsModel.dart';

class NewsDetailPage extends StatefulWidget {
  final int newsId;

  NewsDetailPage(this.newsId, {super.key});

  @override
  State<NewsDetailPage> createState() => _NewsDetailPageState();
}

class _NewsDetailPageState extends State<NewsDetailPage> {
  @override
  void initState() {
    super.initState();
    context.read<NewsCubit>().fetchAllNewsDataById(widget.newsId);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.read<NewsCubit>().fetchAllNewsData();
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocListener<NewsCubit, NewsState>(
          listener: (context, state) {
            if (state is NewDeletedSuccess) {
              Navigator.pop(context, true); // نرجع ومعانا إشارة إنه اتحذف
            }
            if (state is EditNewsSuccess) {
              Navigator.pop(context);

              Navigator.pop(context, true); // ✅ نرجع زي الحذف
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("edit_success".tr()),
                  backgroundColor: Colors.green,
                ),
              );
              context
                  .read<NewsCubit>()
                  .fetchAllNewsData(); // ✅ إعادة تحميل الأخبار
            } else if (state is EditNewsFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message.isNotEmpty
                      ? state.message
                      : "edit_failure".tr()), // ✅ ترجمة الخطأ
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          child: BlocBuilder<NewsCubit, NewsState>(
            builder: (context, state) {
              if (state is NewsByIdLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is NewsByIdSuccess) {
                final NewsModel newsModel = state.NewsData;
                String? currentImageUrl = newsModel.img;

// متغير للصورة الجديدة لو اتغيرت
                XFile? pickedImage;

                return Stack(
                  children: [
                    // الهيدر
                    Stack(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.14,
                          child: Container(
                            decoration: BoxDecoration(
                              image: const DecorationImage(
                                image: AssetImage("assets/images/top bar.png"),
                                fit: BoxFit.cover,
                              ),
                              gradient: LinearGradient(
                                colors: [
                                  Colors.green.shade900,
                                  Colors.green.shade700,
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 55),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // زرار رجوع
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                  context.read<NewsCubit>().fetchAllNewsData();
                                },
                                child: Row(
                                  children: [
                                    Container(
                                      height: 40,
                                      width: 40,
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.6),
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(8),
                                        ),
                                      ),
                                      child: const Icon(
                                        Icons.arrow_back_ios_sharp,
                                        color: Color(0xff185A3F),
                                        size: 20,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      'Back'.tr(),
                                      style: const TextStyle(
                                        color: Color(0xff185A3F),
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              if (CacheHelper.getData(key: "roles") ==
                                  "Admin") ...[
                                const Spacer(),
                                // زرار Edit
                                GestureDetector(
                                  onTap: () {
                                    showModalBottomSheet(
                                      context: context,
                                      isScrollControlled: true,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(16)),
                                      ),
                                      builder: (context) {
                                        final titleController =
                                            TextEditingController(
                                                text: newsModel.title);
                                        final descController =
                                            TextEditingController(
                                                text: newsModel.content);

                                        File?
                                            pickedImage; // هنا نخزن الصورة الجديدة اللي المستخدم هيختارها

                                        return StatefulBuilder(
                                          builder: (context, setState) {
                                            return Padding(
                                              padding: EdgeInsets.only(
                                                bottom: MediaQuery.of(context)
                                                    .viewInsets
                                                    .bottom,
                                                left: 16,
                                                right: 16,
                                                top: 24,
                                              ),
                                              child: SingleChildScrollView(
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Text(
                                                      "edit_news".tr(),
                                                      style: const TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 20),

                                                    // صورة الخبر
                                                    GestureDetector(
                                                      onTap: () async {
                                                        final image =
                                                            await ImagePicker()
                                                                .pickImage(
                                                                    source: ImageSource
                                                                        .gallery);
                                                        if (image != null) {
                                                          setState(() {
                                                            pickedImage = File(
                                                                image.path);
                                                          });
                                                        }
                                                      },
                                                      child: Container(
                                                        height: 150,
                                                        width: double.infinity,
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border.all(
                                                              color:
                                                                  Colors.grey),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(12),
                                                        ),
                                                        child:
                                                            pickedImage != null
                                                                ? ClipRRect(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            12),
                                                                    child: Image
                                                                        .file(
                                                                      pickedImage!,
                                                                      fit: BoxFit
                                                                          .cover,
                                                                    ),
                                                                  )
                                                                : ClipRRect(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            12),
                                                                    child: Image
                                                                        .network(
                                                                      newsModel
                                                                              .img ??
                                                                          "",
                                                                      fit: BoxFit
                                                                          .cover,
                                                                      errorBuilder: (context,
                                                                          error,
                                                                          stackTrace) {
                                                                        return Center(
                                                                          child: Icon(
                                                                              Icons.image,
                                                                              size: 50,
                                                                              color: Colors.grey),
                                                                        );
                                                                      },
                                                                    ),
                                                                  ),
                                                      ),
                                                    ),
                                                    const SizedBox(height: 20),

                                                    // حقل العنوان
                                                    TextFormField(
                                                      controller:
                                                          titleController,
                                                      decoration:
                                                          InputDecoration(
                                                        labelText: "title".tr(),
                                                        border:
                                                            const OutlineInputBorder(),
                                                      ),
                                                    ),
                                                    const SizedBox(height: 12),

                                                    // حقل الوصف
                                                    TextFormField(
                                                      controller:
                                                          descController,
                                                      decoration:
                                                          InputDecoration(
                                                        labelText:
                                                            "description".tr(),
                                                        border:
                                                            const OutlineInputBorder(),
                                                      ),
                                                      maxLines: 3,
                                                    ),
                                                    const SizedBox(height: 20),

                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          child: OutlinedButton(
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child: Text(
                                                              "cancel".tr(),
                                                              style: const TextStyle(
                                                                  color: Color(
                                                                      0xff185A3F)),
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            width: 10),
                                                        Expanded(
                                                          child: ElevatedButton(
                                                            style:
                                                                ElevatedButton
                                                                    .styleFrom(
                                                              backgroundColor:
                                                                  Color(
                                                                      0xff185A3F),
                                                            ),
                                                            onPressed:
                                                                () async {
                                                              String?
                                                                  uploadedImageUrl;

                                                              if (pickedImage !=
                                                                  null) {
                                                                uploadedImageUrl = await context
                                                                    .read<
                                                                        NewsCubit>()
                                                                    .uploadImage_video(
                                                                        file:
                                                                            pickedImage!);
                                                                print(
                                                                    "📸 Uploaded image URL: $uploadedImageUrl");
                                                              } else {
                                                                uploadedImageUrl =
                                                                    newsModel
                                                                        .img;
                                                              }
                                                              // print("📤 Final Update Data: ${NewsModel(
                                                              //   id: widget.newsId,
                                                              //   img: uploadedImageUrl,
                                                              //   title: titleController.text,
                                                              //   content: descController.text,
                                                              //   newsDetails: newsModel.newsDetails,
                                                              // ).toUpdateJson()}");
                                                              // استدعاء Cubit للتحديث
                                                              context
                                                                  .read<
                                                                      NewsCubit>()
                                                                  .EditNews(
                                                                    NewsModel(
                                                                      id: widget
                                                                          .newsId,
                                                                      img:
                                                                          uploadedImageUrl,
                                                                      title: titleController
                                                                          .text,
                                                                      content:
                                                                          descController
                                                                              .text,
                                                                      newsDetails:
                                                                          newsModel
                                                                              .newsDetails, // اللي المستخدم عدلها
                                                                    ),
                                                                  );
                                                            },
                                                            child: Text(
                                                              "update".tr(),
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(height: 10),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                    );
                                  },
                                  child: Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      color: Colors.blue.withOpacity(0.2),
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(8),
                                      ),
                                    ),
                                    child: const Icon(
                                      Icons.edit,
                                      color: Colors.blue,
                                      size: 22,
                                    ),
                                  ),
                                ),

                                const SizedBox(width: 10),

                                // زرار Delete
                                GestureDetector(
                                  onTap: () {
                                    showModalBottomSheet(
                                      context: context,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(16)),
                                      ),
                                      builder: (context) {
                                        return Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                "delete_title".tr(),
                                                style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              const SizedBox(height: 10),
                                              Text("delete_message".tr()),
                                              const SizedBox(height: 20),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: OutlinedButton(
                                                      onPressed: () {
                                                        Navigator.pop(
                                                            context); // يقفل الشيت
                                                      },
                                                      child: Text(
                                                        "cancel".tr(),
                                                        style: const TextStyle(
                                                            color:
                                                                Colors.green),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 10),
                                                  Expanded(
                                                    child: ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        backgroundColor:
                                                            Colors.red[300],
                                                      ),
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                        context
                                                            .read<NewsCubit>()
                                                            .DeleteNewsById(
                                                                id: widget
                                                                    .newsId);
                                                      },
                                                      child: Text(
                                                        "confirm".tr(),
                                                        style: const TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      color: Colors.red.withOpacity(0.2),
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(8),
                                      ),
                                    ),
                                    child: Icon(
                                      Icons.delete,
                                      color: Colors.red[300],
                                      size: 22,
                                    ),
                                  ),
                                )
                              ],
                            ],
                          ),
                        ),
                      ],
                    ),

                    // جسم الصفحة
                    Container(
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.14),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // صورة الخبر
                                Stack(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(16.0)),
                                        child: Image.network(
                                          newsModel.img.toString(),
                                          height: 150,
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                            return Center(
                                              child: Image.asset(
                                                'assets/images/photo.png',
                                                height: 150,
                                                width: double.infinity,
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                    Positioned.fill(
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [
                                              Color(0xff185A3F),
                                              Colors.transparent,
                                            ],
                                            begin: Alignment.bottomCenter,
                                            end: Alignment.topCenter,
                                          ),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(16.0)),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 0,
                                      left: 0,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12.0, vertical: 4.0),
                                        width: 100,
                                        height: 35,
                                        decoration: const BoxDecoration(
                                          color: Color(0xffFFDB99),
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(30),
                                            bottomRight: Radius.circular(30),
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            newsModel.oldOrNew == false
                                                ? "New".tr()
                                                : "Old".tr(),
                                            style: const TextStyle(
                                              color: Color(0xff333333),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                // العنوان والتفاصيل
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        newsModel.title.toString(),
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black87,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.access_time,
                                            size: 14,
                                            color: Colors.grey,
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            newsModel.postTime.toString(),
                                            style: const TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 16),
                                      Text(
                                        newsModel.content.toString(),
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                );
              } else {
                return const SizedBox(height: 1);
              }
            },
          ),
        ),
      ),
    );
  }
}
