import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medease1/core/utils/my_logger.dart';
import 'package:medease1/features/Diagnosis/cubit/diagnosis_state.dart';
import 'package:medease1/features/Diagnosis/repo/diagnosis_repo.dart';

class DiagnosisCubit extends Cubit<DiagnosisState> {
  final DiagnosisRepo repo;
  DiagnosisCubit(this.repo) : super(DiagnosisInitial());

  Future<void> fetchDiagnoses(String doctorId) async {
    emit(DiagnosisLoading());
    try {
      final diagnoses = await repo.getAllDiagnoses(doctorId);
      emit(DiagnosisSuccess(diagnoses));
    } catch (e) {
      MyLogger.red('Error fetching diagnoses: $e');
      emit(DiagnosisFailure(e.toString()));
    }
  }

  Future<void> addDiagnosis(Map<String, dynamic> body) async {
    try {
      await repo.addDiagnosis(body);
    } catch (e) {
      emit(DiagnosisFailure(e.toString()));
    }
  }

  Future<void> deleteDiagnosis(String id) async {
    try {
      await repo.deleteDiagnosis(id);
    } catch (e) {
      emit(DiagnosisFailure(e.toString()));
    }
  }
}
