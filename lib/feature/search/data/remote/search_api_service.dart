import 'package:dio/dio.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class SearchApiService {
  final Dio _dio;

  SearchApiService({required Dio dio}) : _dio = dio;

  Future<dynamic> getGenres() async {
    return await _dio.get("genre/all/");
  }

  Future<dynamic> getCountries() async {
    return await _dio.get("country/all/");
  }

  Future<dynamic> search(
      {required String? query,
      required String type,
      required List<int>? genres,
      required List<int>? countries,
      required PickerDateRange? range,
      required String sortBy,
      int page = 1}) async {

    Map<String, dynamic> params = {
      'media_type': type,
      'sort_by': sortBy,
      'page': page
    };

    if (query != null) {
      params['query'] = query;
    }

    if (genres != null) {
      params['genres'] = genres;
    }

    if (countries != null) {
      params['countries'] = countries;
    }

    if (range != null) {
      params['start_date'] = range.startDate!.year;
      params['end_date'] = range.endDate!.year;
    }

    return await _dio.get("search/", queryParameters: params);
  }
}
