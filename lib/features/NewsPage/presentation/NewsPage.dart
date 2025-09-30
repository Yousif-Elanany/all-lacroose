import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lacrosse/features/NewsPage/data/model/newsModel.dart';

import 'package:lacrosse/features/home/widgets/player_Design.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../data/Local/sharedPref/sharedPref.dart';
import '../../home/widgets/terms.dart';
import '../data/manager/cubit/news_cubit.dart';
import '../data/manager/cubit/news_states.dart';
import '../widgets/CustomNewsWidget.dart';
import 'newsCardDetails.dart';


class NewsPage extends StatefulWidget {
  @override
  State<NewsPage> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<NewsPage> {
  //final _controller = PageController();
  CarouselSliderController _carouselController = CarouselSliderController();
  int _currentIndex = 0;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<NewsCubit>().fetchAllNewsData();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<NewsCubit,NewsState>(
        builder: (context,state){

      if (state is NewsLoading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is NewsSuccess) {
        final List<NewsModel> newsList = state.NewsData;
        print(newsList[0].id);

        return Stack(
            children: [
              // الخلفية
              Stack(children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.2,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                            'assets/images/top bar.png'), // Replace with your asset path
                        fit: BoxFit.cover, // Adjust to control how the image fits
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
                  padding:
                  const EdgeInsets.symmetric(horizontal: 32.0, vertical: 62.0),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      if(CacheHelper.getData(key: "roles")=="Admin")
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
                                size: 20),
                          ),
                        ),
                      ),
                      Text(
                        'news'.tr(),
                        style: TextStyle(
                          color: Color(0xff185A3F),
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Spacer(),
                      Icon(Icons.menu, color: Color(0xff185A3F), size: 30),
                    ],
                  ),
                ),
              ]),
              // محتوى الشاشة
              Container(
                margin:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.17),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: ListView.builder(
                  padding: EdgeInsets.only(top: 8),
                  itemBuilder: (context,index){
                    return  GestureDetector(
                      onTap: ()async{

                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NewsDetailPage(newsList[index].id!),
                          ),
                        );

// لو رجع من الصفحة بعد الحذف
                        if (result == true) {
                          context.read<NewsCubit>().fetchAllNewsData();
                        }



                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: NewsCard(newsList[index]),
                      ),
                    );
                  },itemCount: newsList.length,

                ),
              ),
            ],
          );}
      else {
        return SizedBox(height: 1,);// لعمل جميع احتمالات if statment
      }
        },


      ),

    );
  }
}