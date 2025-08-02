import 'package:medease1/core/utils/my_logger.dart';

class AppointmentModel {
  final String id;
  final String patientId;
  final String patientName;
  final String doctorName;
  final String doctorId;
  final String appointmentId;
  final String priority;
  final DateTime appointmentDate;
  final DateTime createdAt;
  final DateTime updatedAt;

  AppointmentModel({
    required this.id,
    required this.patientId,
    required this.patientName,
    required this.doctorName,
    required this.doctorId,
    required this.priority,
    required this.appointmentDate,
    required this.createdAt,
    required this.updatedAt,
    required this.appointmentId,
  });

  factory AppointmentModel.fromJson(Map<String, dynamic> json) {
    // Log the incoming JSON
    MyLogger.bgGreen('📥 Incoming appointment JSON: $json');

    final patientObj = json['patientId'];
    final doctorObj = json['doctorId'];

    return AppointmentModel(
      id: json['_id'] ?? '',
      patientId: (patientObj != null && patientObj is Map && patientObj.containsKey('_id'))
          ? patientObj['_id'] ?? ''
          : '',
      patientName: json.containsKey('patientName') ? json['patientName'] ?? '' : '',
      doctorName: json.containsKey('doctorName') ? json['doctorName'] ?? '' : '',
      doctorId: (doctorObj != null && doctorObj is Map && doctorObj.containsKey('_id'))
          ? doctorObj['_id'] ?? ''
          : '',
      priority: json.containsKey('priority') ? json['priority'] ?? '' : '',
      appointmentDate: DateTime.tryParse(json['appointmentDate'] ?? '') ?? DateTime.now(),
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updatedAt'] ?? '') ?? DateTime.now(),
      appointmentId: json.containsKey('appointmentId') ? json['appointmentId'] ?? '' : '',
    );
  }
}
