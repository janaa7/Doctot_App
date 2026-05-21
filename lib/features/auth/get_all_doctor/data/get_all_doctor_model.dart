

class DoctorResponse {
  final String? message;
  final List<Doctor> data;
  final bool? status;
  final int? code;

  DoctorResponse({
    required this.message,
    required this.data,
    required this.status,
    required this.code,
  });

  factory DoctorResponse.fromJson(Map<String, dynamic> json) {
    return DoctorResponse(
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>? ?? [])
          .map((e) => Doctor.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: json['status'] as bool?,
      code: (json['code'] as num?)?.toInt(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'data': data.map((e) => e.toJson()).toList(),
      'status': status,
      'code': code,
    };
  }
}

class Doctor {
  final int? id;
  final String? name;
  final String? email;
  final String? phone;
  final String? photo;
  final String? gender;
  final String? address;
  final String? description;
  final String? degree;
  final Specialization? specialization;
  final City? city;
  final int? appointPrice;
  final String? startTime;
  final String? endTime;

  Doctor({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.photo,
    this.gender,
    this.address,
    this.description,
    this.degree,
    this.specialization,
    this.city,
    this.appointPrice,
    this.startTime,
    this.endTime,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      photo: json['photo'] as String?,
      gender: json['gender'] as String?,
      address: json['address'] as String?,
      description: json['description'] as String?,
      degree: json['degree'] as String?,
      specialization: json['specialization'] == null
          ? null
          : Specialization.fromJson(
        json['specialization'] as Map<String, dynamic>,
      ),
      city: json['city'] == null
          ? null
          : City.fromJson(json['city'] as Map<String, dynamic>),
      appointPrice: (json['appoint_price'] as num?)?.toInt(),
      startTime: json['start_time'] as String?,
      endTime: json['end_time'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'photo': photo,
      'gender': gender,
      'address': address,
      'description': description,
      'degree': degree,
      'specialization': specialization?.toJson(),
      'city': city?.toJson(),
      'appoint_price': appointPrice,
      'start_time': startTime,
      'end_time': endTime,
    };
  }
}

class Specialization {
  final int? id;
  final String? name;

  Specialization({this.id, this.name});

  factory Specialization.fromJson(Map<String, dynamic> json) {
    return Specialization(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {'id': id, 'name': name};
}

class City {
  final int? id;
  final String? name;
  final Governrate? governrate;

  City({this.id, this.name, this.governrate});

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      governrate: json['governrate'] == null
          ? null
          : Governrate.fromJson(json['governrate'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'governrate': governrate?.toJson(),
  };
}

class Governrate {
  final int? id;
  final String? name;

  Governrate({this.id, this.name});

  factory Governrate.fromJson(Map<String, dynamic> json) {
    return Governrate(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {'id': id, 'name': name};
}