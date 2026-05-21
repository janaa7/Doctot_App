class UserModel {
   String email;
   String name;
   String gender;
   String phone;
   String password;
   String passwordConfirmation;




   UserModel({
    required this.email,
    required this.name,
     required this.gender,
     required this.phone,
     required this.password,
     required this.passwordConfirmation,

  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'name': name,
      'gender': gender,
      'phone': phone,
      'password': password,
      'password_confirmation':passwordConfirmation
    };
  }
}