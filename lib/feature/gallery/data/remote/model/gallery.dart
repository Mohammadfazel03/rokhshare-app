import 'package:rokhshare/feature/home/data/remote/model/media_file.dart';

class Gallery {
  Gallery({
    int? id,
    String? description,
    MediaFile? file
  }) {
    _id = id;
    _description = description;
    _file = file;
  }

  Gallery.fromJson(dynamic json) {
    _id = json['id'];
    _description = json['description'];
    _file = json['file'] != null ? MediaFile.fromJson(json['file']) : null;
  }

  int? _id;
  String? _description;
  MediaFile? _file;

  int? get id => _id;

  String? get description => _description;

  MediaFile? get file => _file;
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['description'] = _description;
    if (_file != null) {
      map['file'] = _file?.toJson();
    }
    return map;
  }

  bool get isVideo {
    return file?.mimetype?.contains('video') == true;
  }

  @override
  bool operator ==(Object other) {
    if (other is Gallery) {
      return other.id == id;
    }
    return false;
  }

  @override
  // TODO: implement hashCode
  int get hashCode => Object.hash(id, description, file);
}
