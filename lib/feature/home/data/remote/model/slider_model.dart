import 'package:rokhshare/feature/home/data/remote/model/media.dart';

class SliderModel {
  SliderModel({
    int? id,
    Media? media,
    String? description,
    String? title,
    int? priority,
    num? rating,
    String? thumbnail,
    String? poster,
  }) {
    _id = id;
    _media = media;
    _description = description;
    _title = title;
    _priority = priority;
    _thumbnail = thumbnail;
    _poster = poster;
    _rating = rating;
  }

  SliderModel.fromJson(dynamic json) {
    _id = json['id'];
    _media = json['media'] != null ? Media.fromJson(json['media']) : null;
    _description = json['description'];
    _title = json['title'];
    _priority = json['priority'];
    _thumbnail = json['thumbnail'];
    _poster = json['poster'];
    _rating = json['rating'];
  }

  int? _id;
  Media? _media;
  String? _description;
  String? _title;
  int? _priority;
  String? _thumbnail;
  String? _poster;
  num? _rating;

  int? get id => _id;

  Media? get media => _media;

  String? get description => _description;

  String? get title => _title;

  int? get priority => _priority;

  String? get thumbnail => _thumbnail;

  String? get poster => _poster;

  num? get rating => _rating;
}
