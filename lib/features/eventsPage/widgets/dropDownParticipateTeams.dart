import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../data/model/team.dart';


class CustomDropdownController_teams {
  VoidCallback? _reset;

  void reset() {
    if (_reset != null) {
      _reset!();
    }
  }
}
class CustomDropdownButton_Teams extends StatefulWidget {
  final List<TeamMMModel> items;
  final String hint;
  final ValueChanged<TeamMMModel?>? onChanged;
  final TeamMMModel? initialValue;
  final CustomDropdownController_teams? controller;

  CustomDropdownButton_Teams({
    required this.items,
    this.hint = "اختر عنصرًا",
    this.onChanged,
    this.initialValue,
    this.controller,
  });

  @override
  _CustomDropdownButtonState createState() => _CustomDropdownButtonState();
}

class _CustomDropdownButtonState extends State<CustomDropdownButton_Teams> {
  TeamMMModel? selectedValue;
  @override
  void initState() {
    super.initState();
    selectedValue = widget.initialValue;

    // Use the public setter instead of direct field access
    if (widget.controller != null) {

     widget.controller!._reset = reset;
    }
  }

  void reset() {
    setState(() {
      selectedValue = null;
    });
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
      child: DropdownButtonFormField<TeamMMModel>(
        isExpanded: true,
        value: selectedValue,
        hint: Text(
          widget.hint,
          style: const TextStyle(color: Colors.grey, fontSize: 16, fontWeight: FontWeight.w700),
        ),
        items: widget.items.map((TeamMMModel item) {
          return DropdownMenuItem<TeamMMModel>(
            value: item,
            child: Row(
              children: [
                CircleAvatar(
                  radius: 10,
                  backgroundImage: NetworkImage(item.img),
                ),
                const SizedBox(width: 10),
                Text(item.name),
              ],
            ),
          );
        }).toList(),
        onChanged: (TeamMMModel? newValue) {
          setState(() {
            selectedValue = newValue;
          });
          if (widget.onChanged != null) {
            widget.onChanged!(newValue);
          }
        },
        // validator: (value) {
        //   if (value == null) {
        //     return 'Please_select_a_team'.tr();
        //   }
        //   return null;
        // },
        dropdownColor: const Color(0xfff9f9f9),
        borderRadius: BorderRadius.circular(12),
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
          border: InputBorder.none,
        ),
        icon: const Icon(Icons.keyboard_arrow_down_outlined, color: Colors.black45),
        iconSize: 24,
        style: const TextStyle(color: Colors.black, fontSize: 16),
      ),
    );
  }
}