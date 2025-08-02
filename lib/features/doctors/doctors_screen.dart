import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medease1/features/doctors/cubit/doctor_cubit.dart';
import 'package:medease1/features/doctors/cubit/doctor_state.dart';
import 'package:medease1/features/doctors/widgets/card_doctor_widget.dart';

class DoctorsScreen extends StatelessWidget {
  const DoctorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Doctors"), backgroundColor: Colors.blue),
      body: BlocConsumer<DoctorCubit, DoctorState>(
        listener: (context, state) {
          if (state is DoctorError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          if (state is DoctorLoading) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 10),
                  Text("Loading doctors..."),
                ],
              ),
            );
          } else if (state is DoctorSuccess) {
            return NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification notification) {
                if (notification is ScrollEndNotification &&
                    notification.metrics.pixels >=
                        notification.metrics.maxScrollExtent * 0.8) {
                  log("scrolled to bottom");

                  context.read<DoctorCubit>().fetchDoctors(isloadMore: true);
                }
                return true;
              },
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: state.doctors.length,
                itemBuilder: (context, index) {
                  final doctor = state.doctors[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 8.0,
                    ),
                    child: CardDoctorWidget(
                      gender: doctor.gender,
                      name: doctor.name,
                      specialization: doctor.specialization,
                      rate: doctor.rate,
                      id: doctor.id,
                      city: doctor.city,
                      country: doctor.country,
                      onDelete:
                          () => context.read<DoctorCubit>().deleteDoctor(
                            doctor.id,
                          ),
                    ),
                  );
                },
              ),
            );
          } else {
            return const Center(child: Text(' No doctors found.'));
          }
        },
      ),
    );
  }
}
