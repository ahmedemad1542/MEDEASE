// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:medease1/core/utils/service_locator.dart';
// import 'treatment_cubit.dart';
// import 'treatment_repo.dart';

// class TreatmentDialog extends StatelessWidget {
//   final String diseaseId;
//   final String diseaseName;

//   const TreatmentDialog({
//     super.key,
//     required this.diseaseId,
//     required this.diseaseName,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create:
//           (_) =>
//               TreatmentCubit(sl<TreatmentRepo>())..fetchTreatments(diseaseId),
//       child: AlertDialog(
//         title: Text("Treatments for $diseaseName"),
//         content: BlocBuilder<TreatmentCubit, TreatmentState>(
//           builder: (context, state) {
//             if (state is TreatmentLoading) {
//               return const SizedBox(
//                 height: 100,
//                 child: Center(child: CircularProgressIndicator()),
//               );
//             } else if (state is TreatmentLoaded) {
//               if (state.treatments.isEmpty) {
//                 return const Text("No treatments available.");
//               }
//               return SizedBox(
//                 width: double.maxFinite,
//                 child: ListView.builder(
//                   shrinkWrap: true,
//                   itemCount: state.treatments.length,
//                   itemBuilder: (context, index) {
//                     final t = state.treatments[index];
//                     return ListTile(
//                       title: Text(t.name),
//                       subtitle: Text(t.description),
//                       trailing: Text(t.dosage),
//                     );
//                   },
//                 ),
//               );
//             } else if (state is TreatmentError) {
//               return Text("Error: ${state.message}");
//             }
//             return const SizedBox.shrink();
//           },
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text("Close"),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medease1/core/utils/role_service.dart';
import 'package:medease1/core/utils/service_locator.dart';
import '../../core/storage/storage_helper.dart';
import 'treatment_cubit.dart';
import 'treatment_repo.dart';
import 'treatment_form_dialog.dart';

class TreatmentDialog extends StatelessWidget {
  final String diseaseId;
  final String diseaseName;

  const TreatmentDialog({
    super.key,
    required this.diseaseId,
    required this.diseaseName,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (_) =>
              TreatmentCubit(sl<TreatmentRepo>())..fetchTreatments(diseaseId),
      child: AlertDialog(
        title: Text("Treatments for $diseaseName"),
        content: SizedBox(
          width: double.maxFinite,
          child: BlocBuilder<TreatmentCubit, TreatmentState>(
            builder: (context, state) {
              if (state is TreatmentLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is TreatmentLoaded) {
                if (state.treatments.isEmpty) {
                  return const Text("No treatments found.");
                }
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.treatments.length,
                  itemBuilder: (context, index) {
                    final t = state.treatments[index];
                    return ListTile(
                      title: Text(t.name),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(t.description),
                          Text(
                            "Dosage: ${t.dosage}",
                            textAlign: TextAlign.start,
                          ),
                          Text(
                            "Instructions: ${t.instructions}",
                            textAlign: TextAlign.start,
                          ),
                          Text(
                            "Quantity: ${t.quantity}",
                            textAlign: TextAlign.start,
                          ),
                          Text(
                            "Refills: ${t.refills ?? 0}",
                            textAlign: TextAlign.start,
                          ),
                          if (t.notes != null && t.notes!.isNotEmpty)
                            Text(
                              "Notes: ${t.notes}",
                              textAlign: TextAlign.start,
                            ),
                        ],
                      ),
                      trailing: Visibility(
                        visible:
                            sl<RoleService>().isAdmin ||
                            sl<RoleService>().isDoctor,
                        child: IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder:
                                  (_) => TreatmentFormDialog(
                                    diseaseId: diseaseId,
                                    treatment: t,
                                  ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                );
              } else if (state is TreatmentError) {
                return Text("Error: ${state.message}");
              }
              return const SizedBox.shrink();
            },
          ),
        ),
        actions: [
          FutureBuilder(
            future: sl<StorageHelper>().getData(key: "Role"),
            builder: (context, snapshot) {
              if (snapshot.data == "Admin") {
                return ElevatedButton.icon(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (_) => TreatmentFormDialog(diseaseId: diseaseId),
                    );
                  },
                  icon: Icon(Icons.add),
                  label: Text("Add Treatment"),
                );
              }
              return const SizedBox.shrink();
            },
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Close"),
          ),
        ],
      ),
    );
  }
}
