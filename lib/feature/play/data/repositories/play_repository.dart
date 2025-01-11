import 'dart:async';

import 'package:rokhshare/feature/home/data/remote/model/media_file.dart';
import 'package:rokhshare/feature/play/data/remote/model/advertise.dart';
import 'package:rokhshare/utils/data_response.dart';

abstract class PlayRepository {

  Future<DataResponse<MediaFile>> playMovie({required int id});

  Future<DataResponse<MediaFile>> playEpisode({required int id});

  Future<DataResponse<Advertise>> playAds(
      {required int mediaId, required int? episodeId});
}
