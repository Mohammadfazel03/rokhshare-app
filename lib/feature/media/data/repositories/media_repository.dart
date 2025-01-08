import 'dart:async';

import 'package:rokhshare/feature/home/data/remote/model/comment.dart';
import 'package:rokhshare/feature/home/data/remote/model/media.dart';
import 'package:rokhshare/feature/home/data/remote/model/series.dart';
import 'package:rokhshare/feature/media/data/remote/model/rating.dart';
import 'package:rokhshare/utils/data_response.dart';
import 'package:rokhshare/utils/page_response.dart';

abstract class MediaRepository {
  Future<DataResponse<Media>> getMedia({required int id});

  Future<DataResponse<List<Season>>> getSeasons({required int id});

  Future<DataResponse<List<Rating>>> getRates({required int id});

  Future<DataResponse<void>> submitRates({required int id, required int rate});

  Future<DataResponse<void>> submitComment(
      {required int id, required String comment});

  Future<DataResponse<void>> deleteRates({required int id});

  Future<DataResponse<PageResponse<Episode>>> getEpisodes(
      {required int seasonId, int page = 1});

  Future<DataResponse<PageResponse<Comment>>> getComments(
      {required int id, int page = 1});
}
