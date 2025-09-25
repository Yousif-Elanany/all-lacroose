import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lacrosse/features/layout/Tabs/BaseScreen.dart';

import '../../../data/Local/sharedPref/sharedPref.dart';

Widget changeLanguage(context) {
  return StatefulBuilder(
    builder: (context, stateSetter) {
      return CupertinoActionSheet(
        title: Text(
          'The language'.tr(),
        ),
        message: Column(
          children: [
            Text('ChooseLang'.tr()),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CupertinoActionSheetAction(
                  child: Column(
                    children: [
                      Container(
                          height: 30,
                          width: 30,
                          child: Image.asset("assets/images/american-flag-logo-vector.png")),
                      Text('English'),
                    ],
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    stateSetter(() {
                      CacheHelper.saveData(key: 'lang', value: 'en');
                      context.setLocale(
                          EasyLocalization.of(context)!.supportedLocales[0]);
                    });

                    // BaseUrlApi.lang = EasyLocalization.of(context)
                    //     .locale
                    //     .languageCode;
                    print("Setting " +
                        EasyLocalization.of(context)!.locale.languageCode);

                    //
                    //       Navigator.of(context).pop();

                    // Either<String, Response> response = await DioHelper.PutDataEither(
                    //     endPoint: BaseUrlApi.setLang,
                    //     needToken: true,context: context,
                    //     formDataInput: {
                    //       "language":   BaseUrlApi.lang
                    //     }
                    //
                    // );

                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) {
                          return Basescreen();
                        }));
                  },
                ),
                CupertinoActionSheetAction(
                  child: Column(
                    children: [
                      Container(
                          height: 30,
                          width: 30,
                          child: Image.asset("assets/images/saudi-arabia-flag-logo-634C79FFDA-seeklogo.com.png")),
                      Text('Arabic'),
                    ],
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    stateSetter(() {
                      CacheHelper.saveData(key: 'lang', value: 'ar');
                      context.setLocale(
                          EasyLocalization.of(context)!.supportedLocales[1]);
                    });

                    // BaseUrlApi.lang = EasyLocalization.of(context)
                    //     .locale
                    //     .languageCode;
                    print("Setting " +
                        EasyLocalization.of(context)!.locale.languageCode);

                    //
                    //       Navigator.of(context).pop();

                    // Either<String, Response> response = await DioHelper.PutDataEither(
                    //     endPoint: BaseUrlApi.setLang,
                    //     needToken: true,context: context,
                    //     formDataInput: {
                    //       "language":   BaseUrlApi.lang
                    //     }
                    //
                    // );

                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) {
                          return Basescreen();
                        }));
                  },
                ),
              ],
            )
          ],
        ),
        cancelButton: CupertinoActionSheetAction(
          child: Text('Cancel'.tr()),
          isDefaultAction: true,
          onPressed: () {
            Navigator.pop(context, 'Cancel');
          },
        ),
      );
    },
  );
}