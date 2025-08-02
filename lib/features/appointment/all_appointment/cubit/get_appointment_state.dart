import 'package:medease1/features/appointment/all_appointment/model/appointment_model.dart';

abstract class GetAppointmentState {}

class GetAppointmentInitial extends GetAppointmentState {}

class GetAppointmentLoading extends GetAppointmentState {}

class GetAppointmentLoaded extends GetAppointmentState {
  final List<AppointmentModel> appointment;
  GetAppointmentLoaded(this.appointment);
}

class GetAppointmentError extends GetAppointmentState {
  final String message;
  GetAppointmentError(this.message);
}
