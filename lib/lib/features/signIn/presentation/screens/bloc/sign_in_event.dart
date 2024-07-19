abstract class LoginEvent {}

class LoginButtonPressed extends LoginEvent {
  final String email;
  final String password;

  LoginButtonPressed(this.email, this.password);
}

class LoginGetUserCredential extends LoginEvent {
  LoginGetUserCredential();
}
