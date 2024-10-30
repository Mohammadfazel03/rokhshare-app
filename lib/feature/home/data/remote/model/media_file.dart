
class MediaFile {
  MediaFile({
    String? file,
    String? mimetype,
    String? thumbnail,
    int? id,
  }) {
    _mimetype = mimetype;
    _file = file;
    _thumbnail = thumbnail;
    _id = id;
  }

  MediaFile.fromJson(dynamic json) {
    _mimetype = json['mimetype'];
    _file = json['file'];
    _thumbnail = json['thumbnail'];
    _id = json['id'];
  }

  String? _mimetype;
  String? _file;
  String? _thumbnail;
  int? _id;

  String? get mimetype => _mimetype;

  String? get file => _file;

  String? get thumbnail => _thumbnail;

  int? get id => _id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['mimetype'] = _mimetype;
    map['file'] = _file;
    map['thumbnail'] = _thumbnail;
    map['id'] = _id;
    return map;
  }
}
