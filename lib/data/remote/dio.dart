// import 'dart:convert';
//
// import 'package:dio/dio.dart';
//
// class DioService {
//   late Dio _dio;
//
//   DioService() {
//     _dio = Dio(
//
//       BaseOptions(
//         baseUrl: "http://app774.uat.toq.sa/LacrosseApi/",
//         // ضع الرابط الأساسي هنا
//       ),
//     );
//   }
//
//   // إعداد التوكن عند الطلب
//   void setToken(String token) {
//     _dio.options.headers["Authorization"] = "Bearer $token";
//   }
//
//   // مسح التوكن
//   void clearToken() {
//     _dio.options.headers.remove("Authorization");
//   }
//
//   Dio get dio => _dio;
//
//   /// دالة GET بدون توكن
//   Future<Response> getWithoutToken(
//       String endpoint, {
//         Map<String, dynamic>? data,
//         Map<String, dynamic>? queryParameters,
//       }) async {
//     try {
//       final response = await _dio.get(
//         endpoint,
//         data: data,
//         queryParameters: queryParameters,
//       );
//       return response;
//     } catch (e) {
//       throw Exception("GET Without Token Error: ${e.toString()}");
//     }
//   }
//
//   /// دالة GET مع توكن
//   Future<Response> getWithToken(
//       String endpoint, {
//         Map<String, dynamic>? data,
//         Map<String, dynamic>? queryParameters,
//       }) async {
//     try {
//       final response = await _dio.get(
//         data: data,
//         endpoint,
//         queryParameters: queryParameters,
//       );
//       return response;
//     } catch (e) {
//       throw Exception("GET With Token Error: ${e.toString()}");
//     }
//   }
//
//   /// دالة POST بدون توكن
//   Future<Response> postWithoutToken(
//       String endpoint, {
//         Map<String, dynamic>? data,
//         Map<String, dynamic>? queryParameters,
//       }) async {
//     try {
//       final response = await _dio.post(
//         endpoint,
//         data: data,
//         queryParameters: queryParameters ?? {},
//         options: Options(headers: {'Content-Type': 'multipart/form-data'}),
//
//       );
//       return response;
//     } catch (e) {
//       throw Exception("POST Without Token Error: ${e.toString()}");
//     }
//   }
//   Future<Response> postWithoutTokenForRegisister(
//       String endpoint, {
//        required Map<String, dynamic> data,
//
//       }) async {
//     try {
//       final response = await _dio.request(
//         endpoint,
//         data: FormData.fromMap(data),
//         options: Options(
//           method: 'POST',
//           headers: {},
//         ),
//       );
//       return response;
//     } catch (e) {
//       throw Exception("POST Without Token Error: ${e.toString()}");
//     }
//   }
//
//
//
//
//
//   // Future<Response> postWithoutTokenastest(
//   //     String endpoint, {
//   //       Map<String, dynamic>? data,
//   //     //  Map<String, dynamic>? queryParameters,
//   //     }) async {
//   //   try {
//   //     // التأكد من تنسيق الرابط النهائي بشكل صحيح
//   //     final formattedEndpoint = Uri.parse(_dio.options.baseUrl).resolve(endpoint).toString();
//   //     print(formattedEndpoint);
//   //     // إعداد البيانات (تأكد من التشفير عند الحاجة)
//   //  //   final requestData = data != null ? jsonEncode(data) : null;
//   //
//   //     // إرسال الطلب باستخدام Dio
//   //     final response = await _dio.post(
//   //       endpoint,
//   //       data: data,
//   //      // queryParameters: queryParameters ?? {},
//   //             options: Options(headers: {
//   //               'Content-Type': 'application/json', // نوع البيانات المُرسلة
//   //               //'Accept': 'application/json', // نوع البيانات المطلوبة في الرد
//   //             }),
//   //     );
//   //
//   //     return response;
//   //   } catch (e) {
//   //     // التقاط الأخطاء مع رسائل مفيدة
//   //     throw Exception("حدث خطأ أثناء إرسال الطلب: ${e.toString()}");
//   //   }
//   // }
//
//   /// دالة POST مع توكن
//   Future<Response> postWithToken(
//       String endpoint, {
//         Map<String, dynamic>? data,
//         Map<String, dynamic>? queryParameters,
//       }) async {
//     try {
//       final response = await _dio.post(
//         endpoint,
//         data: data,
//         queryParameters: queryParameters,
//       );
//       return response;
//     } catch (e) {
//       throw Exception("POST With Token Error: ${e.toString()}");
//     }
//   }
// }
import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';

import '../Local/sharedPref/sharedPref.dart';

class DioService {
  late Dio _dio;

  DioService() {
    _dio = Dio(
      BaseOptions(
        baseUrl: "http://lacrossapi.uat.toq.sa/",
        // ضع الرابط الأساسي هنا
      ),
    );

    // _dio.interceptors.add(InterceptorsWrapper(
    //   onRequest: (options, handler) {
    //     // تعديل الطلب قبل الإرسال
    //     print("Requesting: ${options.uri}");
    //     return handler.next(options); // متابعة الطلب
    //   },
    //   onResponse: (response, handler) {
    //     // التعامل مع الرد
    //     print("Response: ${response.statusCode}");
    //     return handler.next(response); // متابعة الرد
    //   },
    //   onError: (DioError error, handler) async {
    //     // التعامل مع الأخطاء
    //     if (error.response?.statusCode == 401) {
    //       // مثال على التعامل مع انتهاء صلاحية التوكن
    //       print("Unauthorized, refreshing token...");
    //       // إعادة الحصول على التوكن وتنفيذ الطلب مجدداً (استخدام منطقك الخاص)
    //     }
    //     return handler.next(error); // متابعة الخطأ
    //   },
    // ));
  }

  // إعداد التوكن عند الطلب
  void setToken(String token) {
    _dio.options.headers["Authorization"] = "Bearer $token";
  }

  // مسح التوكن
  void clearToken() {
    _dio.options.headers.remove("Authorization");
  }
  Future<void> refreshToken()async {
    try {
      final response = await _dio.get(
        "api/Auth/refreshToken",

      );

    } catch (e) {
      throw Exception("GET Without Token Error: ${e.toString()}");
    }
  }


  Dio get dio => _dio;

  /// دالة GET بدون توكن
  Future<Response> getWithoutToken(
      String endpoint, {
        Map<String, dynamic>? data,
        Map<String, dynamic>? queryParameters,
      }) async {
    try {
      final response = await _dio.get(
        endpoint,
        data: data,
        queryParameters: queryParameters,
      );
      return response;
    } catch (e) {
      throw Exception("GET Without Token Error: ${e.toString()}");
    }
  }

  /// دالة GET مع توكن
  Future<Response> getWithToken(
      String endpoint, {
        Map<String, dynamic>? data,
        Map<String, dynamic>? queryParameters,
      }) async {
    try {
      final response = await _dio.get(
          data: data,
          endpoint,
          queryParameters: queryParameters,
          options: Options(
            headers: {
              'Content-Type': 'application/json', // تعيين نوع  المحتوى
              'Authorization':
              'Bearer ${CacheHelper.getData(key: "accessToken")}', // إذا كنت تستخدم مصادقة
            },
          ));
      return response;
    } catch (e) {
      throw Exception("GET With Token Error: ${e.toString()}");
    }
  }

  /// دالة POST بدون توكن
  Future<Response> postWithoutToken(
      String endpoint, {
        Map<String, dynamic>? data,
        //   Map<String, dynamic>? queryParameters,
      }) async {
    final response = await _dio.request(
      endpoint,
      data: data,
      // queryParameters: queryParameters ?? {},
      //  options: Options(headers: {'Content-Type': 'multipart/form-data'}),
      options: Options(
        method: 'POST',
        headers: {},
      ),
    );
    // print(response.data);
    return response;
  }

  Future<Response> postWithTokenForUploadImages(
      String endpoint, {
        required FormData formData,
      }) async {
    final response = await _dio.request(
      endpoint,
      //  data: FormData.fromMap(data),

      data: formData,
      options: Options(
        method: 'POST',
        headers: {
          "Content-Type": "multipart/form-data",
          "Authorization": 'Bearer ${CacheHelper.getData(key: "accessToken")}',
        },
      ),
    );
    print(response.data);
    return response;
  }
  Future<Response> EngYoussefpostWithTokenForUploadImages(
      String endpoint, {
        required FormData formData,
      }) async {
    final response = await _dio.request(
      endpoint,
      //  data: FormData.fromMap(data),

      data: formData,
      options: Options(
        method: 'POST',
        headers: {
          "Content-Type": "multipart/form-data",
          "Authorization": 'Bearer ${CacheHelper.getData(key: "accessToken")}',
        },
      ),
    );
    print(response.data);
    return response;
  }

  Future<Response> postWithoutTokenForRegister(
      String endpoint, {
        required Map<String, dynamic> data,
      }) async {
    final response = await _dio.request(
      endpoint,
      data: FormData.fromMap(data),
      options: Options(
        method: 'POST',
        headers: {},
      ),
    );
    print(response.data);
    return response;
  }

  Future<Response> postWithToken(
      String endpoint, {
        dynamic? data,
        Map<String, dynamic>? queryParameters,
      }) async {
    try {
      final response = await _dio.post(
        endpoint,
        data: data,
        queryParameters: queryParameters,
        options: Options(
          headers: {
            'Content-Type': 'application/json', // تعيين نوع المحتوى
            'Authorization':
            'Bearer ${CacheHelper.getData(key: "accessToken")}', // {CacheHelper.getData(key: "accessToken")}
          },
        ),
      );
      return response;
    } catch (e) {
      throw Exception("POST With Token Error: ${e.toString()}");
    }
  }

  Future<Response> putWithToken(
      String endpoint, {
        dynamic data, // <-- بقت dynamic عشان تقبل FormData أو Map
        Map<String, dynamic>? queryParameters,
      }) async {
    try {
      final response = await _dio.put(
        endpoint,
        data: data,
        queryParameters: queryParameters,
        options: Options(
          headers: {
            // لو data فورم داتا هتتبعت multipart تلقائي
            'Authorization': 'Bearer ${CacheHelper.getData(key: "accessToken")}',
          },
        ),
      );
      return response;
    } catch (e) {
      throw Exception("PUT With Token Error: ${e.toString()}");
    }
  }
  Future<Response> deleteWithTokenFormData(
      String endpoint, {
        FormData? data,
        Map<String, dynamic>? queryParameters,
      }) async {
    try {
      final response = await _dio.request(
        endpoint,
        data: data,
        queryParameters: queryParameters,
        options: Options(
          method: 'DELETE', // 👈 مهم جدًا
          headers: {
            'accept': '*/*',
            'Content-Type': 'multipart/form-data',
            'Authorization': 'Bearer ${CacheHelper.getData(key: "accessToken")}',
          },
        ),
      );
      return response;
    } on DioException catch (e) {
      print('❌ Dio Error: ${e.response?.data}');
      print('❌ Status code: ${e.response?.statusCode}');
      throw Exception("DELETE With Token FormData Error: ${e.toString()}");
    } catch (e) {
      throw Exception("DELETE With Token FormData General Error: ${e.toString()}");
    }
  }


  Future<Response> deleteWithToken(
      String endpoint, {
        dynamic? data,
        Map<String, dynamic>? queryParameters,
      }) async {
    try {
      final response = await _dio.delete(
        data: data,
        endpoint,
        queryParameters: queryParameters,
        options: Options(
          headers: {
            'Content-Type': 'application/json', // تعيين نوع المحتوى
            'Authorization': 'Bearer ${CacheHelper.getData(key: "accessToken")}', //'Bearer ${CacheHelper.getData(key: "accessToken")}', // إذا كنت تستخدم مصادقة
          },
        ),
      );
      return response;
    } catch (e) {
      throw Exception("GET With Token Error: ${e.toString()}");
    }
  }

  Future<Response> postWithTokenFromManager(
      String endpoint, {
        required Map<String, dynamic> data,
        Map<String, dynamic>? param,
      }) async {
    dio.options.headers = {
      // 'X-Requested-With': 'XMLHttpRequest',
      // 'Content-Type': 'application/json',
      'Authorization': "Bearer " + CacheHelper.getData(key: "accessToken"),
      // 'Accept-Language': 'en-US'
    };
    final response = await _dio.request(
      endpoint,
      data: FormData.fromMap(data),
      queryParameters: param,
      options: Options(
        method: 'POST',
        headers: {},
      ),
    );
    print(response.data);
    return response;
  }

  Future<Response> postWithTokenFromManagerForEdit(
      String endpoint, {
        required Map<String, dynamic> data,
        Map<String, dynamic>? param,
      }) async {
    dio.options.headers = {
      // 'X-Requested-With': 'XMLHttpRequest',
      // 'Content-Type': 'application/json',
      'Authorization': "Bearer " + CacheHelper.getData(key: "accessToken"),
      // 'Accept-Language': 'en-US'
    };
    final response = await _dio.request(
      endpoint,
      data: FormData.fromMap(data),
      queryParameters: param,
      options: Options(
        method: 'PUT',
        headers: {},
      ),
    );
    print(response.data);
    return response;
  }

  Future<Response> GetWithTokenFromManager(
      String endpoint, {
        required Map<String, dynamic> data,
        Map<String, dynamic>? param,
      }) async {
    dio.options.headers = {
      // 'X-Requested-With': 'XMLHttpRequest',
      // 'Content-Type': 'application/json',
      'Authorization': "Bearer " + CacheHelper.getData(key: "accessToken"),
      // 'Accept-Language': 'en-US'
    };
    final response = await _dio.request(
      endpoint,
      data: FormData.fromMap(data),
      queryParameters: param,
      options: Options(
        method: 'GET',
        headers: {},
      ),
    );
    print(response.data);
    return response;
  }

  Future<Response> postWithoutTokenForRegisister11(
      String endpoint, {
        required Map<String, dynamic> data,
      }) async {
    try {
      final response = await _dio.request(
        endpoint,
        data: FormData.fromMap(data),
        options: Options(
          method: 'POST',
          headers: {},
        ),
      );
      print(response.data);
      return response.data;
    } on DioException catch (e) {
      print("/////////////////////////////");
      print("/////////////${e.response!.data}////////////////");
      print("/////////////////////////////");
      throw Exception("${e.toString()}");
    }
  }
}
