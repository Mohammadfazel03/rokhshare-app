class Comment {
  Comment({
    String? title,
    String? comment,
    User? user,
    String? createdAt,
  }) {
    _title = title;
    _comment = comment;
    _user = user;
    _createdAt = createdAt;
  }

  Comment.fromJson(dynamic json) {
    _title = json['title'];
    _comment = json['comment'];
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
    _createdAt = json['created_at'];
  }

  String? _title;
  String? _comment;
  User? _user;
  String? _createdAt;

  String? get title => _title;

  String? get comment => _comment;

  User? get user => _user;

  String? get createdAt => _createdAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = _title;
    map['comment'] = _comment;
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    map['created_at'] = _createdAt;
    return map;
  }
}

class User {
  User({
    int? id,
    String? fullName,
    String? username,
  }) {
    _id = id;
    _fullName = fullName;
    _username = username;
  }

  User.fromJson(dynamic json) {
    _id = json['id'];
    _fullName = json['full_name'];
    _username = json['username'];
  }

  int? _id;
  String? _fullName;
  String? _username;

  int? get id => _id;

  String? get fullName => _fullName;

  String? get username => _username;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['full_name'] = _fullName;
    map['username'] = _username;
    return map;
  }
}
