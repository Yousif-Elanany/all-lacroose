import 'dart:io';

import '../Local/sharedPref/sharedPref.dart';

const getEvents = 'api/Event';


class BaseUrlApi {
  static String lang = "ar";
  static String versionNumber = "1";
  static String? tokenUser;
  static int? idUser;

//=================== getHeaderWithInToken Note ============
  getHeaderWithInToken() {
    return {
      HttpHeaders.authorizationHeader: "Bearer " + tokenUser!,
      'Accept-Language': lang,
      // ignore: unnecessary_string_interpolations
      'Version': '$versionNumber',
      "Accept": "application/json",
      'X-Requested-With': 'XMLHttpRequest',
      'Content-Type': 'application/json',
      //'Content-Type': 'application/json',
      "charset": "UTF-8"
    };
  }

//=================== getHeaderWithoutToken =============

  getHeaderWithoutToken() {
    return {
      'Accept-Language': lang,
      // ignore: unnecessary_string_interpolations
      'Version': '$versionNumber',
      "Accept": "application/json",
      'X-Requested-With': 'XMLHttpRequest',
      'Content-Type': 'application/json',
      //'Content-Type': 'application/json',
      "charset": "UTF-8"
    };
  }
}

/////// language id from cash Helper ///////////////////////

  String langID =  CacheHelper.getData(key: "lang");