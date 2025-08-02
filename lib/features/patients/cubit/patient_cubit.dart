import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medease1/features/patients/cubit/patient_state.dart';
import 'package:medease1/features/patients/repo/patients_repo.dart';
import 'package:medease1/features/patients/model/patients_model.dart';

import '../../../core/utils/my_logger.dart';

class PatientsCubit extends Cubit<PatientState> {
  final PatientsRepo patientsRepo;

  PatientsCubit(this.patientsRepo) : super(PatientStateInitial());
  int page = 1;
  bool hasMore = true;
  List<PatientModel> Patientss = [];
  int totalPages = 1;

  Future<void> fetchPatients({bool isloadMore = false}) async {
    if (!hasMore && isloadMore) return;

    if (!isloadMore) {
      page = 1;
      Patientss.clear();
      hasMore = true;
      emit(PatientStateLoading());
    } else {
      emit(
        PatientStateSuccess(Patientss, hasMore: hasMore, isLoadingMore: true),
      );
    }

    try {
      if (page <= totalPages) {
        final response = await patientsRepo.getPatients(page: page);
        final newPatientss = response['Patients'] as List<PatientModel>;
        MyLogger.yellow(newPatientss.length.toString());
        totalPages = response['totalPages'] as int;
        log("totalPages: $totalPages");
        if (newPatientss.isEmpty && page <= totalPages) {
          hasMore = false;
        } else {
          Patientss.addAll(newPatientss);
          page++;
        }
      }

      emit(
        PatientStateSuccess(Patientss, hasMore: hasMore, isLoadingMore: false),
      );
    } on Exception catch (e) {
      emit(PatientStateError(e.toString()));
    }
  }

  Future<void> deletePatient(String id) async {
    emit(PatientStateLoading());
    try {
      await patientsRepo.deletePatient(id: id);
      fetchPatients();
    } catch (e) {
      emit(PatientStateError(e.toString()));
    }
  }
}
