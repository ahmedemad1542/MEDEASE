import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:medease1/core/routing/app_routes.dart';
import 'package:medease1/core/storage/storage_helper.dart';
import 'package:medease1/core/storage/storage_keys.dart';
import 'package:medease1/core/styles/app_text_style.dart';
import 'package:medease1/features/login/cubit/login_cubit.dart';
import 'package:medease1/features/login/cubit/login_state.dart';
import 'package:medease1/generated/l10n.dart';
import 'package:medease1/widgets/snack_bar_widget.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).login, style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xFF0548B1),
      ),
      body: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) async {
          // -------------------------------------------------------------------------------------------------------------------------
          if (state is LoginError) {
            showAnimatedSnackBar(
              context,
              title: "Error",
              message: state.message,
              type: AnimatedSnackBarType.error,
            );
          }
          // -------------------------------------------------------------------------------------------------------------------------
          else if (state is LoginSuccess) {
            showAnimatedSnackBar(
              context,
              title: "Success",
              message: "successfully logged in",

              type: AnimatedSnackBarType.success,
            );
            await StorageHelper().saveData(
              key: StorageKeys.isFirstTime,
              value: 'false',
            );
            context.pushReplacementNamed(AppRoutes.homeScreen);
          }
        },
        builder: (context, state) {
          return Form(
            key: context.read<LoginCubit>().formKey,
            child: Padding(
              padding: EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        S.of(context).welcomeBack,
                        style: AppTextStyle.textStyle,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Center(
                      child: Text(
                        S.of(context).happyToSeeYou,
                        style: TextStyle(fontSize: 16.sp, color: Colors.grey),
                      ),
                    ),
                    SizedBox(height: 40.h),
                    TextFormField(
                      validator:
                          (value) => value!.isEmpty ? 'Enter your email' : null,
                      controller: context.read<LoginCubit>().emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: S.of(context).email,
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    TextFormField(
                      validator:
                          (value) =>
                              value!.isEmpty ? 'Enter your password' : null,
                      controller: context.read<LoginCubit>().passwordController,
                      obscureText: context.read<LoginCubit>().isObscure,
                      decoration: InputDecoration(
                        labelText: S.of(context).password,
                        border: OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: Icon(
                            context.read<LoginCubit>().isObscure
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () {
                            context.read<LoginCubit>().toggleObscure();
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    state is LoginLoading
                        ? Center(child: CircularProgressIndicator())
                        : Center(
                          child: ElevatedButton(
                            onPressed: () {
                              context.read<LoginCubit>().submit();
                              // if (context
                              //     .read<LoginCubit>()
                              //     .formKey
                              //     .currentState!
                              //     .validate()) {
                              //   context.read<LoginCubit>().login(
                              //     email:
                              //         context
                              //             .read<LoginCubit>()
                              //             .emailController
                              //             .text,
                              //     password:
                              //         context
                              //             .read<LoginCubit>()
                              //             .passwordController
                              //             .text,
                              //   );
                            },
                            child: Text(S.of(context).login),
                          ),
                        ),
                    SizedBox(height: 20.h),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account? ",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.sp,
                            ),
                          ),
                          InkWell(
                            onTap:
                                () => context.pushReplacementNamed(
                                  AppRoutes.registerScreen,
                                ),
                            child: Text(
                              "Sign Up",
                              style: TextStyle(
                                color: Color(0xFF2F4EFF),
                                fontWeight: FontWeight.bold,
                                fontSize: 16.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
