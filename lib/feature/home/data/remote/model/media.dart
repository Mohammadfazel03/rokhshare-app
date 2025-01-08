import 'package:rokhshare/feature/home/data/remote/model/country.dart';
import 'package:rokhshare/feature/home/data/remote/model/genre.dart';
import 'package:rokhshare/feature/home/data/remote/model/media_file.dart';
import 'package:rokhshare/feature/home/data/remote/model/series.dart';

import 'cast.dart';
import 'comment.dart';
import 'movie.dart';

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
    List<Cast>? casts,
    List<Comment>? comments,
    double? rate,
    bool? isMovie,
    int? myRate,
    int? totalComments,
    bool? isPremium,
    Movie? movie,
    Series? series,
  }) {
    _id = id;
    _genres = genres;
    _countries = countries;
    _trailer = trailer;
    _casts = casts;
    _comments = comments;
    _rate = rate;
    _name = name;
    _synopsis = synopsis;
    _thumbnail = thumbnail;
    _poster = poster;
    _value = value;
    _releaseDate = releaseDate;
    _isMovie = isMovie;
    _myRate = myRate;
    _isPremium = isPremium;
    _movie = movie;
    _series = series;
    _totalComments = totalComments;
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
    _totalComments = json['total_comments'];
    _value = json['value'];
    _releaseDate = json['release_date'];
    _isMovie = json['is_movie'];
    _myRate = json['my_rate'];
    _isPremium = json['is_premium'];
    _movie = json['movie'] != null ? Movie.fromJson(json['movie']) : null;
    _series = json['series'] != null ? Series.fromJson(json['series']) : null;
    if (json['casts'] != null) {
      _casts = [];
      json['casts'].forEach((v) {
        _casts?.add(Cast.fromJson(v));
      });
    }
    if (json['comments'] != null) {
      _comments = [];
      json['comments'].forEach((v) {
        _comments?.add(Comment.fromJson(v));
      });
    }
    _rate = json['rate'];
  }

  int? _id;
  List<Genre>? _genres;
  List<Country>? _countries;
  MediaFile? _trailer;
  List<Cast>? _casts;
  List<Comment>? _comments;
  double? _rate;
  String? _name;
  String? _synopsis;
  String? _thumbnail;
  String? _poster;
  String? _value;
  String? _releaseDate;
  bool? _isMovie;
  int? _myRate;
  int? _totalComments;
  bool? _isPremium;
  Movie? _movie;
  Series? _series;

  int? get id => _id;

  List<Genre>? get genres => _genres;

  List<Country>? get countries => _countries;

  MediaFile? get trailer => _trailer;

  String? get name => _name;

  String? get synopsis => _synopsis;

  String? get thumbnail => _thumbnail;

  String? get poster => _poster;

  bool? get isMovie => _isMovie;

  int? get myRate => _myRate;

  int? get totalComments => _totalComments;

  bool? get isPremium => _isPremium;

  Movie? get movie => _movie;

  Series? get series => _series;

  List<Cast>? get casts => _casts;

  List<Comment>? get comments => _comments;

  double? get rate => _rate;

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

  String get countriesName {
    String s = "";
    for (int i = 0; i < (countries?.length ?? 0); i++) {
      if (i + 1 == (countries?.length ?? 0)) {
        s += (countries![i].name ?? "");
      } else {
        s += "${countries![i].name ?? ""} | ";
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
}

enum MediaValue {
  free(persianTitle: "رایگان", serverNameSpace: "Free"),
  advertising(persianTitle: "تبلیغاتی", serverNameSpace: "Advertising"),
  subscription(persianTitle: "اشتراکی", serverNameSpace: "Subscription");

  final String persianTitle;
  final String serverNameSpace;

  const MediaValue({required this.persianTitle, required this.serverNameSpace});
}
