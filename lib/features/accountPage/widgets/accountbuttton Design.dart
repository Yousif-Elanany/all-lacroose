import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class accountBtnDesign extends StatelessWidget {

  const accountBtnDesign({super.key});

  @override
  Widget build(BuildContext context) {
    return   Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: 30, vertical: 10),
        child: Container(
          //
          //margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.16),
          height: MediaQuery.of(context).size.height * 0.07,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.4),
                blurRadius: .1,
                // offset: Offset(0, 4),
              ),
            ],
          ),

          child: Row(children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: CircleAvatar(
                  backgroundColor: Colors.orange[50],
                  //   radius: 20,
                  child: Image.asset("assets/images/33.png")
                //Image(image: AssetImage("assets/images/photo.png"),),
              ),
            ),
            Text(
              "Change password".tr(),
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 25),
              child: Icon(
                Icons.arrow_forward_ios,
                size: 16,
              ),
            ),
          ]),
        ));
  }
}
