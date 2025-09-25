
import 'package:flutter/material.dart';

class DefaultFormField extends StatelessWidget {
  final TextEditingController? controller;
  final TextInputType type;
  final Function(String)? onSubmit;
  final Function(String)? onChange;
  final String? hint;
  final String? initialValue;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final VoidCallback? onTap;
  final bool? isPassword;
  final String? Function(String?)? validate;
  final String? label;
  final IconData? prefix;
  final IconData? suffix;
  final VoidCallback? suffixPressed;
  final bool isClickable;
  final bool readOnly;

  const DefaultFormField({
    Key? key,
    this.controller,
    required this.type,
    this.onSubmit,
    this.onChange,
    this.hint,
    this.initialValue,
    this.maxLines,
    this.minLines,
    this.maxLength,
    this.onTap,
    this.isPassword,
    this.validate,
    this.label,
    this.prefix,
    this.suffix,
    this.suffixPressed,
    this.isClickable = true,
    this.readOnly=false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: null, // يتم التحكم في الحجم بناءً على minLines و maxLines
      child: TextFormField(
        readOnly:readOnly ,
        initialValue: initialValue,
        maxLength: maxLength,
        maxLines: maxLines,
        minLines: minLines,
        controller: controller,
        keyboardType: type,
        obscureText: isPassword ?? false,
        enabled: isClickable,
        onFieldSubmitted: onSubmit,
        onChanged: onChange,
        onTap: onTap,
        validator: validate,
        textAlign: TextAlign.start,
        decoration: InputDecoration(
          counterText: "",
          hintText: hint,
          labelText: label,
          suffixIcon: suffix != null
              ? IconButton(
            icon: Icon(suffix, color: Colors.grey),
            onPressed: suffixPressed,
          )
              : null,
          alignLabelWithHint: true, // تأكد من محاذاة النص مع الحقل عند التوسعة
          hintStyle: TextStyle(
            color: Color(0xff999999),
            fontSize: 16,
          ),
          labelStyle: TextStyle(
            color: Color(0xff999999),
            fontSize: 16,
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 12, // الحشوة العمودية
            horizontal: 16, // الحشوة الأفقية
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey.shade300, width: 2),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xff1207954), width: 2),
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
  }
}