class LoginState{}

class LoginInitialState extends LoginState{}

class LoginSuccessState extends LoginState {
  final String userName;
  final String token;
  LoginSuccessState({
    required  this.token,
    required  this.userName,
  });
}


class LoginLoadingState extends LoginState{}

class LoginErrorState extends LoginState{
  String errorMessage;
  LoginErrorState({
    required this.errorMessage
  });
}


