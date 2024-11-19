import 'package:rokhshare/feature/home/data/remote/model/country.dart';
import 'package:rokhshare/feature/home/data/remote/model/genre.dart';
import 'package:rokhshare/feature/home/data/remote/model/media_file.dart';

class Media {
  Media({
    int? id,
    List<Genre>? genres,
    List<Country>? countries,
    MediaFile? trailer,
    String? name,
    String? synopsis,
    String? thumbnail,
    String? poster,
    String? value,
    String? releaseDate,
  }) {
    _id = id;
    _genres = genres;
    _countries = countries;
    _trailer = trailer;
    _name = name;
    _synopsis = synopsis;
    _thumbnail = thumbnail;
    _poster = poster;
    _value = value;
    _releaseDate = releaseDate;
  }

  Media.fromJson(dynamic json) {
    _id = json['id'];
    if (json['genres'] != null) {
      _genres = [];
      json['genres'].forEach((v) {
        _genres?.add(Genre.fromJson(v));
      });
    }
    if (json['countries'] != null) {
      _countries = [];
      json['countries'].forEach((v) {
        _countries?.add(Country.fromJson(v));
      });
    }
    _trailer =
        json['trailer'] != null ? MediaFile.fromJson(json['trailer']) : null;
    _name = json['name'];
    _synopsis = json['synopsis'];
    _thumbnail = json['thumbnail'];
    _poster = json['poster'];
    _value = json['value'];
    _releaseDate = json['release_date'];
  }

  int? _id;
  List<Genre>? _genres;
  List<Country>? _countries;
  MediaFile? _trailer;
  String? _name;
  String? _synopsis;
  String? _thumbnail;
  String? _poster;
  String? _value;
  String? _releaseDate;

  int? get id => _id;

  List<Genre>? get genres => _genres;

  List<Country>? get countries => _countries;

  MediaFile? get trailer => _trailer;

  String? get name => _name;

  String? get synopsis => _synopsis;

  String? get thumbnail => _thumbnail;

  String? get poster => _poster;

  // String? get value => _value;
  MediaValue? get value {
    if (_value != null) {
      for (final v in MediaValue.values) {
        if (v.serverNameSpace == _value) {
          return v;
        }
      }
    }
    return null;
  }

  String? get releaseDate => _releaseDate;

  String get genresName {
    String s = "";
    for (int i = 0; i < (genres?.length ?? 0); i++) {
      if (i + 1 == (genres?.length ?? 0)) {
        s += (genres![i].title ?? "");
      } else {
        s += "${genres![i].title ?? ""} | ";
      }
    }
    return s;
  }

  String? get yearReleaseDate {
    var d = DateTime.tryParse(releaseDate ?? "");
    if (d != null) {
      return d.year.toString();
    }
    return "";
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    if (_genres != null) {
      map['genres'] = _genres?.map((v) => v.toJson()).toList();
    }
    if (_countries != null) {
      map['countries'] = _countries?.map((v) => v.toJson()).toList();
    }
    map['trailer'] = _trailer?.toJson();
    map['name'] = _name;
    map['synopsis'] = _synopsis;
    map['thumbnail'] = _thumbnail;
    map['poster'] = _poster;
    map['value'] = _value;
    map['release_date'] = _releaseDate;
    return map;
  }
}

enum MediaValue {
  free(persianTitle: "رایگان", serverNameSpace: "Free"),
  advertising(persianTitle: "تبلیغاتی", serverNameSpace: "Advertising"),
  subscription(persianTitle: "اشتراکی", serverNameSpace: "Subscription");

  final String persianTitle;
  final String serverNameSpace;

  const MediaValue({required this.persianTitle, required this.serverNameSpace});
}
