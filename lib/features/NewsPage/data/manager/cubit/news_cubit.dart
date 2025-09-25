import 'package:bloc/bloc.dart';
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
          "langId" :CacheHelper.getData(key: "lang") == "" ||CacheHelper.getData(key: "lang") == null  ? "1" :CacheHelper.getData(key: "lang")
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
          "id" : "$newsID"
          //activityId
        },
      );
      print(response);
      dynamic data = response.data;
      final NewsModel activityById =NewsModel.fromJson(data);

      print(activityById);
      emit(NewsByIdSuccess(activityById));
      print ("don with id");
    } catch (e) {
      emit(NewsByIdFailure(e.toString()));
    }
  }


}
