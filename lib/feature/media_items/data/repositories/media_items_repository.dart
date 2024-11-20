import 'package:rokhshare/feature/home/data/remote/model/media.dart';
import 'package:rokhshare/utils/data_response.dart';
import 'package:rokhshare/utils/page_response.dart';

abstract class MediaItemsRepository {
  Future<DataResponse<PageResponse<Media>>> getCollectionItems(
      {required int collectionId, int page = 1});

  Future<DataResponse<PageResponse<Media>>> getCategoryItems(
      {required int categoryId, int page = 1});
}
