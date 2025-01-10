import 'dart:async';
import 'package:rokhshare/feature/gallery/data/remote/model/gallery.dart';
import 'package:rokhshare/utils/data_response.dart';
import 'package:rokhshare/utils/page_response.dart';

abstract class GalleryRepository {
  Future<DataResponse<PageResponse<Gallery>>> getGalleries({required int id, int page = 1});
}
