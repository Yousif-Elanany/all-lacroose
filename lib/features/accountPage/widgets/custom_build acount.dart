import 'package:flutter/material.dart';

class AccountItemWidget extends StatelessWidget {
  final String text; // النص بجانب الأيقونة
  final String iconPath;
  final Color backgroundColor;

  const AccountItemWidget({
    Key? key,
    required this.text,
    required this.iconPath,
    required this.backgroundColor
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.08,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.4),
              blurRadius: 1,
            ),
          ],
        ),
        child: Row(
          children: [
            // الأيقونة الدائرية
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: CircleAvatar(
                backgroundColor: backgroundColor,
                child: ClipOval(
                  child: Image.asset(
                   iconPath,
                    // width: double.infinity,
                    // height: double.infinity,
                    fit: BoxFit.cover, // يجعل الصورة تغطي الـ CircleAvatar بالكامل
                  ),
                ), // تحميل الصورة من الـ Assets
              ),
            ),
            // النص
            Text(
              text,
              style: const TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),
            // السهم الأيمن
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Icon(
                Icons.arrow_forward_ios,
                size: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}