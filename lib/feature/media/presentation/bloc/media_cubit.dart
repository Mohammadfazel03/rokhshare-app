import 'package:bloc/bloc.dart';
import 'package:rokhshare/feature/home/data/remote/model/media.dart';
import 'package:rokhshare/feature/media/data/repositories/media_repository.dart';
import 'package:rokhshare/utils/data_response.dart';
import 'package:rokhshare/utils/error_entity.dart';

part 'media_state.dart';

class MediaCubit extends Cubit<MediaState> {
  final MediaRepository repository;

  MediaCubit({required this.repository}) : super(MediaInitial());


  Future<void> getMedia(int id) async {
    emit(MediaLoading());
    DataResponse<Media> media = await repository.getMedia(id: id);

    if (media is DataSuccess) {
      emit(MediaSuccess(data: media.data!));
    } else {
      emit(MediaError(error: ErrorEntity(
          title: "خطا در دریافت اظلاعات",
          error: media.error ?? "خطا در دسترسی به اینترنت",
          code: media.code)));
    }
  }
}
