import 'package:flutter/material.dart';

Widget defaultFormField({
  TextEditingController? controller,
  required TextInputType type,
  Function(String)? onSubmit,
  Function(String)? onChange,
  TextStyle? style,
   StrutStyle ?strutStyle,
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
       obscuringCharacter: '*',
        enabled: isClickable,
        onFieldSubmitted: onSubmit,
        onChanged: onChange,
        onTap: onTap,
        validator: validate,
        textAlign: TextAlign.start,
        textAlignVertical: TextAlignVertical.center, // محاذاة النجوم عموديًا في المنتصف
        style:style??const TextStyle(
        //  color:Color(0xff999999),
          fontSize: 16, // لون النص المدخل
          height: 1.5,
          // fontWeight: FontWeight.bold, // جعل النص عريضًا
        ),
        strutStyle: strutStyle,
        decoration: InputDecoration(
          counterText: "",
          hintText: hint,
          alignLabelWithHint: true, // تأكد من محاذاة النص مع الحقل عند التوسعة

        hintStyle: TextStyle(
            color: Color(0xff999999),
            fontSize: 16,
          ),

          labelStyle: TextStyle(
            color: Color(0xff999999),
            fontSize: 16,
          ),
          labelText: label,

        //  contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
          errorStyle: TextStyle(
            fontSize: 16.0, // حجم أصغر لرسالة الخطأ
            height: 0.8,    // تقليل المسافة بين النصوص
          ),


          // border: OutlineInputBorder(
          //   borderRadius: BorderRadius.circular(10),
          //   borderSide: BorderSide(color: Colors.green),),

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey.shade300, width: 2), ), //0xffF7F7F7

          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xff1207954), width: 2),//
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