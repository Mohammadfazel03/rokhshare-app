class SubscriptionPlan {
  SubscriptionPlan({
      int? id, 
      Payment? payment, 
      String? createdAt, 
      String? endDate, 
      String? titlePlan, 
      String? descriptionPlan, 
      int? daysPlan, 
      int? pricePlan,}){
    _id = id;
    _payment = payment;
    _createdAt = createdAt;
    _endDate = endDate;
    _titlePlan = titlePlan;
    _descriptionPlan = descriptionPlan;
    _daysPlan = daysPlan;
    _pricePlan = pricePlan;
}

  SubscriptionPlan.fromJson(dynamic json) {
    _id = json['id'];
    _payment = json['payment'] != null ? Payment.fromJson(json['payment']) : null;
    _createdAt = json['created_at'];
    _endDate = json['end_date'];
    _titlePlan = json['title_plan'];
    _descriptionPlan = json['description_plan'];
    _daysPlan = json['days_plan'];
    _pricePlan = json['price_plan'];
  }
  int? _id;
  Payment? _payment;
  String? _createdAt;
  String? _endDate;
  String? _titlePlan;
  String? _descriptionPlan;
  int? _daysPlan;
  int? _pricePlan;

  int? get id => _id;
  Payment? get payment => _payment;
  String? get createdAt => _createdAt;
  String? get endDate => _endDate;
  String? get titlePlan => _titlePlan;
  String? get descriptionPlan => _descriptionPlan;
  int? get daysPlan => _daysPlan;
  int? get pricePlan => _pricePlan;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    if (_payment != null) {
      map['payment'] = _payment?.toJson();
    }
    map['created_at'] = _createdAt;
    map['end_date'] = _endDate;
    map['title_plan'] = _titlePlan;
    map['description_plan'] = _descriptionPlan;
    map['days_plan'] = _daysPlan;
    map['price_plan'] = _pricePlan;
    return map;
  }

}

class Payment {
  Payment({
      int? id, 
      int? price, 
      int? trackingCode, 
      int? receiptNumber,}){
    _id = id;
    _price = price;
    _trackingCode = trackingCode;
    _receiptNumber = receiptNumber;
}

  Payment.fromJson(dynamic json) {
    _id = json['id'];
    _price = json['price'];
    _trackingCode = json['tracking_code'];
    _receiptNumber = json['receipt_number'];
  }
  int? _id;
  int? _price;
  int? _trackingCode;
  int? _receiptNumber;

  int? get id => _id;
  int? get price => _price;
  int? get trackingCode => _trackingCode;
  int? get receiptNumber => _receiptNumber;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['price'] = _price;
    map['tracking_code'] = _trackingCode;
    map['receipt_number'] = _receiptNumber;
    return map;
  }

}