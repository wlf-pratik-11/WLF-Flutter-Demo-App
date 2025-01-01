class ApiCallScreenDl {
  ApiCallScreenDl({
    String? name,
    String? bDate,
    String? city,
    String? mobileNum,
    String? email,
    String? address,
    String? image,
    String? id,
  }) {
    _name = name;
    _bDate = bDate;
    _city = city;
    _mobileNum = mobileNum;
    _email = email;
    _address = address;
    _image = image;
    _id = id;
  }

  ApiCallScreenDl.fromJson(dynamic json) {
    _name = json['name'];
    _bDate = json['bDate'];
    _city = json['city'];
    _mobileNum = json['mobileNum'];
    _email = json['email'];
    _address = json['address'];
    _image = json['image'];
    _id = json['id'];
  }

  String? _name;
  String? _bDate;
  String? _city;
  String? _mobileNum;
  String? _email;
  String? _address;
  String? _image;
  String? _id;

  String? get name => _name;

  String? get bDate => _bDate;

  String? get city => _city;

  String? get mobileNum => _mobileNum;

  String? get email => _email;

  String? get address => _address;

  String? get image => _image;

  String? get id => _id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['bDate'] = _bDate;
    map['city'] = _city;
    map['mobileNum'] = _mobileNum;
    map['email'] = _email;
    map['address'] = _address;
    map['image'] = _image;
    map['id'] = _id;
    return map;
  }
}
