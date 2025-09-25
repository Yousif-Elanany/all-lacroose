// ignore_for_file: deprecated_member_use
import 'dart:ui' as ui;
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/manager/cubit/news_cubit.dart';
import '../data/manager/cubit/news_states.dart';
import '../data/model/newsModel.dart';

class NewsDetailPage extends StatefulWidget {
  int newsId;

  NewsDetailPage(this.newsId);
  @override
  State<NewsDetailPage> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<NewsDetailPage> {
  void initState() {
    super.initState();

    context.read<NewsCubit>().fetchAllNewsDataById(widget.newsId);
  }

  // //final _controller = PageController();
  // CarouselSliderController _carouselController = CarouselSliderController();
  // int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.read<NewsCubit>().fetchAllNewsData();
        return true;
      },
      child: Scaffold(
          backgroundColor: Colors.white,
          body: BlocBuilder<NewsCubit, NewsState>(
            builder: (context, state) {
              if (state is NewsByIdLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is NewsByIdSuccess) {
                final NewsModel newsModel = state.NewsData;
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
                              colors: [
                                Colors.green.shade900,
                                Colors.green.shade700
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 0.0, vertical: 50.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {

                                Navigator.pop(context);
                                         context.read<NewsCubit>().fetchAllNewsData();
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
                                  child: Icon(Icons.arrow_back_ios_sharp,
                                      color: Color(0xff185A3F), size: 20),
                                ),
                              ),
                            ),
                            Text(
                              'Back'.tr(),
                              style: TextStyle(
                                color: Color(0xff185A3F),
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     SizedBox(),
                        //     GestureDetector(
                        //       onTap: () {
                        //         Navigator.pop(context);
                        //         context.read<NewsCubit>().fetchAllNewsData();
                        //       },
                        //       child: Padding(
                        //         padding: const EdgeInsets.only(top: 15.0),
                        //         child: Row(
                        //           children: [
                        //             Text(
                        //               'Back'.tr(),
                        //               style: TextStyle(
                        //                 color: Color(0xff185A3F),
                        //                 fontSize: 20,
                        //                 fontWeight: FontWeight.bold,
                        //               ),
                        //             ),
                        //             Padding(
                        //               padding: const EdgeInsets.only(
                        //                   left: 8.0, top: 8),
                        //               child: Container(
                        //                 height: 40,
                        //                 width: 40,
                        //                 decoration: BoxDecoration(
                        //                   color: Colors.white.withOpacity(0.6),
                        //                   borderRadius: BorderRadius.all(
                        //                     Radius.circular(8),
                        //                   ),
                        //                 ),
                        //                 child: Icon(
                        //                     Icons.arrow_forward_ios_rounded,
                        //                     color: Color(0xff185A3F),
                        //                     size: 20),
                        //               ),
                        //             ),
                        //           ],
                        //         ),
                        //       ),
                        //     ),
                        //   ],
                        // ),
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
                        padding: const EdgeInsets.all(8.0),
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Image and "New" tag
                                Stack(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(16.0)),
                                        child: Image.network(
                                          newsModel.img.toString(),
                                          // Replace with your image path
                                          height: 150,
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                          errorBuilder: (BuildContext context,
                                              Object error,
                                              StackTrace? stackTrace) {
                                            return Center(
                                                child: Image.asset(
                                                    'assets/images/photo.png',
                                                    height: 150,
                                                    width: double.infinity));
                                          },
                                        ),
                                      ),
                                    ),
                                    Positioned.fill(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [
                                              Color(
                                                  0xff185A3F), // Green at the bottom
                                              Colors
                                                  .transparent, // Transparent at the top
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
                                          //  borderRadius: BorderRadius.circular(8.0),
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
                                // Title and description
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        newsModel.title.toString(),

                                        // textDirection: TextDirection.ltr,
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          const Icon(
                                            Icons.access_time,
                                            size: 14,
                                            color: Colors.grey,
                                          ),
                                          // const Text("",
                                          //   //newsModel.title.toString(),
                                          //
                                          //   style: TextStyle(
                                          //     fontSize: 12,
                                          //     color: Colors.grey,
                                          //   ),
                                          // ),
                                          Text(
                                            newsModel.postTime.toString(),
                                            style: const TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          const SizedBox(width: 8),

                                          //    const Spacer(),
                                        ],
                                      ),
                                      const SizedBox(height: 16),
                                      Column(
                                        children: [
                                          Text(
                                            newsModel.content.toString(),
                                            // textDirection: TextDirection.rtl,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              color: Colors.black87,
                                            ),
                                          ),
                                        ],
                                      )
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
              } else
                return SizedBox(
                  height: 1,
                );
            },
          )),
    );
  }
}
