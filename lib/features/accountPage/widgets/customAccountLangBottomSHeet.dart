import 'package:flutter/material.dart';

class LangBottomSheet extends StatelessWidget {
  const LangBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return

      Container(
        padding: EdgeInsets.all( MediaQuery.of(context).size.width * 0.05),

        height: ( MediaQuery.of(context).size.height * 0.4),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.9),
                blurRadius: 6,
                offset: Offset(0, 4),
              ),
            ],
            color: Colors.white,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(30),
                topRight: Radius.circular(30))
        ),
        child: Column(

          crossAxisAlignment: CrossAxisAlignment.center,
          children: [


            Text(
              'Choose the language',
              style: TextStyle(
                color: Colors.grey[400],//Color(0xff185A3F),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20,),
            Container(
                padding: EdgeInsets.all( MediaQuery.of(context).size.width * 0.04),


                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.lightBlue,
                      width: 1,

                    )
                ),

                child: Row(

                  children: [
                    Icon(
                      Icons.flag,color: Colors.red,),
                    Text(
                      '    English',
                      style: TextStyle(
                        // color: Colors.grey[300],//Color(0xff185A3F),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),

                    ) ,
                    Spacer(),
                    Icon(Icons.radio_button_checked_outlined,
                      color: Colors.lightBlue,),


                  ],




                )),
            Container(
                padding: EdgeInsets.all( MediaQuery.of(context).size.width * 0.04),


                // decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(20),
                //     border: Border.all(
                //       color: Colors.lightBlue,
                //       width: 1,
                //
                //     )
                // ),

                child: Row(

                  children: [
                    Icon(
                      Icons.flag,color: Colors.greenAccent,),
                    Text(
                      '    arabic',
                      style: TextStyle(
                        // color: Colors.grey[300],//Color(0xff185A3F),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),

                    ) ,
                    Spacer(),
                    Icon(Icons.radio_button_off,
                      color: Colors.grey,
                    ),


                  ],




                )),
            SizedBox(height: 25,),

            Row(

              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all( MediaQuery.of(context).size.width * 0.03),
                    //margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.10),
                    alignment: Alignment.center,

                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color:Color(0xff185A3F),
                          width: 1,

                        )
                    ),
                    child: Text(

                      'cancle',
                      style: TextStyle(
                        color:Color(0xff185A3F),
                        fontSize: 20,

                      ),
                    ),

                  ),
                ),
                SizedBox(width:MediaQuery.of(context).size.width * 0.04) ,
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all( MediaQuery.of(context).size.width * 0.03),
                    //margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.10),
                    alignment: Alignment.center,

                    decoration: BoxDecoration(


                      borderRadius: BorderRadius.circular(15),
                      color:Color(0xff185A3F),

                      // border: Border.all(
                      //   color:Colors.lightGreen,
                      //
                      //   width: 1,
                      //
                      // )
                    ),
                    child: Text(

                      'confirm',
                      style: TextStyle(
                        color:Colors.white,
                        fontSize: 20,

                      ),
                    ),

                  ),
                ),
              ],
            )


          ],
        ),


      );
  }
}
