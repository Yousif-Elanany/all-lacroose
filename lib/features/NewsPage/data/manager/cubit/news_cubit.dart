import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:lacrosse/data/endPoints/endpoint.dart';

import '../../../../../data/Local/sharedPref/sharedPref.dart';
import '../../../../../data/remote/dio.dart';
import '../../model/newsModel.dart';
import 'news_states.dart';

class NewsCubit extends Cubit<NewsState> {
  final DioService dioService;

  NewsCubit(this.dioService) : super(NewsInitial());

  Future<void> fetchAllNewsData() async {
    emit(NewsLoading());
    try {
      final response = await dioService.getWithoutToken(
        "api/News",
        queryParameters: {
          "langId": CacheHelper.getData(key: "lang") == "" ||
                  CacheHelper.getData(key: "lang") == null
              ? "1"
              : CacheHelper.getData(key: "lang")
        },
      );
      List<dynamic> data = response.data;
      final List<NewsModel> News =
          data.map((json) => NewsModel.fromJson(json)).toList();
      print(" done");

      emit(NewsSuccess(News));
    } catch (e) {
      emit(NewsFailure(e.toString()));
    }
  }

  Future<void> fetchAllNewsDataById(int newsID) async {
    emit(NewsByIdLoading());
    try {
      final response = await dioService.getWithoutToken(
        "api/News/getById",
        queryParameters: {
          "id": "$newsID"
          //activityId
        },
      );
      print(response);
      dynamic data = response.data;
      final NewsModel activityById = NewsModel.fromJson(data);

      print(activityById);
      emit(NewsByIdSuccess(activityById));
      print("don with id");
    } catch (e) {
      emit(NewsByIdFailure(e.toString()));
    }
  }

  Future<void> EditNews(NewsModel news) async {
    emit(EditNewsLoading());
    try {
      final response = await dioService.putWithToken(
        "api/News/UpdateV2",
        data: news.toUpdateJson(), // 👈 هنا بنستخدم الـ toUpdateJson
      );

     dynamic data = response.data;


      print("✅ Done $data");
      emit(EditNewsSuccess());
    } catch (e) {
      emit(EditNewsFailure(e.toString()));
    }
  }



  ///////// players /////  String encodedFile = encodeFileToBase64(file);
  /////upload image_Video
  Future<String?> uploadImage_video({required File file}) async {
    emit(UploadImageLoading());
    try {
      FormData formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(
          file.path,
          filename: file.path.split('/').last,
        ),
      });

      final response = await dioService.postWithTokenForUploadImages(
        "api/News/UploadNewsImage",
        formData: formData,
      );

      final uploadedFile = response.data["file"]; // ده بيرجع Images/NewsImages/xxx.png
      final fullUrl = "http://lacrossapi.uat.toq.sa/$uploadedFile"; // ✅ نكمل اللينك

      print("🖼️ Uploaded image full URL: $fullUrl");

      emit(UploadImageSuccess(fullUrl));
      return fullUrl; // ✅ رجّع اللينك الكامل
    } on DioException catch (e) {
      emit(UploadImageFailure(e.response?.data['message'] ?? "Unknown error"));
      return null;
    }
  }



  Future<void> DeleteNewsById({
    int? id,
  }) async {
    emit(NewDeletedLoading());
    try {
      final response = await dioService.deleteWithToken(
        "api/News/deleteNews",
        queryParameters: {
          "id": id
          //activityId
        },
      );

      print(" done");

      emit(NewDeletedSuccess());
      fetchAllNewsData();
    } catch (e) {
      emit(NewDeletedFailure());
    }
  }
}
