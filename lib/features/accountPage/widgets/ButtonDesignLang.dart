import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lacrosse/data/endPoints/endpoint.dart';

class LanguageOption extends StatefulWidget {
  final String language;
  final String Img;
  final bool isSelected;
  final Function(bool?) onChanged;

  LanguageOption({
    required this.language,
    required this.Img,
    required this.isSelected,
    required this.onChanged,
  });

  @override
  _LanguageOptionState createState() => _LanguageOptionState();
}

class _LanguageOptionState extends State<LanguageOption> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.07,
        padding: EdgeInsets.symmetric( horizontal: 10),


        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.lightBlue,
              width: 1,)),
        child: Row(
          children: [
            Container(

              // height: 40,
              // width: 40,
              child: Image.asset(
                widget.Img,
                //   color: widget.isSelected ? Colors.green : Colors.grey,
                fit: BoxFit.contain,

              ),
            ),
            SizedBox(width: 8), // Add spacing between icon and text
            Text(
              widget.language,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
            Radio<bool>(
              value: context.locale.languageCode == 'ar'?true:context.locale.languageCode == "en" ? true:false ,
              groupValue: widget.isSelected,
              onChanged: widget.onChanged,
              activeColor: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }
}