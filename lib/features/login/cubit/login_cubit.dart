import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medease1/features/login/cubit/login_state.dart';
import 'package:medease1/features/login/model/login_response_model.dart';
import 'package:medease1/features/login/repo/login_repo.dart';

import '../../../core/utils/role_service.dart';
import '../../../core/utils/service_locator.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.loginRepo) : super(LoginInitial());
  final LoginRepo loginRepo;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isObscure = true;

  void toggleObscure() {
    isObscure = !isObscure;
    emit(LoginObscureState(isObscure));
  }

  void login({required String email, required String password}) async {
    emit(LoginLoading());
    final Either<String, LoginResponseModel> response = await loginRepo.login(
      email: email,
      password: password,
    );
    response.fold((error) => emit(LoginError(error)), (response) async {
      // Initialize the RoleService to load the user role from storage
      await sl<RoleService>().init();
      emit(LoginSuccess(response));
    });
  }

  void submit() {
    if (formKey.currentState?.validate() ?? false) {
      login(email: emailController.text, password: passwordController.text);
    }
  }

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    return super.close();
  }
}
