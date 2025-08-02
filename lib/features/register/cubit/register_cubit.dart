import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medease1/core/utils/my_logger.dart';
import 'package:medease1/features/register/cubit/register_state.dart';
import 'package:medease1/features/register/model/register_model.dart';
import 'package:medease1/features/register/repo/register_repo.dart';

enum Gender { Male, Female }

extension GenderExtension on Gender {
  String get label {
    switch (this) {
      case Gender.Male:
        return "Male";
      case Gender.Female:
        return "Female";
    }
  }

  String get value => name; // لتستخدمها في API
}

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit(this._registerRepo) : super(RegisterInitial());
  final RegisterRepo _registerRepo;
  Gender? selectedGender;
  DateTime? selectedDate;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController countryController = TextEditingController();

  TextEditingController cityController = TextEditingController();

  void selectGender(Gender gender) {
    selectedGender = gender;
    emit(RegisterInitial());
  }

  void pickDate(BuildContext context) async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (date != null) {
      selectedDate = date;
      emit(RegisterInitial());
    }
  }

  void register({
    required RegisterResponseModel registerResponseModel,
    required String gender,
    required String dateOfBirth,
  }) async {
    emit(RegisterLoading());
    final Either<String, dynamic> response = await _registerRepo.register(
      registerModel: RegisterResponseModel(
        name: registerResponseModel.name,
        email: registerResponseModel.email,
        password: registerResponseModel.password,
        phone: registerResponseModel.phone,
        country: registerResponseModel.country,
        city: registerResponseModel.city,
        // gender: registerResponseModel.gender,
        // dateOfBirth: registerResponseModel.dateOfBirth,
      ),
      gender: gender,
      dateOfBirth: dateOfBirth,
    );
    response.fold(
      (error) {
        emit(RegisterError(error.toString()));
      },
      (right) {
        emit(RegisterSuccess(right.toString()));
      },
    );
  }
}
