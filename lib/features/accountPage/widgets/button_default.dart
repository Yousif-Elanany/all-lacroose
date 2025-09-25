

import 'package:flutter/material.dart';

class Button_default extends StatelessWidget {

  final double height;
  final String title;
  final Color colortext;
  final Color color;




  Button_default({

    required this.height,
    required  this.title,
    required this.color,
    required this.colortext

}

      );

  @override
   Container build(BuildContext context) {
    return Container(
      height: height,

      decoration:
      BoxDecoration(borderRadius: BorderRadius.circular(16), color: color),
      child: Center(
        child: Text(
          title,
          style: TextStyle(fontSize: 16, color: colortext,fontWeight: FontWeight.w700),
        ),
      ),
    );

    }
}