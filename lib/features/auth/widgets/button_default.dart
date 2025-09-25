import 'package:flutter/material.dart';

class Button_default extends StatelessWidget {
  final double height;
  final String? title;
  final Color colortext;
  final Color color;
  final Widget? child; // 👈 إضافة ويدجت مخصص (لللودينج مثلاً)

  Button_default({
    required this.height,
    this.title,
    required this.color,
    required this.colortext,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: color,
      ),
      child: Center(
        child: child ??
            Text(
              title ?? "",
              style: TextStyle(
                fontSize: 16,
                color: colortext,
                fontWeight: FontWeight.w500,
              ),
            ),
      ),
    );
  }
}
