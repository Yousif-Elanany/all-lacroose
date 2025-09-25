

import 'package:flutter/material.dart';

class Button_select_register extends StatefulWidget {

  final bool is_Player;
  final bool groupValue;
  final String text;
   final ValueChanged<bool?> onChanged;

  Button_select_register({
 required this.text,
  required this.is_Player,
  required  this.groupValue,
    required this.onChanged,

});

  @override
  State<Button_select_register> createState() => _Button_select_registerState();
}

class _Button_select_registerState extends State<Button_select_register> {
  @override
  Widget build(BuildContext context) {
    final bool isSelected = widget.is_Player == widget.groupValue;
    return Expanded(
      child: Container(
        padding: EdgeInsets.only(right: 16, top: 16, bottom: 16,left: 16),
        height: 56.0,
        decoration: BoxDecoration(
           color:isSelected?Color(0xff488B71).withOpacity(.08): Color(0xff9999),
            //Color(0xff488B71).withOpacity(.08),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isSelected?Color(0xff488B71) :Color(0xffcccccc),
              width: 1,
            )),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.text,
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            Spacer(),
            Radio<bool>(
              onChanged: widget.onChanged,
              value:
              widget.is_Player, //context.locale.languageCode == 'ar'?true:context.locale.languageCode == "en" ? true:false ,
              groupValue: widget.groupValue,


              activeColor: Color(0xff488B71),
            ),
          ],
        ),
      ),
    );
  }
}
