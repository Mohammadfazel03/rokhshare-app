import 'package:dio/dio.dart';

class GalleryApiService {
  final Dio _dio;

  GalleryApiService({required Dio dio}) : _dio = dio;

  Future<dynamic> getGalleries({required int id, int page = 1}) async {
    return await _dio.get("media/$id/gallery/", queryParameters: {"page": page});
  }
}
