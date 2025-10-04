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
    return Container(
      height: 84,
      width: 110,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.withOpacity(0.3)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // الصورة
          Image.asset(
            imagePath,
            fit: BoxFit.contain,
            height: 35,
            width: 35,
          ),

          const SizedBox(height: 6),

          // النص (يسمح بسطرين)
          SizedBox(
            width: 90,
            child: Text(
              title,
              textAlign: TextAlign.center,
              maxLines: 2, // ✅ يسمح بسطرين
              overflow: TextOverflow.visible, // ✅ يظهر النص كامل
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xff333333),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
