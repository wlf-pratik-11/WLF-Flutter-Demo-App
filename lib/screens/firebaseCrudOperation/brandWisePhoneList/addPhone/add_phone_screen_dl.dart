class AddPhoneScreenDl {
  AddPhoneScreenDl({
    String? phoneName,
    String? price,
    String? description,
    String? imgUrl,
  }) {
    _phoneName = phoneName;
    _price = price;
    _description = description;
    _imgUrl = imgUrl;
  }

  AddPhoneScreenDl.fromJson(dynamic json) {
    _phoneName = json['phoneName'];
    _price = json['price'];
    _description = json['description'];
    _imgUrl = json['imgUrl'];
  }
  String? _phoneName;
  String? _price;
  String? _description;
  String? _imgUrl;

  String? get phoneName => _phoneName;
  String? get price => _price;
  String? get description => _description;
  String? get imgUrl => _imgUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['phoneName'] = _phoneName;
    map['price'] = _price;
    map['description'] = _description;
    map['imgUrl'] = _imgUrl;
    return map;
  }
}
