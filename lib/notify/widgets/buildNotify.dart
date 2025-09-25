import 'package:flutter/material.dart';

class NotificationItem extends StatelessWidget {
  final String title;
  final String time;
  final String message;

  const NotificationItem({
    required this.title,
    required this.time,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 84,
      // color: Color(0xffEF600D).withOpacity(.2),
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
          child:Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [

              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(
                    alignment:Alignment.topLeft,
                    children: [CircleAvatar(
                      radius: 24,
                      backgroundColor: Colors.grey[300],
                      child: Icon(Icons.person, color: Colors.white),
                    ),

                      CircleAvatar(
                          radius: 5,
                          backgroundColor:  Color(0xffEF600D)) ],),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(children: [Expanded(
                          child: Text(
                            title,
                            maxLines: 1,
                            style: TextStyle(
                              overflow: TextOverflow.ellipsis,
                              fontSize: 12,

                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),Text(
                          time,
                          style: TextStyle(fontSize: 12, color: Color(0xff6C6C89)),
                        ),],),

                        SizedBox(height: 0),
                        Text(
                          message,
                          maxLines: 2,
                          style: TextStyle(fontSize: 14, color:Color(0xff6C6C89), fontWeight: FontWeight.w400,overflow: TextOverflow.ellipsis),
                        ),
                        SizedBox(height: 0),

                      ],
                    ),
                  ),
                ],
              ),
            ],)
      ),
    );
  }
}