import 'artist.dart';

class Cast {
  Cast({
    Artist? artist,
    String? position,
  }) {
    _artist = artist;
    _position = position;
  }

  Cast.fromJson(dynamic json) {
    _artist = json['artist'] != null ? Artist.fromJson(json['artist']) : null;
    _position = json['position'];
  }

  Artist? _artist;
  String? _position;

  Artist? get artist => _artist;

  String? get position => _position;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_artist != null) {
      map['artist'] = _artist?.toJson();
    }
    map['position'] = _position;
    return map;
  }
}
