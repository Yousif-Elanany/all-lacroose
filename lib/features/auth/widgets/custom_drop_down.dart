
import 'package:flutter/material.dart';
import 'package:lacrosse/features/auth/data/model/natinalityModel.dart';

import '../data/model/team.dart';

class TeamDropdownButton extends StatefulWidget {
  final List<TeamModel> items;
  final String hint;

  final ValueChanged<TeamModel?>? onChanged;
  final TeamModel? initialValue;

  TeamDropdownButton({
    required this.items,
    this.hint = "اختر فريقًا",
    this.onChanged,
    this.initialValue,
  });

  @override
  _CustomDropdownButtonState createState() => _CustomDropdownButtonState();
}

class _CustomDropdownButtonState extends State<TeamDropdownButton> {
  TeamModel? selectedTeam;

  @override
  void initState() {
    super.initState();
 //   selectedTeam = widget.initialValue;
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
      child: DropdownButton<TeamModel>(
        isExpanded: true,
        value: selectedTeam,
        hint: Text(
          widget.hint,
          style: const TextStyle(color: Colors.grey ,fontSize: 16),
        ),
        items: widget.items.map((TeamModel item) {
          return DropdownMenuItem<TeamModel>(
            value: item,
            child:ListTile(

              title: Text(item.name),)

            // Row(
            //   children: [
            //     const SizedBox(width: 10),
            //     Text(
            //       '${item.name} (${item.id})', // عرض الاسم والمعرف
            //       style: const TextStyle(fontSize: 16, color: Colors.black),
            //     ),
            //   ],
            // ),
          )
          ;
        }).toList(),
        onChanged: (TeamModel? newValue) {
          setState(() {
            selectedTeam = newValue;
          });
          if (widget.onChanged != null) {
            widget.onChanged!(newValue);
          }
        },
        dropdownColor: const Color(0xfff9f9f9),
        borderRadius: BorderRadius.circular(12),
       // underline: Container(),
        icon: const Icon(Icons.keyboard_arrow_down_outlined, color: Colors.black),
        iconSize: 24,
        style: const TextStyle(color: Colors.black, fontSize: 16),
      ),
    );
  }
}



