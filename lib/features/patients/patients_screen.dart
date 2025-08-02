import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medease1/core/utils/my_logger.dart' show MyLogger;
import 'package:medease1/features/patients/cubit/patient_cubit.dart';
import 'package:medease1/features/patients/cubit/patient_state.dart';
import 'package:medease1/features/patients/widgets/card_patient_widget.dart';

class PatientsScreen extends StatelessWidget {
  const PatientsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Patients"), backgroundColor: Colors.blue),
      body: BlocConsumer<PatientsCubit, PatientState>(
        listener: (context, state) {
          if (state is PatientStateError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          if (state is PatientStateLoading) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 10),
                  Text("Loading Patients..."),
                ],
              ),
            );
          } else if (state is PatientStateSuccess) {
            return NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification notification) {
                if (notification is ScrollEndNotification &&
                    notification.metrics.pixels >=
                        notification.metrics.maxScrollExtent * 0.8) {
                  log("scrolled to bottom");

                  context.read<PatientsCubit>().fetchPatients(isloadMore: true);
                }
                return true;
              },
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: state.patients.length,
                itemBuilder: (context, index) {
                  final patient = state.patients[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 8.0,
                    ),
                    child: CardPatientWidget(
                      gender: patient.gender,
                      name: patient.name,
                      id: patient.id,
                      city: patient.city,
                      country: patient.country,
                      onDelete:
                          () => context.read<PatientsCubit>().deletePatient(
                            patient.id,
                          ),
                    ),
                  );
                },
              ),
            );
          } else {
            return const Center(child: Text(' No Patients found.'));
          }
        },
      ),
    );
  }
}
