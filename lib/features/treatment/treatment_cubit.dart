import 'package:flutter_bloc/flutter_bloc.dart';
import 'treatment_model.dart';
import 'treatment_repo.dart';

abstract class TreatmentState {}

class TreatmentInitial extends TreatmentState {}

class TreatmentLoading extends TreatmentState {}

class TreatmentLoaded extends TreatmentState {
  final List<TreatmentModel> treatments;
  TreatmentLoaded(this.treatments);
}

class TreatmentError extends TreatmentState {
  final String message;
  TreatmentError(this.message);
}

class TreatmentCubit extends Cubit<TreatmentState> {
  final TreatmentRepo repo;
  TreatmentCubit(this.repo) : super(TreatmentInitial());

  final bool isPrevilleged = false;

  void createTreatment(Map<String, dynamic> data, String diseaseId) async {
    emit(TreatmentLoading());
    try {
      await repo.createTreatment(data);
      fetchTreatments(diseaseId); // Reload
    } catch (e) {
      emit(TreatmentError(e.toString()));
    }
  }

  void updateTreatment(
    String treatmentId,
    Map<String, dynamic> data,
    String diseaseId,
  ) async {
    emit(TreatmentLoading());
    try {
      await repo.updateTreatment(treatmentId, data);
      fetchTreatments(diseaseId); // Reload
    } catch (e) {
      emit(TreatmentError(e.toString()));
    }
  }

  void fetchTreatments(String diseaseId) async {
    emit(TreatmentLoading());
    try {
      final treatments = await repo.getTreatmentsByDisease(diseaseId);
      emit(TreatmentLoaded(treatments));
    } catch (e) {
      emit(TreatmentError(e.toString()));
    }
  }
}
