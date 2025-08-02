import 'package:medease1/features/doctors/model/doctors_model.dart';

abstract class DoctorState {}

class DoctorInitial extends DoctorState {}

class DoctorLoading extends DoctorState {}

class DoctorSuccess extends DoctorState {
  final List<DoctorsModel> doctors;
  final bool hasMore;
  final bool isLoadingMore;

  DoctorSuccess(
    this.doctors, {
    this.hasMore = true,
    this.isLoadingMore = false,
  });
}

class DoctorError extends DoctorState {
  final String message;

  DoctorError(this.message);
}

class DoctorDeleted extends DoctorState {}
