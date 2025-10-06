

import 'package:flutter/material.dart';

class CustomBottomSheet extends StatelessWidget {
  final String title;
  final double hight;
  final List<String> items;
  final Function(int)? onItemTap;

  const CustomBottomSheet({
    required this.title,
    required this.items,
    required this.hight,
    this.onItemTap,
  }) : super();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 445,
      width: double.infinity,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 6,
            offset: Offset(0, 1),
          ),
        ],
        color: const Color(0xffffffff),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Stack(
        children: [
          const Image(
            image: AssetImage("assets/images/bt_sh.png"),
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: Color(0xff185A3F),
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                for (var i = 0; i < items.length; i++)
                  buildItem(items[i], context, i),
SizedBox(height: 25),
                Container(width: 120,height: 5,
                    color: const Color(0xffF2F2F2),),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildItem(String text, BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        if (onItemTap != null) onItemTap!(index);


        // Navigator.of(context).pop();
        //
        //
        // Navigator.of(context, rootNavigator: true).push(
        //   MaterialPageRoute(
        //     builder: (context) => Add_player_trainer(),
        //   ),
        // );
      },
      child: Container(
        margin: const EdgeInsets.all(6),
        alignment: Alignment.center,
        height: 52,
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xffF2F2F2),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          text,
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}