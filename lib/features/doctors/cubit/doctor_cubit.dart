import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medease1/features/doctors/cubit/doctor_state.dart';
import 'package:medease1/features/doctors/model/doctors_model.dart';
import 'package:medease1/features/doctors/repo/doctors_repo.dart';

class DoctorCubit extends Cubit<DoctorState> {
  final DoctorsRepo doctorsRepo;

  DoctorCubit(this.doctorsRepo) : super(DoctorInitial());
  int page = 1;
  bool hasMore = true;
  List<DoctorsModel> doctors = [];
  int totalPages = 1;

  Future<void> fetchDoctors({bool isloadMore = false}) async {
    if (!hasMore && isloadMore) return;

    if (!isloadMore) {
      page = 1;
      doctors.clear();
      hasMore = true;
      emit(DoctorLoading());
    } else {
      emit(DoctorSuccess(doctors, hasMore: hasMore, isLoadingMore: true));
    }

    try {
      if (page <= totalPages) {
        final response = await doctorsRepo.getDoctors(page: page);
        final newDoctors = response['doctors'] as List<DoctorsModel>;
        totalPages = response['totalPages'] as int;
        log("totalPages: $totalPages");
        if (newDoctors.isEmpty && page <= totalPages) {
          hasMore = false;
        } else {
          doctors.addAll(newDoctors);
          page++;
        }
      }

      emit(DoctorSuccess(doctors, hasMore: hasMore, isLoadingMore: false));
    } on Exception catch (e) {
      emit(DoctorError(e.toString()));
    }
  }

  Future<void> deleteDoctor(String id) async {
    emit(DoctorLoading());
    try {
      await doctorsRepo.deleteDoctor(id: id);
      fetchDoctors();
    } catch (e) {
      emit(DoctorError(e.toString()));
    }
  }
}
