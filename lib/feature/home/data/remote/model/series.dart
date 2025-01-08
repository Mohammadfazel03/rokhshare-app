import 'package:rokhshare/feature/home/data/remote/model/media_file.dart';

class Series {
  Series({
    int? id,
    List<Season>? seasons,
    int? seasonNumber,
    int? episodeNumber,
  }) {
    _id = id;
    _seasons = seasons;
    _seasonNumber = seasonNumber;
    _episodeNumber = episodeNumber;
  }

  Series.fromJson(dynamic json) {
    _id = json['id'];
    if (json['seasons'] != null) {
      _seasons = [];
      json['seasons'].forEach((v) {
        _seasons?.add(Season.fromJson(v));
      });
    }
    _seasonNumber = json['season_number'];
    _episodeNumber = json['episode_number'];
  }

  int? _id;
  List<Season>? _seasons;
  int? _seasonNumber;
  int? _episodeNumber;

  int? get id => _id;

  List<Season>? get seasons => _seasons;

  int? get seasonNumber => _seasonNumber;

  int? get episodeNumber => _episodeNumber;
}

class Season {
  Season({
    String? name,
    int? number,
    int? id,
    int? episodeNumber,
    List<Episode>? episodes,
  }) {
    _name = name;
    _episodeNumber = episodeNumber;
    _id = id;
    _number = number;
    _episodes = episodes;
  }

  Season.fromJson(dynamic json) {
    _name = json['name'];
    _episodeNumber = json['episode_number'];
    _id = json['id'];
    _number = json['number'];
    if (json['episodes'] != null) {
      _episodes = [];
      json['episodes'].forEach((v) {
        _episodes?.add(Episode.fromJson(v));
      });
    }
  }

  String? _name;
  int? _number;
  int? _episodeNumber;
  List<Episode>? _episodes;
  int? _id;

  int? get id => _id;

  int? get episodeNumber => _episodeNumber;

  String? get name => _name;

  int? get number => _number;

  List<Episode>? get episodes => _episodes;
}

class Episode {
  Episode({
    String? name,
    int? number,
    MediaFile? video,
    int? time,
    String? synopsis,
    String? thumbnail,
    String? poster,
    String? publicationDate,
  }) {
    _name = name;
    _number = number;
    _video = video;
    _time = time;
    _synopsis = synopsis;
    _thumbnail = thumbnail;
    _poster = poster;
    _publicationDate = publicationDate;
  }

  Episode.fromJson(dynamic json) {
    _name = json['name'];
    _number = json['number'];
    _video = json['video'] != null ? MediaFile.fromJson(json['video']) : null;
    _time = json['time'];
    _synopsis = json['synopsis'];
    _thumbnail = json['thumbnail'];
    _poster = json['poster'];
    _publicationDate = json['publication_date'];
  }

  String? _name;
  int? _number;
  MediaFile? _video;
  int? _time;
  String? _synopsis;
  String? _thumbnail;
  String? _poster;
  String? _publicationDate;

  String? get name => _name;

  int? get number => _number;

  MediaFile? get video => _video;

  int? get time => _time;

  String? get synopsis => _synopsis;

  String? get thumbnail => _thumbnail;

  String? get poster => _poster;

  String? get publicationDate => _publicationDate;
}
