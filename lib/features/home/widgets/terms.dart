import 'package:flutter/material.dart';

class IconItemWidget extends StatelessWidget {
  final String imagePath;
  final String title;

  const IconItemWidget({
    Key? key,
    required this.imagePath,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
             height: 84,
            width: 110,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey.withOpacity(0.3)),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    fit: BoxFit.fill,
                    imagePath,
                     height: 35,
                     width: 35,
                  ),
                ),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xff333333),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),

      ],
    );
  }
}