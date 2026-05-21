class RegisterState{}

class RegisterInitialState extends  RegisterState{}

class RegisterLoadingState extends  RegisterState{}

class RegisterSuccessState extends  RegisterState{
  final String userName;

  final String token;
  RegisterSuccessState({
    required this.token,
    required this.userName
});

}

class RegisterErrorState extends  RegisterState{
  String errorMessage;
  RegisterErrorState({
    required this.errorMessage
});
}
