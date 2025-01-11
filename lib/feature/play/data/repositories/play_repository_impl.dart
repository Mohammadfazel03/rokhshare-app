import 'package:dio/dio.dart';
import 'package:rokhshare/feature/home/data/remote/model/media_file.dart';
import 'package:rokhshare/feature/play/data/remote/model/advertise.dart';
import 'package:rokhshare/feature/play/data/remote/play_api_service.dart';
import 'package:rokhshare/utils/data_response.dart';

import 'play_repository.dart';

class PlayRepositoryImpl extends PlayRepository {
  final PlayApiService _api;

  PlayRepositoryImpl({required PlayApiService apiService}) : _api = apiService;

  @override
  Future<DataResponse<Advertise>> playAds(
      {required int mediaId, required int? episodeId}) async {
    try {
      Response response =
          await _api.playAds(mediaId: mediaId, episodeId: episodeId);
      if (response.statusCode == 200) {
        return DataSuccess(Advertise.fromJson(response.data));
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
  Future<DataResponse<MediaFile>> playEpisode({required int id}) async {
    try {
      Response response = await _api.playEpisode(id: id);
      if (response.statusCode == 200) {
        return DataSuccess(MediaFile.fromJson(response.data));
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
  Future<DataResponse<MediaFile>> playMovie({required int id}) async {
    try {
      Response response = await _api.playMovie(id: id);
      if (response.statusCode == 200) {
        return DataSuccess(MediaFile.fromJson(response.data));
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
}
