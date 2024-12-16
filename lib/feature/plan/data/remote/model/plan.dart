class Plan {
  Plan({
      int? id, 
      String? title, 
      String? description, 
      int? days, 
      int? price, 
      bool? isEnable,}){
    _id = id;
    _title = title;
    _description = description;
    _days = days;
    _price = price;
    _isEnable = isEnable;
}

  Plan.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
    _description = json['description'];
    _days = json['days'];
    _price = json['price'];
    _isEnable = json['is_enable'];
  }
  int? _id;
  String? _title;
  String? _description;
  int? _days;
  int? _price;
  bool? _isEnable;

  int? get id => _id;
  String? get title => _title;
  String? get description => _description;
  int? get days => _days;
  int? get price => _price;
  bool? get isEnable => _isEnable;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    map['description'] = _description;
    map['days'] = _days;
    map['price'] = _price;
    map['is_enable'] = _isEnable;
    return map;
  }

}