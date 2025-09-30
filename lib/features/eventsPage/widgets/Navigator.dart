import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../home/data/models/PlayerModel.dart';

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

void showAwesomeDialog(BuildContext context) {
  AwesomeDialog(
    context: context,
    dialogType: DialogType.success, // success, error, warning, info
    animType: AnimType.leftSlide, // fade, leftSlide, rightSlide, scale
    title: 'success'.tr(),
    desc: 'Gob_done_successfully'.tr(),
    btnOkOnPress: () {},
  ).show();
}

// void _showPickerDialog(BuildContext context) {
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         title: Text("selectSource".tr()),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             ListTile(
//               leading: Icon(Icons.camera),
//               title: Text('pick_image'.tr()),
//               onTap: () async {
//                 Navigator.pop(context);
//                 selectedImage1 = await _pickImage(ImageSource.camera);
//
//                 setState(() {});
//               },
//             ),
//             ListTile(
//               leading: Icon(Icons.photo_library),
//               title: Text('select_from_galary'.tr()),
//               onTap: () async {
//                 selectedImage1 = await _pickImage(ImageSource.gallery);
//
//                 setState(() {});
//                 Navigator.pop(context);
//               },
//             ),
//           ],
//         ),
//       );
//     },
//   );
// }
void showPickerDialog(BuildContext context,{void Function()? onTapPhoto,void Function()? onTapVideo}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("addImageOrVideo".tr()),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.image),
              title: Text("addimage".tr()),
              onTap: onTapPhoto,


            ),
            ListTile(
              leading: Icon(Icons.video_camera_back_outlined),
              title: Text("addvideo".tr()),
              onTap: onTapVideo ,


            ),
          ],
        ),
      );
    },
  );
}

Widget buildPlayerDetails(
    PlayerModel player, int index, void Function()? onTap) {
  return Container(
    height: 40,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(
        color: Colors.grey.withOpacity(.1),
        width: 2,
      ),
    ),
    padding: EdgeInsets.all(10),
    child: Row(
      children: [
        CircleAvatar(
          radius: 10,
          backgroundImage: NetworkImage(player.image),
        ),
        SizedBox(width: 5),
        Text(
          player.displayName,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(width: 5),
        GestureDetector(
          onTap: onTap,

          //     () {
          //   // eventParticipate.removeAt(index);
          //   // setState(() {});
          // },
          child: Icon(
            Icons.close,
            size: 16,
            color: Colors.grey,
          ),
        )
      ],
    ),
  );
}
