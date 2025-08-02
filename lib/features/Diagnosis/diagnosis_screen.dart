import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medease1/core/networking/dio_helper.dart';
import 'package:medease1/core/storage/storage_helper.dart';
import 'package:medease1/core/storage/storage_keys.dart';
import 'package:medease1/core/utils/my_logger.dart';
import 'package:medease1/features/Diagnosis/cubit/diagnosis_cubit.dart';
import 'package:medease1/features/Diagnosis/cubit/diagnosis_state.dart';
import 'package:medease1/features/Diagnosis/repo/diagnosis_repo.dart';
import 'package:medease1/features/patients/model/patients_model.dart';
import 'package:medease1/features/patients/repo/patients_repo.dart';
import 'package:medease1/features/treatment/treatment_model.dart';
import 'package:medease1/features/treatment/treatment_repo.dart';

class DiagnosisScreen extends StatefulWidget {
  const DiagnosisScreen({super.key});

  @override
  State<DiagnosisScreen> createState() => _DiagnosisScreenState();
}

class _DiagnosisScreenState extends State<DiagnosisScreen> {
  List<PatientModel> patients = [];
  List<TreatmentModel> treatments = [];
  String? selectedPatientId;
  List<String> selectedMedicationIds = [];

  @override
  void initState() {
    super.initState();
    fetchPatients();
  }

  Future<void> fetchPatients() async {
    final repo = PatientsRepo(DioHelper());
    final data = await repo.getPatients(page: 1);
    setState(() {
      patients = data['Patients'];
    });
  }

  Future<void> fetchTreatments(String diseaseId) async {
    final repo = TreatmentRepo(Dio());
    final data = await repo.getTreatmentsByDisease(diseaseId);
    setState(() {
      treatments = data;
    });
  }

  void showAddDiagnosisDialog(BuildContext context) async {
    final doctorId = await StorageHelper().getData(key: StorageKeys.userId);
    final titleController = TextEditingController();
    final descController = TextEditingController();
    final symptomsController = TextEditingController();
    final recommendController = TextEditingController();
    final followUpController = TextEditingController();
    final notesController = TextEditingController();

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text("Add Diagnosis"),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DropdownButtonFormField<String>(
                    hint: Text("Select Patient"),
                    value: selectedPatientId,
                    onChanged: (val) => setState(() => selectedPatientId = val),
                    items:
                        patients
                            .map(
                              (p) => DropdownMenuItem(
                                value: p?.id,
                                child: Text(p.name),
                              ),
                            )
                            .toList(),
                  ),
                  TextField(
                    controller: titleController,
                    decoration: InputDecoration(labelText: 'Title'),
                  ),
                  TextField(
                    controller: descController,
                    decoration: InputDecoration(labelText: 'Description'),
                  ),
                  TextField(
                    controller: symptomsController,
                    decoration: InputDecoration(
                      labelText: 'Symptoms (comma-separated)',
                    ),
                  ),
                  TextField(
                    controller: recommendController,
                    decoration: InputDecoration(labelText: 'Recommendations'),
                  ),
                  TextField(
                    controller: followUpController,
                    decoration: InputDecoration(labelText: 'Follow Up'),
                  ),
                  TextField(
                    controller: notesController,
                    decoration: InputDecoration(labelText: 'Notes'),
                  ),
                  SizedBox(height: 10),
                  Text("Select Medications:"),
                  ...treatments.map(
                    (t) => CheckboxListTile(
                      title: Text(t.name),
                      value: selectedMedicationIds.contains(t.id),
                      onChanged: (val) {
                        setState(() {
                          val == true
                              ? selectedMedicationIds.add(t.id)
                              : selectedMedicationIds.remove(t.id);
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text("Cancel"),
              ),
              TextButton(
                onPressed: () {
                  context.read<DiagnosisCubit>().addDiagnosis({
                    "patientId": selectedPatientId,
                    "doctorId": doctorId,
                    "title": titleController.text,
                    "description": descController.text,
                    "symptoms": symptomsController.text.split(","),
                    "medications": selectedMedicationIds,
                    "recommendations": recommendController.text,
                    "followUp": followUpController.text,
                    "notes": notesController.text,
                  });
                  Navigator.pop(context);
                },
                child: Text("Add"),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              DiagnosisCubit(DiagnosisRepo(DioHelper()))
                ..fetchDiagnoses("6852a5dbbc451d9b3e2eccb7"),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Diagnoses"),
          actions: [
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () => showAddDiagnosisDialog(context),
            ),
          ],
        ),
        body: BlocBuilder<DiagnosisCubit, DiagnosisState>(
          builder: (context, state) {
            if (state is DiagnosisLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is DiagnosisSuccess) {
              MyLogger.magenta(state.diagnoses.length.toString());
              return ListView.builder(
                itemCount: state.diagnoses.length,
                itemBuilder: (context, index) {
                  final diagnosis = state.diagnoses[index];
                  MyLogger.yellow(
                    "Diagnosis: ${diagnosis.title}, ID: ${diagnosis.id}, description: ${diagnosis.description}",
                  );
                  return ListTile(
                    title: Text(diagnosis.title ?? "No Title"),
                    subtitle: Text(diagnosis.description ?? "No Description"),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () async {
                        final confirm = await showDialog<bool>(
                          context: context,
                          builder:
                              (context) => AlertDialog(
                                title: Text("Confirm Delete"),
                                content: Text(
                                  "Are you sure you want to delete this diagnosis?",
                                ),
                                actions: [
                                  TextButton(
                                    onPressed:
                                        () => Navigator.pop(context, false),
                                    child: Text("Cancel"),
                                  ),
                                  TextButton(
                                    onPressed:
                                        () => Navigator.pop(context, true),
                                    child: Text("Delete"),
                                  ),
                                ],
                              ),
                        );
                        if (confirm == true) {
                          context.read<DiagnosisCubit>().deleteDiagnosis(
                            diagnosis.id,
                          );
                        }
                      },
                    ),
                  );
                },
              );
            } else if (state is DiagnosisFailure) {
              return Center(child: Text("Error: ${state.error}"));
            }
            return SizedBox();
          },
        ),
      ),
    );
  }
}
