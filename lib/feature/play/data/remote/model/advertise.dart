import 'package:rokhshare/feature/home/data/remote/model/media_file.dart';

class Advertise {
  Advertise({
      int? id, 
      String? title, 
      MediaFile? file,}){
    _id = id;
    _title = title;
    _file = file;
}

  Advertise.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
    _file = json['file'] != null ? MediaFile.fromJson(json['file']) : null;
  }
  int? _id;
  String? _title;
  MediaFile? _file;

  int? get id => _id;
  String? get title => _title;
  MediaFile? get file => _file;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    if (_file != null) {
      map['file'] = _file?.toJson();
    }
    return map;
  }

}