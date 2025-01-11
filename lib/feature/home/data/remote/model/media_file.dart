class MediaFile {
  MediaFile(
      {String? file,
      String? mimetype,
      String? thumbnail,
      int? id,
      bool? isPremium,
      List<int>? adsTime}) {
    _mimetype = mimetype;
    _file = file;
    _thumbnail = thumbnail;
    _id = id;
    _isPremium = isPremium;
    _adsTime = adsTime;
  }

  MediaFile.fromJson(dynamic json) {
    _mimetype = json['mimetype'];
    _file = json['file'];
    _thumbnail = json['thumbnail'];
    _isPremium = json['is_premium'];
    _id = json['id'];
    _adsTime = json['ads_time'] != null ? json['ads_time'].cast<int>() : [];
  }

  String? _mimetype;
  String? _file;
  String? _thumbnail;
  int? _id;
  List<int>? _adsTime;
  bool? _isPremium;

  String? get mimetype => _mimetype;

  String? get file => _file;

  String? get thumbnail => _thumbnail;

  int? get id => _id;

  List<int>? get adsTime => _adsTime;

  bool? get isPremium => _isPremium;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['mimetype'] = _mimetype;
    map['file'] = _file;
    map['thumbnail'] = _thumbnail;
    map['id'] = _id;
    return map;
  }
}
