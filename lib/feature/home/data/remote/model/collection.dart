import 'package:rokhshare/feature/home/data/remote/model/media.dart';

class Collection {
  Collection({
    int? id,
    String? name,
    String? createdAt,
    String? poster,
    String? lastUpdate,
    List<Media>? media,
  }) {
    _id = id;
    _name = name;
    _createdAt = createdAt;
    _poster = poster;
    _lastUpdate = lastUpdate;
    _media = media;
  }

  Collection.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _createdAt = json['created_at'];
    _poster = json['poster'];
    _lastUpdate = json['last_update'];
    if (json['media'] != null) {
      _media = [];
      json['media'].forEach((v) {
        _media?.add(Media.fromJson(v));
      });
    }
  }

  int? _id;
  String? _name;
  String? _createdAt;
  String? _poster;
  String? _lastUpdate;
  List<Media>? _media;

  int? get id => _id;

  String? get name => _name;

  String? get createdAt => _createdAt;

  String? get poster => _poster;

  String? get lastUpdate => _lastUpdate;

  List<Media>? get media => _media;
}
