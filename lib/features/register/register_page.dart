import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:medease1/core/routing/app_routes.dart';
import 'package:medease1/features/register/cubit/register_cubit.dart';
import 'package:medease1/features/register/cubit/register_state.dart';
import 'package:medease1/features/register/model/register_model.dart';
import 'package:medease1/features/register/widgets/build_login_text.dart';
import 'package:medease1/features/register/widgets/custom_text_field.dart';
import 'package:medease1/generated/l10n.dart';
import 'package:medease1/widgets/snack_bar_widget.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  RegisterPageState createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).register)),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: BlocConsumer<RegisterCubit, RegisterState>(
            listener: (context, state) {
              if (state is RegisterError) {
                showAnimatedSnackBar(
                  context,
                  title: "Error",
                  message: state.message,
                  type: AnimatedSnackBarType.error,
                );
              }
              // ------------------------------------------------------------------------------------------------------------------------------------------------
              else if (state is RegisterSuccess) {
                showAnimatedSnackBar(
                  context,
                  title: "Success /n check your Email to Verify",
                  message: state.message,

                  type: AnimatedSnackBarType.success,
                );

                context.pushReplacement(AppRoutes.loginScreen);
              }
              // ------------------------------------------------------------------------------------------------------------------------------------------------
            },
            builder: (context, state) {
              final cubit = context.read<RegisterCubit>();
              return Form(
                key: cubit.formKey,

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      S.of(context).create_Account,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                    // Name
                    CustomTextfield(
                      controller: cubit.nameController,
                      label: S.of(context).name,
                      obscureText: false,
                      validator: (value) {
                        if (cubit.nameController.text.isEmpty) {
                          return "Please enter your name";
                        }
                        return null;
                      },
                    ),
                    // Email
                    CustomTextfield(
                      controller: cubit.emailController,
                      label: S.of(context).email,
                      obscureText: false,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your email";
                        }
                        if (!value.contains('@')) {
                          return "Please enter a valid email";
                        }
                        return null;
                      },
                    ),
                    // Password Field
                    CustomTextfield(
                      controller: cubit.passwordController,
                      label: S.of(context).password,
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your password";
                        }
                        if (value.length < 6) {
                          return "Password must be at least 6 characters";
                        }
                        return null;
                      },
                    ),
                    // Phone Field (added)
                    CustomTextfield(
                      controller: cubit.phoneController,
                      label: S.of(context).phone,
                      obscureText: false,
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your phone number";
                        }
                        return null;
                      },
                    ),

                    // Country Field
                    CustomTextfield(
                      controller: cubit.countryController,
                      label: "Country",
                      obscureText: false,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your country";
                        }
                        return null;
                      },
                    ),

                    // City Field
                    CustomTextfield(
                      controller: cubit.cityController,
                      label: S.of(context).city,
                      obscureText: false,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your city";
                        }
                        return null;
                      },
                    ),

                    DropdownButton<Gender>(
                      isExpanded: true,
                      value: cubit.selectedGender,
                      hint: Text("Select Gender"),
                      items:
                          Gender.values.map((gender) {
                            return DropdownMenuItem(
                              value: gender,
                              child: Text(gender.label),
                            );
                          }).toList(),
                      onChanged: (value) {
                        if (value != null) cubit.selectGender(value);
                      },
                    ),

                    InkWell(
                      onTap: () => cubit.pickDate(context),
                      child: InputDecorator(
                        decoration: InputDecoration(
                          labelText: "Date of Birth",
                          border: OutlineInputBorder(),
                          suffixIcon: Icon(Icons.calendar_today),
                        ),
                        child: Text(
                          cubit.selectedDate == null
                              ? "Select Date"
                              : cubit.selectedDate!.toLocal().toString().split(
                                ' ',
                              )[0],
                          style: TextStyle(
                            fontSize: 16,
                            color:
                                cubit.selectedDate == null
                                    ? Colors.grey
                                    : Colors.black,
                          ),
                        ),
                      ),
                    ),
                    // --------------------------------------------------------------------------------------------------------------------------------------
                    SizedBox(height: 20),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (cubit.formKey.currentState!.validate()) {
                            context.read<RegisterCubit>().register(
                              registerResponseModel: RegisterResponseModel(
                                name: cubit.nameController.text,
                                email: cubit.emailController.text,
                                password: cubit.passwordController.text,
                                phone: cubit.phoneController.text,
                                country: cubit.countryController.text,
                                city: cubit.cityController.text,

                                // Assuming you add .name to Gender enum
                              ),
                              gender: cubit.selectedGender!.name,

                              // dateOfBirth: '1990-05-20',
                              dateOfBirth:
                                  cubit.selectedDate != null
                                      ? cubit.selectedDate!
                                          .toLocal()
                                          .toString()
                                          .split(' ')[0]
                                      : '',
                            );
                          }
                        },

                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 15),
                          backgroundColor: Color(0xFF2F4EFF),
                        ),
                        child:
                            state is RegisterLoading
                                ? CircularProgressIndicator(color: Colors.white)
                                : Text(
                                  S.of(context).register,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                      ),
                    ),
                    SizedBox(height: 20),
                    BuildLoginText(),
                  ],
                ),
              );
            },
          ),
        ),
      ),

      ///
    );
  }
}
