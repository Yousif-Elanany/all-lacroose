
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lacrosse/data/endPoints/endpoint.dart';
import 'package:lacrosse/features/NewsPage/data/manager/cubit/news_cubit.dart';
import 'package:lacrosse/features/accountPage/widgets/ButtonDesignLang.dart';

import '../../../data/Local/sharedPref/sharedPref.dart';
import '../../ActivitesPage/data/manager/cubit/activities_cubit.dart';
import '../../home/data/manager/cubit/home_cubit.dart';
import '../../layout/Tabs/BaseScreen.dart';


class LangBottomSheet extends StatefulWidget {
  const LangBottomSheet({super.key});

  @override
  State<LangBottomSheet> createState() => _LangBottomSheetState();
}

class _LangBottomSheetState extends State<LangBottomSheet> {
  String _selectedLanguage = 'Arabic';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
      height: (MediaQuery.of(context).size.height * 0.4),
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.9),
              blurRadius: 6,
              offset: Offset(0, 4),
            ),
          ],
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 10),
            child: Divider(
              height: 5,
              thickness: 2,
            ),
          ),
          Text(
            'Choose language'.tr(),
            style: TextStyle(
              color: Colors.grey[400], //Color(0xff185A3F),
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          LanguageOption(
            language: 'English',
            Img: "assets/images/usa.png",
            isSelected: _selectedLanguage == 'English',
            onChanged: (selected) {
              setState(() {
                _selectedLanguage = 'English';
              });
            },
          ),
          LanguageOption(
            language: 'arabic'.tr(),
            Img:
            "assets/images/saudi.png",
            isSelected: _selectedLanguage == 'Arabic',
            onChanged: (selected) {
              setState(() {
                _selectedLanguage = 'Arabic';
              });
            },
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context); // Close the modal without action
                  },
                  child: Container(
                    padding: EdgeInsets.all(
                        10),
                    //margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.10),
                    alignment: Alignment.center,

                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: Color(0xff185A3F),
                          width: 1,
                        )),
                    child: Text(
                      'cancel'.tr(),
                      style: TextStyle(
                        color: Color(0xff185A3F),
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: MediaQuery.of(context).size.width * 0.04),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    if (_selectedLanguage == 'Arabic') {
                      CacheHelper.saveData(key: "lang", value: "1");
                      context.setLocale(Locale('ar'));
                      Navigator.of(context).pop();
                      setState(() {
                        context.setLocale(
                            EasyLocalization.of(context)!.supportedLocales[1]);
                      });


                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) {
                            return Basescreen();
                          }));
                    } else {
                      CacheHelper.saveData(key: "lang", value: "2");
                      //   print(" mahdy //////////////////");
                      context.setLocale(Locale('en'));
                      print(CacheHelper.getData(key: "lang"));
                      Navigator.of(context).pop();
                      setState(() {
                        context.setLocale(
                            EasyLocalization.of(context)!.supportedLocales[0]);
                      });
                      // stateSetter(() {
                      //   CacheHelper.saveData(key: 'lang', value: 'ar');
                      //   context.setLocale(
                      //       EasyLocalization.of(context)!.supportedLocales[1]);
                      // });

                      //
                      // print("Setting " +
                      //     EasyLocalization.of(context)!.locale.languageCode);



                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) {
                            return Basescreen();
                          }));
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.all(
                       10),
                    //margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.10),
                    alignment: Alignment.center,

                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Color(0xff185A3F),
                    ),
                    child: Text(
                      'confirm'.tr(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
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
