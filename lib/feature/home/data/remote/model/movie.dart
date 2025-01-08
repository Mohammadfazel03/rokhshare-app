import 'package:rokhshare/feature/home/data/remote/model/media_file.dart';

class Movie {
  Movie({
    int? id,
    MediaFile? video,
    int? time,
  }) {
    _id = id;
    _video = video;
    _time = time;
  }

  Movie.fromJson(dynamic json) {
    _id = json['id'];
    _video = json['video'] != null ? MediaFile.fromJson(json['video']) : null;
    _time = json['time'];
  }

  int? _id;
  MediaFile? _video;
  int? _time;

  int? get id => _id;

  MediaFile? get video => _video;

  int? get time => _time;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    if (_video != null) {
      map['video'] = _video?.toJson();
    }
    map['time'] = _time;
    return map;
  }
}