// import 'package:flutter/material.dart';
//
// class CustomDropdownButton extends StatefulWidget {
//   final List<String> items;
//   final String hint;
//   final ValueChanged<String?>? onChanged;
//   final String? initialValue;
//
//   CustomDropdownButton({
//     required this.items,
//     this.hint = "اختر عنصرًا",
//     this.onChanged,
//     this.initialValue,
//   });
//
//   @override
//   _CustomDropdownButtonState createState() => _CustomDropdownButtonState();
// }
//
// class _CustomDropdownButtonState extends State<CustomDropdownButton> {
//   String? selectedValue; // القيمة المحددة
//
//   @override
//   void initState() {
//     super.initState();
//     selectedValue = widget.initialValue; // تعيين القيمة المبدئية
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 48,
//       padding: const EdgeInsets.symmetric(horizontal: 16),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(8),
//         border: Border.all(color: const Color(0xffcccccc), width: 1),
//       ),
//       child: DropdownButton<String>(
//         isExpanded: true, // تمديد القائمة
//         value: selectedValue,
//         hint: Text(
//           widget.hint,
//           style: const TextStyle(color: Colors.grey),
//         ),
//         items: widget.items.map((String item) {
//           return DropdownMenuItem<String>(
//             value: item,
//
//             child: Row(
//               children: [
//                 const SizedBox(width: 10),
//                 Text(
//                   item,
//                   style: const TextStyle(fontSize: 16, color: Colors.black),
//                 ),
//               ],
//             ),
//           );
//         }).toList(),
//         onChanged: (String? newValue) {
//           setState(() {
//             selectedValue = newValue;
//           });
//           if (widget.onChanged != null) {
//             widget.onChanged!(newValue); // تمرير القيمة المختارة
//           }
//         },
//         dropdownColor: const Color(0xfff9f9f9), // لون القائمة المنسدلة
//         borderRadius: BorderRadius.circular(12), // زوايا القائمة المنسدلة
//         underline: Container(), // إزالة الخط السفلي
//         icon: const Icon(Icons.keyboard_arrow_down_outlined, color: Colors.black45,),
//         iconSize: 24,
//         style: const TextStyle(color: Colors.black, fontSize: 16),
//       ),
//     );
//   }
// }