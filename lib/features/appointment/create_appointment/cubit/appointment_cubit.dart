// import 'package:dartz/dartz.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:medease1/features/appointment/cubit/appointment_state.dart';
// import 'package:medease1/features/appointment/repo/appointment_repository.dart';

// class AppointmentCubit extends Cubit<AppointmentState> {
//   final AppointmentRepo _appointmentRepo;
//   TextEditingController priority = TextEditingController();
//   TextEditingController appointmentDate = TextEditingController();
//   TextEditingController status = TextEditingController();

//   AppointmentCubit(this._appointmentRepo) : super(AppointmentInitial());

//   void createAppointment({
//     required String id,
//     required String priority,
//     required String appointmentDate,
//     required String status,
//   }) async {
//     emit(AppointmentLoading());
//     final Either<String, dynamic> response = await _appointmentRepo
//         .createAppointment(
//           id: id,
//           priority: priority,
//           appointmentDate: appointmentDate,
//           status: status,
//         );
//     response.fold(
//       (error) => emit(AppointmentError(error.toString())),
//       (right) => emit(AppointmentSuccess("Appointment booked successfully")),
//     );
//   }
// }

// appointment_cubit.dart
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medease1/features/appointment/create_appointment/repo/create_appointment_repo.dart';
import 'appointment_state.dart';

enum PriorityLevel { critical, important, moderate, low }

extension PriorityExtension on PriorityLevel {
  String get label {
    switch (this) {
      case PriorityLevel.critical:
        return "Critical";
      case PriorityLevel.important:
        return "Important";
      case PriorityLevel.moderate:
        return "Moderate";
      case PriorityLevel.low:
        return "Low";
    }
  }

  String get value => name; // لتستخدمها في API
}

class AppointmentCubit extends Cubit<AppointmentState> {
  AppointmentCubit(this._appointmentRepo) : super(AppointmentInitial());
  final AppointmentRepo _appointmentRepo;
  PriorityLevel? selectedPriority;
  DateTime? selectedDate;

  void selectPriority(PriorityLevel priority) {
    selectedPriority = priority;
    emit(AppointmentInitial());
  }

  void pickDate(BuildContext context) async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (date != null) {
      selectedDate = date;
      emit(AppointmentInitial());
    }
  }

  void createAppointment({
    required String id,
    required String priority,
    required String appointmentDate,
    required String status,
  }) async {
    emit(AppointmentLoading());
    final Either<String, dynamic> response = await _appointmentRepo
        .createAppointment(
          id: id,
          priority: priority,
          appointmentDate: appointmentDate,
          status: status,
        );
    response.fold(
      (error) => emit(AppointmentError(error.toString())),
      (right) => emit(AppointmentSuccess("Appointment booked successfully")),
    );
  }
}
