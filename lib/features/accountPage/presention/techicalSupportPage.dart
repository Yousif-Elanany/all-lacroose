import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../NewsPage/data/manager/cubit/news_cubit.dart';
import '../../NewsPage/data/model/newsModel.dart';
import '../data/manager/cubit/Account_State.dart';
import '../data/manager/cubit/Account_cubit.dart';
import '../widgets/button_default.dart';
import '../widgets/queationDesign.dart';
import '../widgets/textFeild_default.dart';

class TechnicalSupportPage extends StatefulWidget {
  TechnicalSupportPage();
  @override
  State<TechnicalSupportPage> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<TechnicalSupportPage> {
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: BlocBuilder<AccountCubit, AccountState>(
            builder: (context, state) {
          return Stack(
            children: [
              Stack(children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.14,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                            "assets/images/top bar.png"), // Replace with your asset path
                        fit: BoxFit
                            .cover, // Adjust to control how the image fits
                      ),
                      gradient: LinearGradient(
                        colors: [Colors.green.shade900, Colors.green.shade700],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 45.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          context.read<NewsCubit>().fetchAllNewsData();
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 0.0, top: 0),
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.6),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(8),
                                    ),
                                  ),
                                  child: Icon(Icons.arrow_back_ios_outlined,
                                      color: Color(0xff185A3F), size: 20),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'TechnicalSupport'.tr(),
                                style: TextStyle(
                                  color: Color(0xff185A3F),
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(),
                    ],
                  ),
                ),
              ]),
              Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Row(
                         // mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.email,size: 20,color: Color(0xff999999),),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * .01,
                            ),

                            Text(
                              'info@slf.sa'.tr(),
                              style: TextStyle(
                                color: Color(0xff2BA170),

                                fontSize: 16,
                                //   fontWeight: FontWeight.bold,
                              ),),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.location_on_rounded,size: 20,color: Color(0xff999999),),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * .01,
                            ),

                            Expanded(
                              child: Text(
                                ' السعوديه التخصصي المعزر الشمالي / الرياض المملكه العزبيه'.tr(),
                                style: TextStyle(
                                  color: Color(0xff2BA170),

                                  fontSize: 16,
                                  //   fontWeight: FontWeight.bold,
                                ),),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .02,
                        ),

                        SizedBox(
                          height: MediaQuery.of(context).size.height * .02,
                        ),
                      ],
                    ),
                  )),
            ],
          );
        }));
  }
}
