/// predictions : [{"description":"Rajkot, Gujarat, India","matched_substrings":[{"length":4,"offset":0}],"place_id":"ChIJD98cx4rJWTkRO62Tvs8V3XY","reference":"ChIJD98cx4rJWTkRO62Tvs8V3XY","structured_formatting":{"main_text":"Rajkot","main_text_matched_substrings":[{"length":4,"offset":0}],"secondary_text":"Gujarat, India"},"terms":[{"offset":0,"value":"Rajkot"},{"offset":8,"value":"Gujarat"},{"offset":17,"value":"India"}],"types":["political","geocode","locality"]},{"description":"Rajkot International Airport, Hirasar, Garida, Gujarat, India","matched_substrings":[{"length":4,"offset":0}],"place_id":"ChIJIauMHCCvWTkR0-Ub7IUuUP4","reference":"ChIJIauMHCCvWTkR0-Ub7IUuUP4","structured_formatting":{"main_text":"Rajkot International Airport","main_text_matched_substrings":[{"length":4,"offset":0}],"secondary_text":"Hirasar, Garida, Gujarat, India"},"terms":[{"offset":0,"value":"Rajkot International Airport"},{"offset":30,"value":"Hirasar"},{"offset":39,"value":"Garida"},{"offset":47,"value":"Gujarat"},{"offset":56,"value":"India"}],"types":["point_of_interest","establishment","airport"]},{"description":"Rajka, Hungary","matched_substrings":[{"length":4,"offset":0}],"place_id":"ChIJjxgazIl7bEcRQDceDCnEAAQ","reference":"ChIJjxgazIl7bEcRQDceDCnEAAQ","structured_formatting":{"main_text":"Rajka","main_text_matched_substrings":[{"length":4,"offset":0}],"secondary_text":"Hungary"},"terms":[{"offset":0,"value":"Rajka"},{"offset":7,"value":"Hungary"}],"types":["locality","political","geocode"]},{"description":"Rajkot Central Bus Station - Bus port, Dhebar Road, Raghuveer Para, Lohana Para, Rajkot, Gujarat, India","matched_substrings":[{"length":4,"offset":0}],"place_id":"ChIJzS4DKRvKWTkRrICQUeVeY1g","reference":"ChIJzS4DKRvKWTkRrICQUeVeY1g","structured_formatting":{"main_text":"Rajkot Central Bus Station - Bus port","main_text_matched_substrings":[{"length":4,"offset":0}],"secondary_text":"Dhebar Road, Raghuveer Para, Lohana Para, Rajkot, Gujarat, India"},"terms":[{"offset":0,"value":"Rajkot Central Bus Station - Bus port"},{"offset":39,"value":"Dhebar Road"},{"offset":52,"value":"Raghuveer Para"},{"offset":68,"value":"Lohana Para"},{"offset":81,"value":"Rajkot"},{"offset":89,"value":"Gujarat"},{"offset":98,"value":"India"}],"types":["point_of_interest","establishment"]},{"description":"Rajkot Bus stand, Bhavnagar Road, Vardhman Industrial Area, Ram Nagar, Aji Industrial Estate, Rajkot, Gujarat, India","matched_substrings":[{"length":4,"offset":0}],"place_id":"ChIJZSS39Ju1WTkRjKN71TEtfTE","reference":"ChIJZSS39Ju1WTkRjKN71TEtfTE","structured_formatting":{"main_text":"Rajkot Bus stand","main_text_matched_substrings":[{"length":4,"offset":0}],"secondary_text":"Bhavnagar Road, Vardhman Industrial Area, Ram Nagar, Aji Industrial Estate, Rajkot, Gujarat, India"},"terms":[{"offset":0,"value":"Rajkot Bus stand"},{"offset":18,"value":"Bhavnagar Road"},{"offset":34,"value":"Vardhman Industrial Area"},{"offset":60,"value":"Ram Nagar"},{"offset":71,"value":"Aji Industrial Estate"},{"offset":94,"value":"Rajkot"},{"offset":102,"value":"Gujarat"},{"offset":111,"value":"India"}],"types":["establishment","point_of_interest"]}]
/// status : "OK"

class LocationSuggetionDl {
  LocationSuggetionDl({
    List<Predictions>? predictions,
    String? status,
  }) {
    _predictions = predictions;
    _status = status;
  }

  LocationSuggetionDl.fromJson(dynamic json) {
    if (json['predictions'] != null) {
      _predictions = [];
      json['predictions'].forEach((v) {
        _predictions?.add(Predictions.fromJson(v));
      });
    }
    _status = json['status'];
  }
  List<Predictions>? _predictions;
  String? _status;

  List<Predictions>? get predictions => _predictions;
  String? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_predictions != null) {
      map['predictions'] = _predictions?.map((v) => v.toJson()).toList();
    }
    map['status'] = _status;
    return map;
  }
}

/// description : "Rajkot, Gujarat, India"
/// matched_substrings : [{"length":4,"offset":0}]
/// place_id : "ChIJD98cx4rJWTkRO62Tvs8V3XY"
/// reference : "ChIJD98cx4rJWTkRO62Tvs8V3XY"
/// structured_formatting : {"main_text":"Rajkot","main_text_matched_substrings":[{"length":4,"offset":0}],"secondary_text":"Gujarat, India"}
/// terms : [{"offset":0,"value":"Rajkot"},{"offset":8,"value":"Gujarat"},{"offset":17,"value":"India"}]
/// types : ["political","geocode","locality"]

class Predictions {
  Predictions({
    String? description,
    List<MatchedSubstrings>? matchedSubstrings,
    String? placeId,
    String? reference,
    StructuredFormatting? structuredFormatting,
    List<Terms>? terms,
    List<String>? types,
  }) {
    _description = description;
    _matchedSubstrings = matchedSubstrings;
    _placeId = placeId;
    _reference = reference;
    _structuredFormatting = structuredFormatting;
    _terms = terms;
    _types = types;
  }

  Predictions.fromJson(dynamic json) {
    _description = json['description'];
    if (json['matched_substrings'] != null) {
      _matchedSubstrings = [];
      json['matched_substrings'].forEach((v) {
        _matchedSubstrings?.add(MatchedSubstrings.fromJson(v));
      });
    }
    _placeId = json['place_id'];
    _reference = json['reference'];
    _structuredFormatting =
        json['structured_formatting'] != null ? StructuredFormatting.fromJson(json['structured_formatting']) : null;
    if (json['terms'] != null) {
      _terms = [];
      json['terms'].forEach((v) {
        _terms?.add(Terms.fromJson(v));
      });
    }
    _types = json['types'] != null ? json['types'].cast<String>() : [];
  }
  String? _description;
  List<MatchedSubstrings>? _matchedSubstrings;
  String? _placeId;
  String? _reference;
  StructuredFormatting? _structuredFormatting;
  List<Terms>? _terms;
  List<String>? _types;

  String? get description => _description;
  List<MatchedSubstrings>? get matchedSubstrings => _matchedSubstrings;
  String? get placeId => _placeId;
  String? get reference => _reference;
  StructuredFormatting? get structuredFormatting => _structuredFormatting;
  List<Terms>? get terms => _terms;
  List<String>? get types => _types;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['description'] = _description;
    if (_matchedSubstrings != null) {
      map['matched_substrings'] = _matchedSubstrings?.map((v) => v.toJson()).toList();
    }
    map['place_id'] = _placeId;
    map['reference'] = _reference;
    if (_structuredFormatting != null) {
      map['structured_formatting'] = _structuredFormatting?.toJson();
    }
    if (_terms != null) {
      map['terms'] = _terms?.map((v) => v.toJson()).toList();
    }
    map['types'] = _types;
    return map;
  }
}

/// offset : 0
/// value : "Rajkot"

class Terms {
  Terms({
    int? offset,
    String? value,
  }) {
    _offset = offset;
    _value = value;
  }

  Terms.fromJson(dynamic json) {
    _offset = json['offset'];
    _value = json['value'];
  }
  int? _offset;
  String? _value;

  int? get offset => _offset;
  String? get value => _value;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['offset'] = _offset;
    map['value'] = _value;
    return map;
  }
}

/// main_text : "Rajkot"
/// main_text_matched_substrings : [{"length":4,"offset":0}]
/// secondary_text : "Gujarat, India"

class StructuredFormatting {
  StructuredFormatting({
    String? mainText,
    List<MainTextMatchedSubstrings>? mainTextMatchedSubstrings,
    String? secondaryText,
  }) {
    _mainText = mainText;
    _mainTextMatchedSubstrings = mainTextMatchedSubstrings;
    _secondaryText = secondaryText;
  }

  StructuredFormatting.fromJson(dynamic json) {
    _mainText = json['main_text'];
    if (json['main_text_matched_substrings'] != null) {
      _mainTextMatchedSubstrings = [];
      json['main_text_matched_substrings'].forEach((v) {
        _mainTextMatchedSubstrings?.add(MainTextMatchedSubstrings.fromJson(v));
      });
    }
    _secondaryText = json['secondary_text'];
  }
  String? _mainText;
  List<MainTextMatchedSubstrings>? _mainTextMatchedSubstrings;
  String? _secondaryText;

  String? get mainText => _mainText;
  List<MainTextMatchedSubstrings>? get mainTextMatchedSubstrings => _mainTextMatchedSubstrings;
  String? get secondaryText => _secondaryText;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['main_text'] = _mainText;
    if (_mainTextMatchedSubstrings != null) {
      map['main_text_matched_substrings'] = _mainTextMatchedSubstrings?.map((v) => v.toJson()).toList();
    }
    map['secondary_text'] = _secondaryText;
    return map;
  }
}

/// length : 4
/// offset : 0

class MainTextMatchedSubstrings {
  MainTextMatchedSubstrings({
    int? length,
    int? offset,
  }) {
    _length = length;
    _offset = offset;
  }

  MainTextMatchedSubstrings.fromJson(dynamic json) {
    _length = json['length'];
    _offset = json['offset'];
  }
  int? _length;
  int? _offset;

  int? get length => _length;
  int? get offset => _offset;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['length'] = _length;
    map['offset'] = _offset;
    return map;
  }
}

/// length : 4
/// offset : 0

class MatchedSubstrings {
  MatchedSubstrings({
    int? length,
    int? offset,
  }) {
    _length = length;
    _offset = offset;
  }

  MatchedSubstrings.fromJson(dynamic json) {
    _length = json['length'];
    _offset = json['offset'];
  }
  int? _length;
  int? _offset;

  int? get length => _length;
  int? get offset => _offset;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['length'] = _length;
    map['offset'] = _offset;
    return map;
  }
}
