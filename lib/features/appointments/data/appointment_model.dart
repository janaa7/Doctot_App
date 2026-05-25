class AppointmentResponse {
  final String? message;
  final List<AppointmentModel> data;
  final bool? status;
  final int? code;

  AppointmentResponse({
    this.message,
    required this.data,
    this.status,
    this.code,
  });

  factory AppointmentResponse.fromJson(Map<String, dynamic> json) {
    return AppointmentResponse(
      message: json['message'],
      data: (json['data'] as List)
          .map((e) => AppointmentModel.fromJson(e))
          .toList(),
      status: json['status'],
      code: json['code'],
    );
  }
}

class AppointmentModel {
  final int? id;
  final AppointmentDoctor? doctor;
  final AppointmentPatient? patient;
  final String? appointmentTime;
  final String? appointmentEndTime;
  final String? status;
  final String? notes;
  final int? appointmentPrice;

  AppointmentModel({
    this.id,
    this.doctor,
    this.patient,
    this.appointmentTime,
    this.appointmentEndTime,
    this.status,
    this.notes,
    this.appointmentPrice,
  });

  factory AppointmentModel.fromJson(Map<String, dynamic> json) {
    return AppointmentModel(
      id: json['id'],
      doctor: json['doctor'] != null
          ? AppointmentDoctor.fromJson(json['doctor'])
          : null,
      patient: json['patient'] != null
          ? AppointmentPatient.fromJson(json['patient'])
          : null,
      appointmentTime: json['appointment_time'],
      appointmentEndTime: json['appointment_end_time'],
      status: json['status'],
      notes: json['notes'],
      appointmentPrice: json['appointment_price'],
    );
  }
}

class AppointmentDoctor {
  final int? id;
  final String? name;
  final String? email;
  final String? phone;
  final String? photo;
  final String? gender;
  final String? address;
  final String? description;
  final String? degree;
  final DoctorSpecialization? specialization;
  final int? appointPrice;
  final String? startTime;
  final String? endTime;

  AppointmentDoctor({
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
    this.appointPrice,
    this.startTime,
    this.endTime,
  });

  factory AppointmentDoctor.fromJson(Map<String, dynamic> json) {
    return AppointmentDoctor(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      photo: json['photo'],
      gender: json['gender'],
      address: json['address'],
      description: json['description'],
      degree: json['degree'],
      specialization: json['specialization'] != null
          ? DoctorSpecialization.fromJson(json['specialization'])
          : null,
      appointPrice: json['appoint_price'],
      startTime: json['start_time'],
      endTime: json['end_time'],
    );
  }
}

class DoctorSpecialization {
  final int? id;
  final String? name;

  DoctorSpecialization({
    this.id,
    this.name,
  });

  factory DoctorSpecialization.fromJson(Map<String, dynamic> json) {
    return DoctorSpecialization(
      id: json['id'],
      name: json['name'],
    );
  }
}

class AppointmentPatient {
  final int? id;
  final String? name;
  final String? email;
  final String? phone;
  final String? gender;

  AppointmentPatient({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.gender,
  });

  factory AppointmentPatient.fromJson(Map<String, dynamic> json) {
    return AppointmentPatient(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      gender: json['gender'],
    );
  }
}