import 'package:dio/dio.dart';
import 'package:rokhshare/feature/home/data/remote/home_api_service.dart';
import 'package:rokhshare/feature/home/data/remote/model/collection.dart';
import 'package:rokhshare/feature/home/data/remote/model/slider_model.dart';
import 'package:rokhshare/utils/data_response.dart';
import 'package:rokhshare/utils/page_response.dart';

import 'home_repository.dart';

class HomeRepositoryImpl extends HomeRepository {
  final HomeApiService _api;

  HomeRepositoryImpl({required HomeApiService apiService}) : _api = apiService;

  @override
  Future<DataResponse<List<SliderModel>>> getSlider() async {
    try {
      Response response = await _api.getSlider();
      if (response.statusCode == 200) {
        List<SliderModel> slider = ((response.data) as List)
            .map((e) => SliderModel.fromJson(e))
            .toList();
        return DataSuccess(slider);
      }
      return const DataFailed('در برقرای ارتباط مشکلی پیش آمده است.');
    } catch (e) {
      if (e is DioException) {
        DioException exception = e;
        int cat = ((exception.response?.statusCode ?? 0) / 100).round();
        if (cat == 5) {
          return const DataFailed('سایت در حال تعمیر است بعداً تلاش کنید.');
        }
      }
      return const DataFailed('در برقرای ارتباط مشکلی پیش آمده است.');
    }
  }

  @override
  Future<DataResponse<PageResponse<Collection>>> getCollections(
      {int page = 1}) async {
    try {
      Response response = await _api.getCollections(page: page);
      if (response.statusCode == 200) {
        return DataSuccess(PageResponse.fromJson(
            response.data, (s) => Collection.fromJson(s)));
      }
      return const DataFailed('در برقرای ارتباط مشکلی پیش آمده است.');
    } catch (e) {
      if (e is DioException) {
        DioException exception = e;
        if (exception.response?.statusCode == 404) {
          return const DataFailed('صفحه مورد نظر یافت نشد.');
        }
        int cat = ((exception.response?.statusCode ?? 0) / 100).round();
        if (cat == 5) {
          return const DataFailed('سایت در حال تعمیر است بعداً تلاش کنید.');
        }
      }
      return const DataFailed('در برقرای ارتباط مشکلی پیش آمده است.');
    }
  }
}
