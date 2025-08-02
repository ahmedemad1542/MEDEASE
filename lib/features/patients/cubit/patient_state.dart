import 'package:medease1/features/patients/model/patients_model.dart';

abstract class PatientState {}

class PatientStateInitial extends PatientState {}

class PatientStateLoading extends PatientState {}

class PatientStateSuccess extends PatientState {
  final List<PatientModel> patients;
  final bool hasMore;
  final bool isLoadingMore;

  PatientStateSuccess(
    this.patients, {
    this.hasMore = true,
    this.isLoadingMore = false,
  });
}

class PatientStateError extends PatientState {
  final String message;

  PatientStateError(this.message);
}

class PatientStateDeleted extends PatientState {}
