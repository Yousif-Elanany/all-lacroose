import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lacrosse/features/NewsPage/data/model/newsModel.dart';

class NewsCard extends StatelessWidget {
  NewsModel newsItem;
  NewsCard(this.newsItem);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 6,
              offset: Offset(0, 4),
            ),
          ],
        ),
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
                      borderRadius:
                      BorderRadius.vertical(top: Radius.circular(16.0)),
                      child:Image.network(newsItem.img.toString(),

                        height: 150,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                          return Center(child: Image.asset('assets/images/photo.png', height: 150, width: double.infinity));
                        },

                      ),

                    ),
                  ),
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color(0xff185A3F), // Green at the bottom
                            Colors.transparent, // Transparent at the top
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                        borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
                      ),
                    ),
                  ),
                  // Positioned(
                  //   top: 0,
                  //   left: 0,
                  //   child: Container(
                  //     padding: const EdgeInsets.symmetric(
                  //         horizontal: 12.0, vertical: 4.0),
                  //     width: 80,
                  //     height: 35,
                  //     decoration: BoxDecoration(
                  //       color: Color(0xffFFDB99),
                  //       borderRadius: BorderRadius.only(
                  //         topLeft: Radius.circular(30),
                  //         bottomRight: Radius.circular(30),
                  //       ),
                  //       //  borderRadius: BorderRadius.circular(8.0),
                  //     ),
                  //     child: Center(
                  //       child: (newsItem.oldOrNew??true)?Text(
                  //          'Old'.tr(),
                  //         style: TextStyle(
                  //           color: Color(0xff333333),
                  //           fontWeight: FontWeight.bold,
                  //           fontSize: 12,
                  //         ),
                  //       ):Text(
                  //         'New'.tr(),
                  //         style: TextStyle(
                  //           color: Color(0xff333333),
                  //           fontWeight: FontWeight.bold,
                  //           fontSize: 12,
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
              // Title and description
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text( newsItem.title.toString()
                      ,
                      //textDirection: TextDirection.rtl,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.access_time,
                          size: 14,
                          color: Colors.grey,
                        ),


                        Text(
                          // DateFormat('EEEE d MMMM',context.locale.languageCode).format(newsItem.postTime),

                          newsItem.postTime.toString(),
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(width: 8),

                        //    const Spacer(),

                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
