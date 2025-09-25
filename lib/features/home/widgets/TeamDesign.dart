import 'package:flutter/material.dart';

import '../data/models/model_team.dart';



class Teamdesign extends StatelessWidget {
  teamModels model;

  Teamdesign({
    Key? key,
    required this.model,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.network(
            fit: BoxFit.fill,
            model.img,
            height: 50,
            width: 50,
            errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
              // في حالة حدوث خطأ، هات صورة من assets
              return Center(child: Image.asset('assets/images/c3.png',height: 50,width: 50,));  // ضع اسم الصورة في assets
            },

          ),
        ),
        Spacer(),
        Text(
          model.name,
          style: TextStyle(
            fontSize: 12,
            color: Colors.black,
          ),
          textAlign: TextAlign.center,
        ),

      ],
    );
  }
}