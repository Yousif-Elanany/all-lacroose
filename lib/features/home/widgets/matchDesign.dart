import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../data/models/matchModel.dart';

class MatchWidget extends StatelessWidget {
  MatchWidget({
    super.key,
    required this.matchList,
    required this.index
  });

  final List<MatchModel> matchList;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      //    width:MediaQuery.of(context).size.width*0.5,
       height: 150,
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.1),
        //  border: Border.all(color: Colors.grey),

        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(matchList[index].firstTeamName,
                    style: TextStyle(
                      //  fontWeight: FontWeight.bold
                      fontSize: 14

                    )
                      ),
                // CircleAvatar(
                //   backgroundColor: Colors.white,
                //   radius: 15,
                //   child: ClipOval(
                //     child: Image.network(
                //       matchList[index].firstTeamImage,
                //       fit: BoxFit.cover, // لجعل الصورة تغطي الدائرة بشكل مناسب
                //       width: 30, // يجب أن يكون أكبر أو يساوي `2 * radius`
                //       height: 30, // يجب أن يكون أكبر أو يساوي `2 * radius`
                //     ),
                //   ),
                // ),
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.white,
                  child: ClipOval(
                    child:  matchList[index].firstTeamImage.isNotEmpty
                        ? Image.network(
                      matchList[index].firstTeamImage,
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        // لو الرابط فشل، نعرض الصورة من assets
                        return Image.asset(
                          "assets/images/c2.png",
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        );
                      },
                    )
                        : Image.asset(
                      "assets/images/c2.png",
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // CircleAvatar(
                //     radius: 20,
                //     backgroundColor: Colors.white,
                //     backgroundImage:  matchList[index].firstTeamImage.isNotEmpty
                //         ? NetworkImage( matchList[index].firstTeamImage)
                //         : AssetImage("assets/images/c2.png")
                // ),
                SizedBox(height: 6.0),
                Text(matchList[index].totalFirstTeamGoals.toString(),
                  style: TextStyle(
                    // fontWeight: FontWeight.bold)
                      fontSize: 14
                  ),),
                SizedBox(height: 6.0),                Row(children: [
                  Text(

                      DateFormat("a h:mm").format(matchList[index].appointment)
                      ,
                      style: TextStyle(
                          fontSize: 10, color: Colors.grey)),
                  Icon(Icons.access_time_outlined,size:12 ,color: Colors.grey,)
                ],)

              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(' VS',
                  style: TextStyle(
                      fontSize: 16, color: Colors.grey)),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(matchList[index].secondTeamName,
                    style: TextStyle(
                       // fontWeight: FontWeight.bold)
                    fontSize: 14
                ),),
                SizedBox(height: 6.0),
                // CircleAvatar(
                //     radius: 20,
                //     backgroundColor: Colors.white,
                //     backgroundImage:  matchList[index].secondTeamImage.isNotEmpty
                //         ? NetworkImage( matchList[index].secondTeamImage)
                //         : AssetImage("assets/images/c2.png")
                // ),
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.white,
                  child: ClipOval(
                    child:  matchList[index].secondTeamImage.isNotEmpty
                        ? Image.network(
                      matchList[index].secondTeamImage,
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        // لو الرابط فشل، نعرض الصورة من assets
                        return Image.asset(
                          "assets/images/c2.png",
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        );
                      },
                    )
                        : Image.asset(
                      "assets/images/c2.png",
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 6.0),
                Text(matchList[index].totalSecondTeamGoals.toString(),
                  style: TextStyle(
                    // fontWeight: FontWeight.bold)
                      fontSize: 14
                  ),),
                SizedBox(height: 6.0),

                Row(
                  children:[ Text(
                      DateFormat("MMM d").format(matchList[index].appointment)
                      ,
                      style: TextStyle(
                          fontSize: 10, color: Colors.grey)),
                    Icon(Icons.calendar_month_outlined,size:12 ,color: Colors.grey,)
      ]
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}