import 'package:dio/dio.dart';

class PlayApiService {
  final Dio _dio;

  PlayApiService({required Dio dio}) : _dio = dio;

  Future<dynamic> playMovie({required int id}) async {
    return await _dio.get("movie/$id/play/");
  }

  Future<dynamic> playEpisode({required int id}) async {
    return await _dio.get("episode/$id/play/");
  }

  Future<dynamic> playAds(
      {required int mediaId, required int? episodeId}) async {
    return await _dio.post("advertise/play/",
        data: {"media": mediaId, "episode": episodeId});
  }
}
