import 'dart:async';

import 'package:rokhshare/feature/home/data/remote/model/collection.dart';
import 'package:rokhshare/feature/home/data/remote/model/slider_model.dart';
import 'package:rokhshare/utils/data_response.dart';
import 'package:rokhshare/utils/page_response.dart';

abstract class HomeRepository {
  Future<DataResponse<List<SliderModel>>> getSlider();

  Future<DataResponse<PageResponse<Collection>>> getCollections({int page = 1});
}
