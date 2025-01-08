class Rating {
  Rating({
      int? rating, 
      int? count,}){
    _rating = rating;
    _count = count;
}

  Rating.fromJson(dynamic json) {
    _rating = json['rating'];
    _count = json['count'];
  }
  int? _rating;
  int? _count;

  int? get rating => _rating;
  int? get count => _count;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['rating'] = _rating;
    map['count'] = _count;
    return map;
  }

}