import 'package:flutter/material.dart';

class GameRole_Item extends StatefulWidget {
  final String question;
  final String answer;

  GameRole_Item({required this.question, required this.answer});

  @override
  _GameRole_ItemState createState() => _GameRole_ItemState();
}

class _GameRole_ItemState extends State<GameRole_Item> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Card(
        color: Color(0xffF6F8F8).withOpacity(1),
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // السؤال
            ListTile(
              title: Text(
                widget.question,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              trailing: Icon(
                isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
              ),
              onTap: () {
                setState(() {
                  isExpanded = !isExpanded;
                });
              },
            ),
            // الإجابة
            if (isExpanded)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Text(
                  widget.answer,
                  style: TextStyle(color: Color(0xff454F60)),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
////
