import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:lacrosse/features/ActivitesPage/data/models/InternalEvent.dart';
import '../../../data/Local/sharedPref/sharedPref.dart';
import '../data/manager/cubit/activities_cubit.dart';

import '../presentation/activityDetailPage.dart';

class acticityWidget extends StatelessWidget {
  InternalEventModel eventModel;
  acticityWidget(this.eventModel);

  @override
  Widget build(BuildContext context) {


    return SizedBox(
      //    height: MediaQuery.of(context).size.height * 0.3,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 16.0,vertical: 10),
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade300,
                blurRadius: 2,
                offset: Offset(0, 0),
              ),
            ],
          ),
          child: Column(
            // mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      flex: 1,
                      child:
                      Container(
                        height: 64,
                        width: 64,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child:
                          eventModel.internalEventFiles.isEmpty ?  Container(


                            decoration: BoxDecoration(

                              image: DecorationImage(

                                  image: AssetImage("assets/images/photo.png"),
                                  fit: BoxFit.cover),
                              borderRadius: BorderRadius.circular(8),

                            )

                            ,

                          ):

                          Image.network(
                            eventModel.internalEventFiles[0].file,
                            // URL افتراضي عند عدم وجود صورة
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return
                                Container(


                                decoration: BoxDecoration(

                                  image: DecorationImage(

                                      image: AssetImage("assets/images/photo.png"),
                                      fit: BoxFit.cover),
                                  borderRadius: BorderRadius.circular(8),

                                )

                                ,

                              );
                            },
                          ),
                        ),
                      )


                  ),
                  SizedBox(
                    width: 10,
                  ),
                  // Icon or image on the left
                  Expanded(
                    flex: 3,
                    child: Container(
                      height: 64,
                      child: Text(
                        eventModel.eventName,
                        maxLines: 4,
                        // textDirection: TextDirection.rtl,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),


                ],
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(
                    left: 0, right: 0, top: 0, bottom: 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.location_on_outlined,
                                      size: 16, color: Colors.grey),
                                  SizedBox(width: 5.0),
                                  Expanded( // لإعطاء النص مساحة داخل الـ Row
                                    child: Text(
                                      eventModel.eventLocation.toString(),
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 5),
                              Row(
                                children: [
                                  Icon(Icons.calendar_month_outlined,
                                    size: 16, color: Color(0xff207954),),
                                  SizedBox(width: 5.0),
                                  Expanded(
                                    child:Text(
                                         DateFormat('EEEE d MMMM',context.locale.languageCode).format(eventModel.from),
                                    //  DateFormat('yyyy-MM-dd').format(eventModel.from)  ,
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xff207954)
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  //Icon(Icons.access_time, size: 16, color: Colors.grey),
                                  SizedBox(width: 8.0),
                                  Expanded(
                                    child: Text(
                                      "",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 5),
                              Row(
                                children: [
                                  Icon(Icons.access_time, size: 16, color: Colors.grey),
                                  SizedBox(width: 4.0),
                                  Expanded(
                                    child: Text(
                                      "${DateFormat('hh:mm a').format(eventModel.to)}  ${DateFormat('hh:mm a').format(eventModel.from)}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),



                  ],
                ),
              ),
              ///    Title and description

              SizedBox(height: 16.0),
              // Button
              InkWell(
                onTap: () {
// print("############################################");
// print(eventModel.eventName);
// print(eventModel.internalEventFiles.length);
// print(eventModel.internalEventFiles[0].file);
// print(eventModel.internalEventFiles[1].file);

                  BlocProvider.of<ActivitiesCubit>(context);

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => activityDeatlScreen(eventModel.id)));
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => BlocProvider.value(
                  //       value: context.read<ActivitiesCubit>(), // تمرير Cubit الحالي
                  //       child: activityDeatlScreen(eventModel.id), // الصفحة الثانية
                  //     ),
                  //   ),
                  // );
                },
                child: Container(
                  width: double.infinity,
                  height: 40,
                  //width: 30,

                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Color(0xff207954), // Green border color
                      width: 1.0, // Border width
                    ),
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),

                  child: Center(
                    child: Text(
                      "View_Details".tr(),
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xff207954),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
  String detectLang(){
   if( CacheHelper.getData(key: "lang")==1)
        return "ar";

   else
     return "en";


  }
  String getFormDate (){
    DateTime dateTime=eventModel.from!;
    // Extract date as a string in "yyyy-MM-dd" format
    String date = "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}";


    print("Date: $date");  // Output: Date: 2025-01-06

    return "";
  }

  String getFormTime (){
    DateTime dateTime=eventModel.from!;
    // Extract time as a string in "HH:mm:ss" format
    String time = "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}:${dateTime.second.toString().padLeft(2, '0')}";
    print("Time: $time");
    return time;
  }

  String getToDate (){
    DateTime dateTime=eventModel.from!;
    // Extract date as a string in "yyyy-MM-dd" format
    String date = "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}";


    print("Date: $date");  // Output: Date: 2025-01-06

    return "";
  }

  String getToTime (){
    DateTime dateTime=eventModel.from!;
    // Extract time as a string in "HH:mm:ss" format
    String time = "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}:${dateTime.second.toString().padLeft(2, '0')}";
    print("Time: $time");
    return time;
  }
}