import 'package:dio/dio.dart';

class MediaItemsApiService {
  final Dio _dio;

  MediaItemsApiService({required Dio dio}) : _dio = dio;

  Future<dynamic> getCollectionItems(
      {required int collectionId, int page = 1}) async {
    return await _dio
        .get("collection/$collectionId/media/", queryParameters: {"page": page});
  }

  Future<dynamic> getCategoryItems(
      {required int categoryId, int page = 1}) async {
    return await _dio
        .get("genre/$categoryId/media/", queryParameters: {"page": page});
  }
}
