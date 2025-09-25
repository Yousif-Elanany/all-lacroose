import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class CustomBottomSheet extends StatelessWidget {
  final String title;

  CustomBottomSheet({required this.title});

  @override
  Widget build(BuildContext context) {

    return Container(
      height: 358,
      width: double.infinity,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 6,
            offset: Offset(0, 1),
          ),
        ],
        color: const Color(0xffffffff),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Stack(
        children: [
          const Image(
            image: AssetImage("assets/images/bt_sh.png"),
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 40,
                  child: Image.asset("assets/images/c2.png"),
                ),
                const SizedBox(height: 16),
                Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xff185A3F),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "add_absence_reason".tr(), // ترجمة النص
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 10),
                // Container(
                //   margin: const EdgeInsets.all(8),
                //   padding: const EdgeInsets.all(10),
                //   alignment: Alignment.center,
                //
                //   width: double.infinity,
                //   decoration: BoxDecoration(
                //     color: const Color(0xffF2F2F2),
                //     borderRadius: BorderRadius.circular(16),
                //   ),
                //   child: TextField(
                //     maxLines: 4
                //     ,
                //
                //     style: const TextStyle(fontSize: 14),
                //   ),
                // ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.all(8),
                        alignment: Alignment.center,
                        height: 52,
                        decoration: BoxDecoration(
                          color: const Color(0xff207954),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          "confirm_absence".tr(),
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.all(8),
                        alignment: Alignment.center,
                        height: 52,
                        decoration: BoxDecoration(
                          color: const Color(0xffF2F2F2),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          "cancel".tr(),
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}