import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lacrosse/features/eventsPage/data/model/player_model.dart';

import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:lacrosse/features/eventsPage/data/model/player_model.dart';

class CustomDropdownController {
  VoidCallback? _reset;

  void reset() {
    if (_reset != null) {
      _reset!();
    }
  }
}

class CustomDropdownButton_players extends StatefulWidget {
  final List<PlayerModel> items;
  final String hint;
  final ValueChanged<PlayerModel?>? onChanged;
 // final PlayerModel? initialValue;
  final CustomDropdownController? controller;

  CustomDropdownButton_players({
    required this.items,
    this.hint = "اختر عنصرًا",
    this.onChanged,
   // this.initialValue,
    this.controller,
  });

  @override
  _CustomDropdownButtonState createState() => _CustomDropdownButtonState();
}

class _CustomDropdownButtonState extends State<CustomDropdownButton_players> {
  PlayerModel? selectedValue;

  @override
  void initState() {
    super.initState();
  //  selectedValue = widget.initialValue;

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
      padding: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xffcccccc), width: 1),
      ),
      child: DropdownButtonFormField<PlayerModel>(
        isExpanded: true,
        value: selectedValue,
        hint: Text(
          widget.hint,
          style: const TextStyle(color: Colors.grey, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        items: widget.items.map((PlayerModel item) {
          return DropdownMenuItem<PlayerModel>(
            value: item,
            child: Row(
              children: [
                CircleAvatar(
                  radius: 10,
                  backgroundImage: NetworkImage(item.image),
                ),
                const SizedBox(width: 10),
                Text(item.displayName),
              ],
            ),
          );
        }).toList(),
        onChanged: (PlayerModel? newValue) {
          setState(() {
            selectedValue = newValue;
          });
          if (widget.onChanged != null) {
            widget.onChanged!(newValue);
          }
        },
        validator: (value) {
          if (value == null) {
            return 'Please_select_a_players'.tr();
          }
          return null;
        },
        dropdownColor: const Color(0xfff9f9f9),
        borderRadius: BorderRadius.circular(12),
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
          border: InputBorder.none,
        ),
        icon: const Icon(Icons.keyboard_arrow_down_outlined, color: Colors.black45),
        iconSize: 24,
        style: const TextStyle(color: Colors.black, fontSize: 16),
      ),
    );
  }
}
// class CustomDropdownButton_players extends StatefulWidget {
//   final List<PlayerModel> items;
//   final String hint;
//   final ValueChanged<PlayerModel?>? onChanged;
//   final PlayerModel? initialValue;
//
//
//   CustomDropdownButton_players({
//     required this.items,
//     this.hint = "اختر عنصرًا",
//     this.onChanged,
//     this.initialValue,
//
//   });
//
//   @override
//   _CustomDropdownButtonState createState() => _CustomDropdownButtonState();
// }
//
// class _CustomDropdownButtonState extends State<CustomDropdownButton_players> {
//   PlayerModel? selectedValue;
//
//   @override
//   void initState() {
//     super.initState();
//     selectedValue = widget.initialValue;
//   }
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 48,
//       padding: const EdgeInsets.symmetric(horizontal: 5),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(8),
//         border: Border.all(color: const Color(0xffcccccc), width: 1),
//       ),
//       child: DropdownButtonFormField<PlayerModel>(
//         isExpanded: true,
//         value: selectedValue,
//         hint: Text(
//           widget.hint,
//           style: const TextStyle(color: Colors.grey, fontSize: 16, fontWeight: FontWeight.bold),
//         ),
//         items: widget.items.map((PlayerModel item) {
//           return DropdownMenuItem<PlayerModel>(
//             value: item,
//             child: Row(
//               children: [
//                 CircleAvatar(
//                   radius: 10,
//                   backgroundImage: NetworkImage(item.image),
//                 ),
//                 SizedBox(width: 10),
//                 Text(item.displayName),
//               ],
//             ),
//           );
//         }).toList(),
//         onChanged: (PlayerModel? newValue) {
//           setState(() {
//             selectedValue = newValue;
//           });
//           if (widget.onChanged != null) {
//             widget.onChanged!(newValue);
//           }
//         },
//         validator: (value) {
//           if (value == null) {
//             return 'Please_select_a_players'.tr();
//           }
//           return null;
//         },
//         dropdownColor: const Color(0xfff9f9f9),
//         borderRadius: BorderRadius.circular(12),
//         decoration: InputDecoration(
//           contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
//           border: InputBorder.none,
//         ),
//         icon: const Icon(Icons.keyboard_arrow_down_outlined, color: Colors.black45),
//         iconSize: 24,
//         style: const TextStyle(color: Colors.black, fontSize: 16),
//       ),
//     );
//   }
// }
