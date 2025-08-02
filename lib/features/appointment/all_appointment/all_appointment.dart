
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:medease1/features/appointment/all_appointment/cubit/get_appointment_cubit.dart';
import 'package:medease1/features/appointment/all_appointment/cubit/get_appointment_state.dart';



class MyAppointment extends StatefulWidget {
  const MyAppointment({super.key});

  @override
  State<MyAppointment> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<MyAppointment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Appointments')),
      body: BlocConsumer<GetAppointmentCubit, GetAppointmentState>(
        listener: (BuildContext context, state) {
          if (state is GetAppointmentError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text('Error: ${state.message}')));
          }
          if (state is GetAppointmentLoaded) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('My appointments loaded successfully')),
            );
          }
        },
        builder: (context, state) {
          if (state is GetAppointmentLoading) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 10),
                  Text("Loading appointments..."),
                ],
              ),
            );
          } else if (state is GetAppointmentLoaded) {
            final appointments = state.appointment;
            return ListView.builder(
              itemCount: appointments.length,
              itemBuilder: (context, index) {
                final appointment = appointments[index];
                final priorityColor = _getPriorityColor(appointment.priority);

                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.calendar_today, color: priorityColor),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Dr. ${appointment.doctorName}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Date: ${DateFormat('dd-MM-yyyy').format(appointment.appointmentDate)}',
                                style: TextStyle(color: Colors.grey[700]),
                              ),
                              const SizedBox(height: 2),
                              Row(
                                children: [
                                  const Text(
                                    'Priority: ',
                                    style: TextStyle(color: Colors.black87),
                                  ),
                                  Text(
                                    appointment.priority,
                                    style: TextStyle(
                                      color: priorityColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (state is GetAppointmentError) {
            return Center(child: Text('Error: ${state.message}'));
          }

          return const Center(child: Text('No profile data available'));
        },
      ),
    );
  }

  Color _getPriorityColor(String priority) {
    switch (priority.toLowerCase()) {
      case 'critical':
        return Colors.red;
      case 'important':
        return Colors.orange;
      case 'low':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  String getMonthName(int month) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return months[month - 1];
  }
}
