import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:lacrosse/features/ActivitesPage/data/models/InternalEvent.dart';
import 'package:lacrosse/features/eventsPage/data/manager/cubit/manager_cubit.dart';
import 'package:lacrosse/features/eventsPage/widgets/bottom_sheet_main.dart';

import '../../ActivitesPage/data/manager/cubit/activities_cubit.dart';
import '../../ActivitesPage/presentation/activityDetailPage.dart';
import '../data/model/experienceModel.dart';
import '../presentation/participatores.dart';


class CustomAudienceExperience extends StatefulWidget {
  ExperiencesModel experiencesModel;
  CustomAudienceExperience(this.experiencesModel);

  @override
  State<CustomAudienceExperience> createState() => _CustomAudienceExperienceState();
}

class _CustomAudienceExperienceState extends State<CustomAudienceExperience> {
   String location="";
   @override
  void initState() {
     fetchLocation();
    super.initState();

  }
   fetchLocation() async {

     location= await getLocationName(lat: widget.experiencesModel.latitude,lon: widget.experiencesModel.longitude);
     setState(() {

     });
     return "";

   }
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
                color: Colors.grey.withOpacity(0.5),
                blurRadius: 6,
                offset: Offset(0, 3),
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
                  // صورة الحدث
                  Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child:
                    // ClipRRect(
                    //   borderRadius: BorderRadius.circular(16),
                    //   child: widget.eventModel.internalEventFiles.isNotEmpty
                    //       ? Image.network(
                    //     widget.eventModel.internalEventFiles[0].file,
                    //     fit: BoxFit.cover,
                    //     errorBuilder: (context, error, stackTrace) {
                    //       return Container(
                    //         decoration: BoxDecoration(
                    //           image: DecorationImage(
                    //             image: AssetImage("assets/images/photo.png"),
                    //             fit: BoxFit.cover,
                    //           ),
                    //           borderRadius: BorderRadius.circular(16),
                    //         ),
                    //       );
                    //     },
                    //   )
                    //       :
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/images/exp2.jpeg"),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(16),
                        ),),),

                  SizedBox(width: 10),

                  // نص الحدث مع الأيقونات
                  Expanded(
                    child: Container(
                      //color: Colors.orange,
                      padding: EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                       crossAxisAlignment : CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  "audience_experience".tr(),

                               //   "widget.experiencesModel.name", // eventModel.eventName
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: (){

                                  showCustomBottomSheet(context);
                                },
                                child: Container(
                                  height: 32,
                                  width: 32,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.1),
                                        blurRadius: 5,
                                        offset: Offset(0, 2),
                                      ),
                                    ],
                                    border: Border.all(
                                      color: Colors.grey.withOpacity(.2),
                                      width: 1,
                                    ),
                                  ),
                                  child: Icon(Icons.more_horiz_outlined,color: Colors.grey,),),
                              ),

                            ],
                          ),
                          SizedBox(height: 5),

                          Row(
                            children: [
                              Icon(Icons.groups_2_outlined,color: Colors.grey,),
                              SizedBox(width: 5),
                              Text(
                               " ${widget.experiencesModel.reservationCount}",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xff207954)
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(width: 5),
                              Text("reservations".tr() ),
                            ],
                          ),
                        ],
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
                                  location,
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
                                    child: Text(
    widget.experiencesModel.appointment,// DateFormat('yyyy-MM-dd').format(widget.eventModel.from)  ,
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
                                   "${widget.experiencesModel.fromTime} - ${widget.experiencesModel.toTime}"  ,// "${DateFormat('hh:mm a').format(widget.eventModel.to)}_ ${DateFormat('hh:mm a').format(widget.eventModel.from??DateTime.now())}",
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

              // SizedBox(height: 16.0),
              // // Button
              // InkWell(
              //   onTap: () {
              //
              //     // BlocProvider.of<ActivitiesCubit>(context);
              //     //
              //     // Navigator.push(
              //     //     context,
              //     //     MaterialPageRoute(
              //     //         builder: (context) => activityDeatlScreen(eventModel.id)));
              //     // Navigator.push(
              //     //   context,
              //     //   MaterialPageRoute(
              //     //     builder: (context) => BlocProvider.value(
              //     //       value: context.read<ActivitiesCubit>(), // تمرير Cubit الحالي
              //     //       child: activityDeatlScreen(widget.eventModel.id), // الصفحة الثانية
              //     //     ),
              //     //   ),
              //     // );
              //   },
              //   child: Container(
              //     width: double.infinity,
              //     height: 40,
              //     //width: 30,
              //
              //     decoration: BoxDecoration(
              //       border: Border.all(
              //         color: Color(0xff207954), // Green border color
              //         width: 1.0, // Border width
              //       ),
              //       color: Colors.white,
              //       borderRadius: BorderRadius.all(
              //         Radius.circular(10),
              //       ),
              //     ),
              //
              //     child: Center(
              //       child: Text(
              //         "View_Details".tr(),
              //         style: TextStyle(
              //           fontSize: 14,
              //           color: Color(0xff207954),
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ));
  }

  // String getFormDate (){
  //   DateTime dateTime=widget.eventModel.from!;
  //   // Extract date as a string in "yyyy-MM-dd" format
  //   String date = "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}";
  //
  //
  //   print("Date: $date");  // Output: Date: 2025-01-06
  //
  //   return "";
  // }
  //
  // String getFormTime (){
  //   DateTime dateTime=widget.eventModel.from!;
  //   // Extract time as a string in "HH:mm:ss" format
  //   String time = "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}:${dateTime.second.toString().padLeft(2, '0')}";
  //   print("Time: $time");
  //   return time;
  // }
  //
  // String getToDate (){
  //   DateTime dateTime=widget.eventModel.from!;
  //   // Extract date as a string in "yyyy-MM-dd" format
  //   String date = "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}";
  //
  //
  //   print("Date: $date");  // Output: Date: 2025-01-06
  //
  //   return "";
  // }
  //
  // String getToTime (){
  //   DateTime dateTime=widget.eventModel.from!;
  //   // Extract time as a string in "HH:mm:ss" format
  //   String time = "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}:${dateTime.second.toString().padLeft(2, '0')}";
  //   print("Time: $time");
  //   return time;
  // }

  void showCustomBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return CustomBottomSheet(
          hight: 246.0,
          title: 'Options'.tr(),
          items: [


            Text(
              'show_participators'.tr(),
              style: const TextStyle(fontSize: 16,// color: Color(0xff185A3F),

                fontWeight: FontWeight.w500,),
            ),
            Text(
              'delete_event'.tr(),
              style: const TextStyle(fontSize: 16, color: Color(0xffDE3030),

                fontWeight: FontWeight.w500,),
            ),

          ],
          onItemTap: (index) async {
            Navigator.pop(context);
            setState(() {});
            if (index == 0) {
              navigateTo(context, ParticipatorsPage(widget.experiencesModel.id));


            }
            if (index == 1) {
context.read<managerCubit>().deleteExperience(experienceId: widget.experiencesModel.id).then((value){

});

            }

          },
        );
      },
    );}
    Future<String> getLocationName({required double lat, required double lon}) async {
      try {
        // Perform reverse geocoding
        List<Placemark> placemarks = await placemarkFromCoordinates(lat, lon);

        if (placemarks.isNotEmpty) {
          Placemark place = placemarks.first;
          return "${place.locality}, ${place.country}"; // Example: "Cairo, Egypt"
        } else {
          return "noLocation".tr();
        }
      } catch (e) {
        return "Error: ${e.toString()}";
      }
    }

}