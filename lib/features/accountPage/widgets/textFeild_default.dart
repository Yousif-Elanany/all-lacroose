import 'package:flutter/material.dart';

Widget defaultFormField({
  TextEditingController? controller,
  required TextInputType type,
  Function(String)? onSubmit,
  Function(String)? onChange,
  String? hint,
  String? initialValue,
  int? maxLines,
  int? maxLength,
  VoidCallback? onTap,
  bool? isPassword,
  String? Function(String?)? validate,
  String? label,
  IconData? prefix,
  IconData? suffix,
  VoidCallback? suffixPressed,
  bool readOnly = false,
  bool isClickable = true,
}) =>
    Container(


      child: TextFormField(
        initialValue: initialValue,
        maxLength: maxLength,
        maxLines: maxLines,
        controller: controller,
        keyboardType: type,
        obscureText: isPassword ?? false,
        enabled: isClickable,
        onFieldSubmitted: onSubmit,
        onChanged: onChange,
        onTap: onTap,
        validator: validate,
        textAlign: TextAlign.start,
        readOnly: readOnly,
        decoration: InputDecoration(
          counterText: "",
          hintText: hint,

          hintStyle: TextStyle(
            color: Color(0xff999999),
            fontSize: 16,
          ),
          labelStyle: TextStyle(
            color: Color(0xff999999),
            fontSize: 16,
          ),
          labelText: label,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 10, // الحشوة العمودية
            horizontal: 16, // الحشوة الأفقية
          ),

          errorStyle: TextStyle(
            fontSize: 18.0, // حجم أصغر لرسالة الخطأ
            height: 0.8,    // تقليل المسافة بين النصوص
          ),


          // border: OutlineInputBorder(
          //   borderRadius: BorderRadius.circular(10),
          //   borderSide: BorderSide(color: Colors.green),),

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey.shade300, width: 2), ), //0xffF7F7F7

          focusedBorder: OutlineInputBorder(

            borderSide: BorderSide(color: Color(0xff207954), width: 2),//
            borderRadius: BorderRadius.circular(10),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xffCC4545), width: 2),//
            borderRadius: BorderRadius.circular(10),
          ),
          errorBorder:  OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xffCC4545), width: 2),//
            borderRadius: BorderRadius.circular(10),
          ),



        ),
      ),
    );