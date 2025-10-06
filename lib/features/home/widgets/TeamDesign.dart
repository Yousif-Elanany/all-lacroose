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
          child: ClipOval(
            child: Image.network(
              model.img ?? "",
              fit: BoxFit.cover,
              height: 50,
              width: 50,
              errorBuilder: (context, error, stackTrace) => errorImage(),
            ),
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
  Widget errorImage() {
    return Container(
      color: const Color(0xff185A3F),
      child: const Center(
        child: Icon(
          Icons.warning_amber_outlined,
          color: Colors.white,
          size: 40,
        ),
      ),
    );
  }
}