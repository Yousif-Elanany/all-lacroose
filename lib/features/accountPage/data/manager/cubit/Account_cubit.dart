import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';

import '../../../../../data/Local/sharedPref/sharedPref.dart';
import '../../../../../data/remote/dio.dart';
import '../../model/questionModel.dart';
import '../../model/updateUserDataModel.dart';
import 'Account_State.dart';








class AccountCubit extends Cubit<AccountState> {
  final DioService dioService;

  AccountCubit(this.dioService) : super(AccountInitial());

  Future<void> fetchAllQuestionData() async {
    print(" done  /////////////////////////////////");
    emit(QuestionLoading());
    try {
      final response = await dioService.getWithoutToken(
        "api/Question",  //http://app774.uat.toq.sa/LacrosseApi/api/Question?langId=1
        queryParameters: {
          "langId" :CacheHelper.getData(key: 'lang')??'1'//CacheHelper.getData(key: "lang") == "" ||CacheHelper.getData(key: "lang") == null  ? "1" :CacheHelper.getData(key: "lang")
        },
      );
      List<dynamic> data = response.data;
      final List<QuestionModel> question =
      data.map((json) => QuestionModel.fromJson(json)).toList();
      print(" done  /////////////////////////////////");
      // print(question);
      // print(response.data);

      emit(QuestionSuccess(question));
    } catch (e) {

      emit(QuestionFailure(e.toString()));
    }
  }
/////upload image_Video
  Future<void> uploadImage_video({
    required File file,
  }) async {
    emit(Image_videoloading());
    try {
      FormData formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(
          file.path,
          filename: file.path.split('/').last,
        ),
      });
      final response = await dioService.postWithTokenForUploadImages(
          "api/InternalEvent/UploadFile(Image/Video)",
          formData: formData);

      // AddEventModel model = AddEventModel.fromJson(response.data);
      print("from method");

      print(response.data["file"]);

      print("image_Video successful://////////////");
      print("image_Video successful: ${response.data}");
      emit(Image_videoSuccess(response.data["file"]));
    } on DioException catch (e) {
      print("/////image_Video////////${e.response!.data}////////////////");
      print("////////image_Video/////////////////////");
      emit(Image_videoFailure(e.response!.data.toString()));
    }
  }
  Future<void> editUserProfile({
    String? image,
    String? displayName,
    required String phoneNumber,

}) async {
    emit(editUserProfileLoading());
    try {
      final response = await dioService.putWithToken(
        "api/Auth/updateUserInformation",
        data: {
          "image": image,
          "displayName": displayName,
          "phoneNumber": "+966$phoneNumber"
        }

      );

      print(" done  /////////////////////////////////");
      Map<String,dynamic> data=response.data;
      // UserUpdateDataModel editedData= UserUpdateDataModel.fromJson(response.data);
      print(response.data);
      updateUserProfile(data["displayName"],data["image"],data["phoneNumber"],);
      //emit(editUserProfileSuccess(editedData));
    } catch (e) {

      emit(editUserProfileFailure(e.toString()));
    }
  }


  Future<void> updateUserProfile(String? name, String? image, String? phone) async {
  // final prefs = await SharedPreferences.getInstance();

  // تحميل القيم الحالية من SharedPreferences إذا كانت القيم الجديدة null

  String savedName = await CacheHelper.getData(key: "UserName")??"";
  String savedImage = await CacheHelper.getData(key: "UserPhoto") ?? "";
  String savedPhone = await CacheHelper.getData(key: "UserPhone") ?? "";




  // تحديث القيم فقط إذا لم تكن `null`
  String finalName = (name != null && name.isNotEmpty) ? name : savedName;
  String finalImage = image ?? savedImage;
  String finalPhone = phone ?? savedPhone;
    await CacheHelper.saveData(key: "UserName", value: finalName);
    await CacheHelper.saveData(key: "UserPhoto", value: finalImage);
    await CacheHelper.saveData(key: "UserPhone", value: finalPhone);


  emit(editUserProfileSuccess(finalName, finalImage, finalPhone)); //  تحديث كل الصفحات
  }


}
