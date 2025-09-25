// ignore_for_file: deprecated_member_use
import 'dart:ui' as ui;
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart' ;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../NewsPage/data/manager/cubit/news_cubit.dart';
import '../../NewsPage/data/model/newsModel.dart';
import '../data/manager/cubit/Account_State.dart';
import '../data/manager/cubit/Account_cubit.dart';
import '../data/model/questionModel.dart';
import '../widgets/queationDesign.dart';



class queastionsPage extends StatefulWidget {

  queastionsPage();
  @override
  State<queastionsPage> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<queastionsPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<AccountCubit>().fetchAllQuestionData();
  }
  final List<Map<String, String>> faqs = [
    {'question': 'كيف يعمل تطبيق Lacrosse', 'answer': 'يعمل التطبيق على لوريم إبسوم...'},
    {'question': 'سؤال آخر', 'answer': 'هذا هو النص الخاص بالسؤال الآخر.'},
    {'question': 'سؤال آخر', 'answer': 'هذا هو النص الخاص بالسؤال الآخر.'},
    {'question': 'سؤال آخر', 'answer': 'هذا هو النص الخاص بالسؤال الآخر.'},
    {'question': 'سؤال آخر', 'answer': 'هذا هو النص الخاص بالسؤال الآخر.'},
  ];


  //final _controller = PageController();
  CarouselSliderController _carouselController = CarouselSliderController();
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{

        context.read<NewsCubit>().fetchAllNewsData();
        return true ;
      },
      child: Scaffold(
          backgroundColor: Colors.white,
          body:BlocBuilder<AccountCubit,AccountState>(
          builder: (context,state){

    if (state is QuestionLoading) {
    return const Center(
    child: CircularProgressIndicator(),
    );
    } else if (state is QuestionSuccess) {
   final List<QuestionModel> questList = state.question;
   print(questList[0].answer);

    return

          Stack(
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
                      horizontal: 32.0, vertical: 45.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          context.read<NewsCubit>().fetchAllNewsData();
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: Row(
                            children: [

                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 8.0, top: 8),
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
                              Text(
                                'frequently Queations'.tr(),
                                style: TextStyle(
                                  color: Color(0xff185A3F),
                                  fontSize: 18,
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
                child:  ListView.builder(
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                  itemCount: questList.length,
                  itemBuilder: (context, index) {
                    return FAQItem(
                      question: questList[index].ques!,
                      answer: questList[index].answer!,
                    );
                  },
                ),
              )
            ],
          );}else return Container();


          })

      )

    );
  }
              }




