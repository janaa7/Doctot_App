class ProfileResponse {
  final String? message;
  final ProfileModel? data;
  final bool? status;
  final int? code;

  ProfileResponse({
    this.message,
    this.data,
    this.status,
    this.code,
  });

  factory ProfileResponse.fromJson(Map<String, dynamic> json) {
    return ProfileResponse(
      message: json['message'] as String?,
      data: json['data'] == null || (json['data'] as List).isEmpty
          ? null
          : ProfileModel.fromJson(json['data'][0] as Map<String, dynamic>),
      status: json['status'] as bool?,
      code: (json['code'] as num?)?.toInt(),
    );
  }
}

class ProfileModel {
  final int? id;
  final String? name;
  final String? email;
  final String? phone;
  final String? gender;

  ProfileModel({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.gender,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      gender: json['gender'] as String?,
    );
  }
}