class PaginationScreenDl {
  PaginationScreenDl({
    List<Users>? users,
    int? total,
    int? skip,
    int? limit,
  }) {
    _users = users;
    _total = total;
    _skip = skip;
    _limit = limit;
  }

  PaginationScreenDl.fromJson(dynamic json) {
    if (json['users'] != null) {
      _users = [];
      json['users'].forEach((v) {
        _users?.add(Users.fromJson(v));
      });
    }
    _total = json['total'];
    _skip = json['skip'];
    _limit = json['limit'];
  }
  List<Users>? _users;
  int? _total;
  int? _skip;
  int? _limit;

  List<Users>? get users => _users;
  int? get total => _total;
  int? get skip => _skip;
  int? get limit => _limit;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_users != null) {
      map['users'] = _users?.map((v) => v.toJson()).toList();
    }
    map['total'] = _total;
    map['skip'] = _skip;
    map['limit'] = _limit;
    return map;
  }
}

class Users {
  Users({
    int? id,
    String? firstName,
    String? lastName,
    String? maidenName,
    int? age,
    String? gender,
    String? email,
    String? phone,
    String? username,
    String? password,
    String? birthDate,
    String? image,
    String? bloodGroup,
    double? height,
    double? weight,
    String? eyeColor,
    Hair? hair,
    String? ip,
    Address? address,
    String? macAddress,
    String? university,
    Bank? bank,
    Company? company,
    String? ein,
    String? ssn,
    String? userAgent,
    Crypto? crypto,
    String? role,
  }) {
    _id = id;
    _firstName = firstName;
    _lastName = lastName;
    _maidenName = maidenName;
    _age = age;
    _gender = gender;
    _email = email;
    _phone = phone;
    _username = username;
    _password = password;
    _birthDate = birthDate;
    _image = image;
    _bloodGroup = bloodGroup;
    _height = height;
    _weight = weight;
    _eyeColor = eyeColor;
    _hair = hair;
    _ip = ip;
    _address = address;
    _macAddress = macAddress;
    _university = university;
    _bank = bank;
    _company = company;
    _ein = ein;
    _ssn = ssn;
    _userAgent = userAgent;
    _crypto = crypto;
    _role = role;
  }

  Users.fromJson(dynamic json) {
    _id = json['id'];
    _firstName = json['firstName'];
    _lastName = json['lastName'];
    _maidenName = json['maidenName'];
    _age = json['age'];
    _gender = json['gender'];
    _email = json['email'];
    _phone = json['phone'];
    _username = json['username'];
    _password = json['password'];
    _birthDate = json['birthDate'];
    _image = json['image'];
    _bloodGroup = json['bloodGroup'];
    _height = json['height'];
    _weight = json['weight'];
    _eyeColor = json['eyeColor'];
    _hair = json['hair'] != null ? Hair.fromJson(json['hair']) : null;
    _ip = json['ip'];
    _address = json['address'] != null ? Address.fromJson(json['address']) : null;
    _macAddress = json['macAddress'];
    _university = json['university'];
    _bank = json['bank'] != null ? Bank.fromJson(json['bank']) : null;
    _company = json['company'] != null ? Company.fromJson(json['company']) : null;
    _ein = json['ein'];
    _ssn = json['ssn'];
    _userAgent = json['userAgent'];
    _crypto = json['crypto'] != null ? Crypto.fromJson(json['crypto']) : null;
    _role = json['role'];
  }
  int? _id;
  String? _firstName;
  String? _lastName;
  String? _maidenName;
  int? _age;
  String? _gender;
  String? _email;
  String? _phone;
  String? _username;
  String? _password;
  String? _birthDate;
  String? _image;
  String? _bloodGroup;
  double? _height;
  double? _weight;
  String? _eyeColor;
  Hair? _hair;
  String? _ip;
  Address? _address;
  String? _macAddress;
  String? _university;
  Bank? _bank;
  Company? _company;
  String? _ein;
  String? _ssn;
  String? _userAgent;
  Crypto? _crypto;
  String? _role;

  int? get id => _id;
  String? get firstName => _firstName;
  String? get lastName => _lastName;
  String? get maidenName => _maidenName;
  int? get age => _age;
  String? get gender => _gender;
  String? get email => _email;
  String? get phone => _phone;
  String? get username => _username;
  String? get password => _password;
  String? get birthDate => _birthDate;
  String? get image => _image;
  String? get bloodGroup => _bloodGroup;
  double? get height => _height;
  double? get weight => _weight;
  String? get eyeColor => _eyeColor;
  Hair? get hair => _hair;
  String? get ip => _ip;
  Address? get address => _address;
  String? get macAddress => _macAddress;
  String? get university => _university;
  Bank? get bank => _bank;
  Company? get company => _company;
  String? get ein => _ein;
  String? get ssn => _ssn;
  String? get userAgent => _userAgent;
  Crypto? get crypto => _crypto;
  String? get role => _role;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['firstName'] = _firstName;
    map['lastName'] = _lastName;
    map['maidenName'] = _maidenName;
    map['age'] = _age;
    map['gender'] = _gender;
    map['email'] = _email;
    map['phone'] = _phone;
    map['username'] = _username;
    map['password'] = _password;
    map['birthDate'] = _birthDate;
    map['image'] = _image;
    map['bloodGroup'] = _bloodGroup;
    map['height'] = _height;
    map['weight'] = _weight;
    map['eyeColor'] = _eyeColor;
    if (_hair != null) {
      map['hair'] = _hair?.toJson();
    }
    map['ip'] = _ip;
    if (_address != null) {
      map['address'] = _address?.toJson();
    }
    map['macAddress'] = _macAddress;
    map['university'] = _university;
    if (_bank != null) {
      map['bank'] = _bank?.toJson();
    }
    if (_company != null) {
      map['company'] = _company?.toJson();
    }
    map['ein'] = _ein;
    map['ssn'] = _ssn;
    map['userAgent'] = _userAgent;
    if (_crypto != null) {
      map['crypto'] = _crypto?.toJson();
    }
    map['role'] = _role;
    return map;
  }
}

class Crypto {
  Crypto({
    String? coin,
    String? wallet,
    String? network,
  }) {
    _coin = coin;
    _wallet = wallet;
    _network = network;
  }

  Crypto.fromJson(dynamic json) {
    _coin = json['coin'];
    _wallet = json['wallet'];
    _network = json['network'];
  }
  String? _coin;
  String? _wallet;
  String? _network;

  String? get coin => _coin;
  String? get wallet => _wallet;
  String? get network => _network;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['coin'] = _coin;
    map['wallet'] = _wallet;
    map['network'] = _network;
    return map;
  }
}

class Company {
  Company({
    String? department,
    String? name,
    String? title,
    Address? address,
  }) {
    _department = department;
    _name = name;
    _title = title;
    _address = address;
  }

  Company.fromJson(dynamic json) {
    _department = json['department'];
    _name = json['name'];
    _title = json['title'];
    _address = json['address'] != null ? Address.fromJson(json['address']) : null;
  }
  String? _department;
  String? _name;
  String? _title;
  Address? _address;

  String? get department => _department;
  String? get name => _name;
  String? get title => _title;
  Address? get address => _address;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['department'] = _department;
    map['name'] = _name;
    map['title'] = _title;
    if (_address != null) {
      map['address'] = _address?.toJson();
    }
    return map;
  }
}

class Address {
  Address({
    String? address,
    String? city,
    String? state,
    String? stateCode,
    String? postalCode,
    Coordinates? coordinates,
    String? country,
  }) {
    _address = address;
    _city = city;
    _state = state;
    _stateCode = stateCode;
    _postalCode = postalCode;
    _coordinates = coordinates;
    _country = country;
  }

  Address.fromJson(dynamic json) {
    _address = json['address'];
    _city = json['city'];
    _state = json['state'];
    _stateCode = json['stateCode'];
    _postalCode = json['postalCode'];
    _coordinates = json['coordinates'] != null ? Coordinates.fromJson(json['coordinates']) : null;
    _country = json['country'];
  }
  String? _address;
  String? _city;
  String? _state;
  String? _stateCode;
  String? _postalCode;
  Coordinates? _coordinates;
  String? _country;

  String? get address => _address;
  String? get city => _city;
  String? get state => _state;
  String? get stateCode => _stateCode;
  String? get postalCode => _postalCode;
  Coordinates? get coordinates => _coordinates;
  String? get country => _country;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['address'] = _address;
    map['city'] = _city;
    map['state'] = _state;
    map['stateCode'] = _stateCode;
    map['postalCode'] = _postalCode;
    if (_coordinates != null) {
      map['coordinates'] = _coordinates?.toJson();
    }
    map['country'] = _country;
    return map;
  }
}

class Coordinates {
  Coordinates({
    double? lat,
    double? lng,
  }) {
    _lat = lat;
    _lng = lng;
  }

  Coordinates.fromJson(dynamic json) {
    _lat = json['lat'];
    _lng = json['lng'];
  }
  double? _lat;
  double? _lng;

  double? get lat => _lat;
  double? get lng => _lng;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['lat'] = _lat;
    map['lng'] = _lng;
    return map;
  }
}

class Bank {
  Bank({
    String? cardExpire,
    String? cardNumber,
    String? cardType,
    String? currency,
    String? iban,
  }) {
    _cardExpire = cardExpire;
    _cardNumber = cardNumber;
    _cardType = cardType;
    _currency = currency;
    _iban = iban;
  }

  Bank.fromJson(dynamic json) {
    _cardExpire = json['cardExpire'];
    _cardNumber = json['cardNumber'];
    _cardType = json['cardType'];
    _currency = json['currency'];
    _iban = json['iban'];
  }
  String? _cardExpire;
  String? _cardNumber;
  String? _cardType;
  String? _currency;
  String? _iban;

  String? get cardExpire => _cardExpire;
  String? get cardNumber => _cardNumber;
  String? get cardType => _cardType;
  String? get currency => _currency;
  String? get iban => _iban;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['cardExpire'] = _cardExpire;
    map['cardNumber'] = _cardNumber;
    map['cardType'] = _cardType;
    map['currency'] = _currency;
    map['iban'] = _iban;
    return map;
  }
}

class Hair {
  Hair({
    String? color,
    String? type,
  }) {
    _color = color;
    _type = type;
  }

  Hair.fromJson(dynamic json) {
    _color = json['color'];
    _type = json['type'];
  }
  String? _color;
  String? _type;

  String? get color => _color;
  String? get type => _type;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['color'] = _color;
    map['type'] = _type;
    return map;
  }
}
