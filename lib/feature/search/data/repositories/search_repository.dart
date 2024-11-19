import 'dart:async';

import 'package:rokhshare/feature/home/data/remote/model/country.dart';
import 'package:rokhshare/feature/home/data/remote/model/genre.dart';
import 'package:rokhshare/feature/home/data/remote/model/media.dart';
import 'package:rokhshare/utils/data_response.dart';
import 'package:rokhshare/utils/page_response.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

abstract class SearchRepository {
  Future<DataResponse<List<Genre>>> getGenres();

  Future<DataResponse<List<Country>>> getCountries();

  Future<DataResponse<PageResponse<Media>>> search(
      {required String? query,
      required String type,
      required List<int>? genres,
      required List<int>? countries,
      required PickerDateRange? range,
      required String sortBy,
      int page = 1});
}
