import 'dart:async';
import 'package:rokhshare/feature/home/data/remote/model/genre.dart';
import 'package:rokhshare/utils/data_response.dart';
import 'package:rokhshare/utils/page_response.dart';

abstract class CategoryRepository {
  Future<DataResponse<PageResponse<Genre>>> getCategories({int page = 1});
}
