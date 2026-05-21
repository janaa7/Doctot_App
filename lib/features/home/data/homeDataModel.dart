
class HomeDataModel {
  String? message;
  List<Data>? data;
  bool? status;
  int? code;

  HomeDataModel({this.message, this.data, this.status, this.code});

  HomeDataModel.fromJson(Map<String, dynamic> json) {
    message = json["message"];
    data = json["data"] == null ? null : (json["data"] as List).map((e) => Data.fromJson(e)).toList();
    status = json["status"];
    code = json["code"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["message"] = message;
    if(data != null) {
      _data["data"] = data?.map((e) => e.toJson()).toList();
    }
    _data["status"] = status;
    _data["code"] = code;
    return _data;
  }
}

class Data {
  int? id;
  String? name;
  List<Doctors>? doctors;

  Data({this.id, this.name, this.doctors});

  Data.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    doctors = json["doctors"] == null ? null : (json["doctors"] as List).map((e) => Doctors.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["name"] = name;
    if(doctors != null) {
      _data["doctors"] = doctors?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class Doctors {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? photo;
  String? gender;
  String? address;
  String? description;
  String? degree;
  Specialization? specialization;
  City? city;
  int? appointPrice;
  String? startTime;
  String? endTime;

  Doctors({this.id, this.name, this.email, this.phone, this.photo, this.gender, this.address, this.description, this.degree, this.specialization, this.city, this.appointPrice, this.startTime, this.endTime});

  Doctors.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    email = json["email"];
    phone = json["phone"];
    photo = json["photo"];
    gender = json["gender"];
    address = json["address"];
    description = json["description"];
    degree = json["degree"];
    specialization = json["specialization"] == null ? null : Specialization.fromJson(json["specialization"]);
    city = json["city"] == null ? null : City.fromJson(json["city"]);
    appointPrice = json["appoint_price"];
    startTime = json["start_time"];
    endTime = json["end_time"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["name"] = name;
    _data["email"] = email;
    _data["phone"] = phone;
    _data["photo"] = photo;
    _data["gender"] = gender;
    _data["address"] = address;
    _data["description"] = description;
    _data["degree"] = degree;
    if(specialization != null) {
      _data["specialization"] = specialization?.toJson();
    }
    if(city != null) {
      _data["city"] = city?.toJson();
    }
    _data["appoint_price"] = appointPrice;
    _data["start_time"] = startTime;
    _data["end_time"] = endTime;
    return _data;
  }
}

class City {
  int? id;
  String? name;
  Governrate? governrate;

  City({this.id, this.name, this.governrate});

  City.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    governrate = json["governrate"] == null ? null : Governrate.fromJson(json["governrate"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["name"] = name;
    if(governrate != null) {
      _data["governrate"] = governrate?.toJson();
    }
    return _data;
  }
}

class Governrate {
  int? id;
  String? name;

  Governrate({this.id, this.name});

  Governrate.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["name"] = name;
    return _data;
  }
}

class Specialization {
  int? id;
  String? name;

  Specialization({this.id, this.name});

  Specialization.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["name"] = name;
    return _data;
  }
}