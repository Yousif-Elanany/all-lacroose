// ignore_for_file: deprecated_member_use
import 'dart:ui' as ui;
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart' ;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lacrosse/features/home/data/manager/cubit/home_cubit.dart';
import 'package:lacrosse/features/home/data/models/aboutUnion.dart';


class AboutUnionPage extends StatefulWidget {



  @override
  State<AboutUnionPage> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<AboutUnionPage> {
  void initState() {
    super.initState();

    context.read<HomeCubit>().fetchAboutUnionData();
  }

  //final _controller = PageController();
  CarouselSliderController _carouselController = CarouselSliderController();
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{

     //   context.read<HomeCubit>().fetchAboutUnionData();
        context.read<HomeCubit>().fetchAdvertisement();
        context.read<HomeCubit>().fetchAlltEAMS();
        Navigator.pop(context);
        return true ;
      },
      child: Scaffold(
          backgroundColor: Colors.white,
          body: BlocBuilder<HomeCubit, HomeStates>(
            builder: (context, state) {
              if (state is AboutUnionDataLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is AboutUnionDataSuccess) {
                final AboutUnionModel aboutUnionModelModel = state.AboutUnionData;
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
                            horizontal: 16.0, vertical: 45.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                context.read<HomeCubit>().fetchAdvertisement();
                                context.read<HomeCubit>().fetchAlltEAMS();
                                Navigator.pop(context);

                              },
                              child: Padding(
                                padding: const EdgeInsets.only(top: 15.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,

                                  children: [

                                    Padding(
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
                                            size: 20),
                                      ),
                                    ),
                                    SizedBox(width: 10,),
                                    Text(
                                      'about'.tr(),
                                      style: TextStyle(
                                        color: Color(0xff185A3F),
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
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
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(16.0)),
                                  child: Image.network(
                                    aboutUnionModelModel.img.toString(),

                                    height: 150,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              // Title and description
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      aboutUnionModelModel.title.toString(),

                                      // textDirection: TextDirection.ltr,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),

                                    const SizedBox(height: 16),
                                    Column(
                                      children: [
                                        Text(
                                          aboutUnionModelModel.description1.toString(),
                                          // textDirection: TextDirection.rtl,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            color: Colors.black87,
                                          ),
                                        ),
                                        SizedBox(height: 20,),
                                        Text(
                                          aboutUnionModelModel.description2.toString(),
                                          // textDirection: TextDirection.rtl,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            color: Colors.black87,
                                          ),
                                        ),
                                        SizedBox(height: 20,),
                                        Text(
                                          aboutUnionModelModel.description3.toString(),
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
