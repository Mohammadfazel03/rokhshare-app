import 'package:dio/dio.dart';
import 'package:rokhshare/feature/home/data/remote/model/media.dart';
import 'package:rokhshare/feature/media_items/data/remote/media_items_api_service.dart';
import 'package:rokhshare/feature/media_items/data/repositories/media_items_repository.dart';
import 'package:rokhshare/utils/data_response.dart';
import 'package:rokhshare/utils/page_response.dart';

class MediaItemsRepositoryImpl extends MediaItemsRepository {
  final MediaItemsApiService _api;

  MediaItemsRepositoryImpl({required MediaItemsApiService api}) : _api = api;

  @override
  Future<DataResponse<PageResponse<Media>>> getCategoryItems(
      {required int categoryId, int page = 1}) async {
    try {
      Response response =
          await _api.getCategoryItems(categoryId: categoryId, page: page);
      if (response.statusCode == 200) {
        return DataSuccess(
            PageResponse.fromJson(response.data, (s) => Media.fromJson(s)));
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

  @override
  Future<DataResponse<PageResponse<Media>>> getCollectionItems(
      {required int collectionId, int page = 1}) async {
    try {
      Response response =
          await _api.getCollectionItems(collectionId: collectionId, page: page);
      if (response.statusCode == 200) {
        return DataSuccess(
            PageResponse.fromJson(response.data, (s) => Media.fromJson(s)));
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
