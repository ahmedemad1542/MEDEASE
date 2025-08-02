import 'package:medease1/features/Diagnosis/model/diagnosis_model.dart';

abstract class DiagnosisState {}

class DiagnosisInitial extends DiagnosisState {}
class DiagnosisLoading extends DiagnosisState {}
class DiagnosisSuccess extends DiagnosisState {
  final List<DiagnosisModel> diagnoses;
  DiagnosisSuccess(this.diagnoses);
}
class DiagnosisFailure extends DiagnosisState {
  final String error;
  DiagnosisFailure(this.error);
}