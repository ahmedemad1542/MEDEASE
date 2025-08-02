import 'package:medease1/features/login/model/login_response_model.dart';

abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final LoginResponseModel loginResponseModel;

  LoginSuccess(this.loginResponseModel);
}

class LoginError extends LoginState {
  final String message;
  LoginError(this.message);
}

class LoginObscureState extends LoginState {
  final bool isObscure;

  LoginObscureState(this.isObscure);
}
