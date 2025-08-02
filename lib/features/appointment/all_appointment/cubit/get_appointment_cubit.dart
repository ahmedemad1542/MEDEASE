import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medease1/features/appointment/all_appointment/cubit/get_appointment_state.dart';
import 'package:medease1/features/appointment/all_appointment/repo/all_appointment_reop.dart';

class GetAppointmentCubit extends Cubit<GetAppointmentState> {
  final GetAppointmentRepo repo;
  GetAppointmentCubit(this.repo) : super(GetAppointmentInitial());

  void getAppointment() async {
    emit(GetAppointmentLoading());
    final getAppointment = await repo.getAppointment();

    getAppointment.fold(
      (error) => emit(GetAppointmentError(error)),
      (appointmentList) => emit(GetAppointmentLoaded(appointmentList)),
    );
  }
}
