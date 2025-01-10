import 'package:dio/dio.dart';
import 'package:rokhshare/feature/gallery/data/remote/gallery_api_service.dart';
import 'package:rokhshare/feature/gallery/data/remote/model/gallery.dart';
import 'package:rokhshare/utils/data_response.dart';
import 'package:rokhshare/utils/page_response.dart';

import 'gallery_repository.dart';

class GalleryRepositoryImpl extends GalleryRepository {
  final GalleryApiService _api;

  GalleryRepositoryImpl({required GalleryApiService apiService})
      : _api = apiService;

  @override
  Future<DataResponse<PageResponse<Gallery>>> getGalleries(
      {required int id, int page = 1}) async {
    try {
      Response response = await _api.getGalleries(id: id, page: page);
      if (response.statusCode == 200) {
        return DataSuccess(
            PageResponse.fromJson(response.data, (s) => Gallery.fromJson(s)));
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
