import 'dart:async';

import 'package:rokhshare/feature/home/data/remote/model/country.dart';
import 'package:rokhshare/feature/home/data/remote/model/genre.dart';
import 'package:rokhshare/utils/data_response.dart';


abstract class SearchRepository {
  Future<DataResponse<List<Genre>>> getGenres();

  Future<DataResponse<List<Country>>> getCountries();
}
