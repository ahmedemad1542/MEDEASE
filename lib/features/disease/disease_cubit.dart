// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'disease_repo.dart';
// import 'disease_model.dart';

// abstract class DiseaseState {}

// class DiseaseInitial extends DiseaseState {}

// class DiseaseLoading extends DiseaseState {}

// class DiseaseLoaded extends DiseaseState {
//   final List<DiseaseModel> diseases;
//   DiseaseLoaded(this.diseases);
// }

// class DiseaseError extends DiseaseState {
//   final String error;
//   DiseaseError(this.error);
// }

// class DiseaseCubit extends Cubit<DiseaseState> {
//   final DiseaseRepo repo;
//   DiseaseCubit(this.repo) : super(DiseaseInitial());

//   void fetchDiseases() async {
//     emit(DiseaseLoading());
//     try {
//       final diseases = await repo.getDiseases();
//       emit(DiseaseLoaded(diseases));
//     } catch (e) {
//       emit(DiseaseError(e.toString()));
//     }
//   }
// }

// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'disease_repo.dart';
// import 'disease_model.dart';

// abstract class DiseaseState {}

// class DiseaseInitial extends DiseaseState {}

// class DiseaseLoading extends DiseaseState {}

// class DiseaseLoaded extends DiseaseState {
//   final List<DiseaseModel> diseases;
//   DiseaseLoaded(this.diseases);
// }

// class DiseaseError extends DiseaseState {
//   final String error;
//   DiseaseError(this.error);
// }

// class DiseaseActionSuccess extends DiseaseState {}

// class DiseaseCubit extends Cubit<DiseaseState> {
//   final DiseaseRepo repo;
//   DiseaseCubit(this.repo) : super(DiseaseInitial());

//   void fetchDiseases() async {
//     emit(DiseaseLoading());
//     try {
//       final diseases = await repo.getDiseases();
//       emit(DiseaseLoaded(diseases));
//     } catch (e) {
//       emit(DiseaseError(e.toString()));
//     }
//   }

//   void createDisease({
//     required String name,
//     required String description,
//     required String rank,
//     required String diseaseCategoryId,
//   }) async {
//     emit(DiseaseLoading());
//     try {
//       await repo.createDisease(
//         name: name,
//         description: description,
//         rank: rank,
//         diseaseCategoryId: diseaseCategoryId,
//       );
//       fetchDiseases();
//     } catch (e) {
//       emit(DiseaseError(e.toString()));
//     }
//   }

//   void updateDisease({
//     required String diseaseId,
//     required String name,
//     required String description,
//     required String rank,
//   }) async {
//     emit(DiseaseLoading());
//     try {
//       await repo.updateDisease(
//         diseaseId: diseaseId,
//         name: name,
//         description: description,
//         rank: rank,
//       );
//       fetchDiseases();
//     } catch (e) {
//       emit(DiseaseError(e.toString()));
//     }
//   }

//   void deleteDisease(String diseaseId) async {
//     emit(DiseaseLoading());
//     try {
//       await repo.deleteDisease(diseaseId);
//       fetchDiseases();
//     } catch (e) {
//       emit(DiseaseError(e.toString()));
//     }
//   }
// }

import 'package:flutter_bloc/flutter_bloc.dart';
import 'disease_repo.dart';
import 'disease_model.dart';

abstract class DiseaseState {}

class DiseaseInitial extends DiseaseState {}

class DiseaseLoading extends DiseaseState {}

class DiseaseLoaded extends DiseaseState {
  final List<DiseaseModel> diseases;
  DiseaseLoaded(this.diseases);
}

class DiseaseError extends DiseaseState {
  final String error;
  DiseaseError(this.error);
}

class DiseaseCubit extends Cubit<DiseaseState> {
  final DiseaseRepo repo;
  List<DiseaseModel> diseases = [];

  DiseaseCubit(this.repo) : super(DiseaseInitial());

  void fetchDiseases() async {
    emit(DiseaseLoading());
    try {
      diseases = await repo.getDiseases();
      emit(DiseaseLoaded(List.from(diseases)));
    } catch (e) {
      emit(DiseaseError(e.toString()));
    }
  }

  void createDisease({
    required String name,
    required String description,
    required String rank,
    required String diseaseCategoryId,
  }) async {
    emit(DiseaseLoading());
    try {
      final newDisease = await repo.createDisease(
        name: name,
        description: description,
        rank: rank,
        diseaseCategoryId: diseaseCategoryId,
      );
      diseases.insert(0, newDisease);
      emit(DiseaseLoaded(List.from(diseases)));
    } catch (e) {
      emit(DiseaseError(e.toString()));
    }
  }

  void updateDisease({
    required String diseaseId,
    required String name,
    required String description,
    required String rank,
  }) async {
    emit(DiseaseLoading());
    try {
      await repo.updateDisease(
        diseaseId: diseaseId,
        name: name,
        description: description,
        rank: rank,
      );
      final index = diseases.indexWhere((d) => d.id == diseaseId);
      if (index != -1) {
        diseases[index] = DiseaseModel(
          id: diseaseId,
          name: name,
          description: description,
          rank: rank,
        );
      }
      emit(DiseaseLoaded(List.from(diseases)));
    } catch (e) {
      emit(DiseaseError(e.toString()));
    }
  }

  void deleteDisease(String diseaseId) async {
    emit(DiseaseLoading());
    try {
      await repo.deleteDisease(diseaseId);
      diseases.removeWhere((d) => d.id == diseaseId);
      emit(DiseaseLoaded(List.from(diseases)));
    } catch (e) {
      emit(DiseaseError(e.toString()));
    }
  }
}
