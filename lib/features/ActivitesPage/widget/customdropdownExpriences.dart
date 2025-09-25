import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../eventsPage/data/model/experienceModel.dart';



class CustomDropdownButton_Expriences extends StatefulWidget {
  final List<ExperiencesModel> items;
  final String hint;
  final ValueChanged<ExperiencesModel?>? onChanged;
  final ExperiencesModel? initialValue;

  CustomDropdownButton_Expriences({
    required this.items,
    this.hint = "اختر عنصرًا",
    this.onChanged,
    this.initialValue,
  });

  @override
  _CustomDropdownButtonState createState() => _CustomDropdownButtonState();
}

class _CustomDropdownButtonState extends State<CustomDropdownButton_Expriences> {
  ExperiencesModel? selectedValue; // القيمة المحددة

  @override
  void initState() {
    super.initState();
    selectedValue = widget.initialValue; // تعيين القيمة المبدئية
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 48,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xffcccccc), width: 1),
        ),
        child: DropdownButtonFormField<ExperiencesModel>(
          isExpanded: true,
          value: selectedValue,
          hint: Text(
            widget.hint,
            style: const TextStyle(color: Colors.grey, fontSize: 16, fontWeight: FontWeight.w700),
          ),
          items: widget.items.map((ExperiencesModel item) {
            return DropdownMenuItem<ExperiencesModel>(
              value: item,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // CircleAvatar(
                  //   radius: 10,
                  //   backgroundImage: NetworkImage(item.appointment),
                  // ),
                  Text( DateFormat('EEEE d MMMM',context.locale.languageCode).format(DateTime.parse(item.appointment))),
                // ${}
                  Text(" ||  from ${item.fromTime} - to ${item.toTime}"),

                  // SizedBox(width: 10),
                  // Text(item.appointment),
                  // SizedBox(width: 10),
                  // Text("//"),
                  // SizedBox(width: 10),
                  // Text("from"),
                  //
                  // Text(item.fromTime),
                  // SizedBox(width: 10),
                  // Text("/"),
                  // SizedBox(width: 10),
                  // Text("to "),
                  // //
                  // Text(item.toTime),
                ],
              ),
            );
          }).toList(),
          onChanged: (ExperiencesModel? newValue) {
            setState(() {
              selectedValue = newValue;
            });
            if (widget.onChanged != null) {
              widget.onChanged!(newValue);
            }
          },

          validator: (value) {
            if (value == null) {
              return 'exp_date'.tr();
            }
            return null;
          },

          dropdownColor: const Color(0xfff9f9f9),
          borderRadius: BorderRadius.circular(12),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 0), // يضبط النص في المنتصف
            border: InputBorder.none, // يمنع ظهور أي حدود زائدة
          ),

          icon: const Icon(Icons.keyboard_arrow_down_outlined, color: Colors.black45),
          iconSize: 24,
          style: const TextStyle(color: Colors.black, fontSize: 16),
        )
    );
  }
}