import 'package:dio/dio.dart';

class MediaApiService {
  final Dio _dio;

  MediaApiService({required Dio dio}) : _dio = dio;

  Future<dynamic> getMedia({required int id}) async {
    return await _dio.get("media/$id/");
  }

  Future<dynamic> getEpisodes({required int id, int page = 1}) async {
    return await _dio
        .get("season/$id/episode/", queryParameters: {'page': page});
  }

  Future<dynamic> getSeasons({required int id}) async {
    return await _dio.get("series/$id/season/all/");
  }

  Future<dynamic> getRates({required int id}) async {
    return await _dio.get("media/$id/rate/");
  }

  Future<dynamic> getComments({required int id, int page = 1}) async {
    return await _dio
        .get("comment/media/$id/", queryParameters: {"page": page});
  }

  Future<dynamic> submitComment(
      {required int id, required String comment}) async {
    return await _dio.post("comment/", data: {"media": id, "comment": comment});
  }

  Future<dynamic> submitRate({required int id, required int rate}) async {
    return await _dio.post("rating/", data: {'rating': rate, 'media': id});
  }

  Future<dynamic> deleteRate({required int id}) async {
    return await _dio.delete("rating/$id/");
  }
}
