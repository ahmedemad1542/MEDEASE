import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medease1/core/networking/dio_helper.dart';
import 'package:medease1/features/appointment/create_appointment/cubit/appointment_cubit.dart';
import 'package:medease1/features/appointment/create_appointment/cubit/appointment_state.dart';
import 'package:medease1/features/appointment/create_appointment/repo/create_appointment_repo.dart';

class AppointmentScreen extends StatelessWidget {
  final String doctorId;

  const AppointmentScreen({super.key, required this.doctorId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AppointmentCubit(AppointmentRepo(DioHelper())),
      child: Scaffold(
        appBar: AppBar(title: Text("Book Appointment")),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocConsumer<AppointmentCubit, AppointmentState>(
            listener: (context, state) {
              if (state is AppointmentSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Appointment booked successfully")),
                );
              } else if (state is AppointmentError) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.message)));
              }
            },
            builder: (context, state) {
              final cubit = context.read<AppointmentCubit>();

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Select your Priority"),
                  DropdownButton<PriorityLevel>(
                    isExpanded: true,
                    value: cubit.selectedPriority,
                    hint: Text("Select Priority"),
                    items:
                        PriorityLevel.values.map((priority) {
                          return DropdownMenuItem(
                            value: priority,
                            child: Text(priority.label),
                          );
                        }).toList(),
                    onChanged: (value) {
                      if (value != null) cubit.selectPriority(value);
                    },
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => cubit.pickDate(context),
                    child: Text(
                      cubit.selectedDate == null
                          ? " Select Date"
                          : "Selected Date ${cubit.selectedDate!.toLocal()}"
                              .split(' ')[0],
                    ),
                  ),

                  SizedBox(height: 30),
                  state is AppointmentLoading
                      ? Center(child: CircularProgressIndicator())
                      : ElevatedButton(
                        onPressed:
                            () => cubit.createAppointment(
                              id: doctorId,
                              priority: cubit.selectedPriority!.value,
                              appointmentDate: cubit.selectedDate.toString(),
                              status: "queued",
                            ),
                        child: Text("Book Appointment"),
                      ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
