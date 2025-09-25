import 'package:flutter/material.dart';
import 'package:lacrosse/features/home/data/models/PlayerModel.dart';

class PlayerWidget extends StatelessWidget {
  PlayerModel model;

   PlayerWidget({
    Key? key,
     required this.model,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 80,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.network(
              fit: BoxFit.fill,
              model.image,
              height: 50,
              width: 50,
              errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                return Center(child: Image.asset('assets/images/reg.png', height: 50, width: 50));
              },
            ),
          ),
// SizedBox(height: 5),
          Expanded(
            child: Text(
              model.displayName,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 12,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ),

        ],
      ),
    );
  }
}