// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:medease1/core/utils/service_locator.dart';
// import 'package:medease1/core/utils/storage_helper.dart';
// import 'package:medease1/features/disease/disease_cubit.dart';
// import 'package:medease1/features/disease/disease_form_dialog.dart';
// import 'package:medease1/features/disease/disease_repo.dart';
// import 'package:medease1/features/treatment/treatment_dialog.dart';

// class DiseasesPage extends StatefulWidget {
//   const DiseasesPage({super.key});

//   @override
//   State<DiseasesPage> createState() => _DiseasesPageState();
// }

// class _DiseasesPageState extends State<DiseasesPage> {
//   bool isAdmin = false;

//   @override
//   void initState() {
//     super.initState();
//     loadRole();
//   }

//   Future<void> loadRole() async {
//     final role = await sl<StorageHelper>().getData(key: "Role");
//     setState(() {
//       isAdmin = role == "Admin";
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => DiseaseCubit(sl<DiseaseRepo>())..fetchDiseases(),
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text("Diseases"),
//           backgroundColor: Colors.blueAccent[800],
//           actions: [
//             if (isAdmin)
//               IconButton(
//                 icon: Icon(Icons.add),
//                 onPressed: () {
//                   showDialog(
//                     context: context,
//                     builder:
//                         (context) => DiseaseFormDialog(
//                           cubit: context.read<DiseaseCubit>(),
//                         ),
//                   );
//                 },
//               ),
//           ],
//         ),
//         body: BlocBuilder<DiseaseCubit, DiseaseState>(
//           builder: (context, state) {
//             if (state is DiseaseLoading) {
//               return Center(child: CircularProgressIndicator());
//             } else if (state is DiseaseLoaded) {
//               return ListView.builder(
//                 itemCount: state.diseases.length,
//                 itemBuilder: (context, index) {
//                   final disease = state.diseases[index];
//                   return GestureDetector(
//                     onTap: () {
//                       //todo: show disease treatment details
//                       showDialog(
//                         context: context,
//                         builder:
//                             (_) => TreatmentDialog(
//                               diseaseId: disease.id,
//                               diseaseName: disease.name,
//                             ),
//                       );
//                     },

//                     onLongPress: () {
//                       if (isAdmin) {
//                         showDialog(
//                           context: context,
//                           builder:
//                               (context) => DiseaseFormDialog(
//                                 cubit: context.read<DiseaseCubit>(),
//                                 disease: disease,
//                               ),
//                         );
//                       } else {
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           SnackBar(
//                             content: Text("You are not authorized to edit."),
//                           ),
//                         );
//                       }
//                     },
//                     child: SizedBox(
//                       width: double.infinity,
//                       child: Card(
//                         elevation: 4,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(16),
//                         ),
//                         margin: EdgeInsets.symmetric(
//                           horizontal: 16,
//                           vertical: 8,
//                         ),
//                         child: Padding(
//                           padding: const EdgeInsets.all(16.0),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 disease.name,
//                                 style: TextStyle(
//                                   fontSize: 20,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.blueAccent[800],
//                                 ),
//                               ),

//                               if (isAdmin)
//                                 IconButton(
//                                   icon: Icon(Icons.delete, color: Colors.red),
//                                   onPressed: () {
//                                     showDialog(
//                                       context: context,
//                                       builder:
//                                           (context) => AlertDialog(
//                                             title: Text("Confirm Delete"),
//                                             content: Text(
//                                               "Are you sure you want to delete this disease?",
//                                             ),
//                                             actions: [
//                                               TextButton(
//                                                 onPressed: () {
//                                                   Navigator.pop(context);
//                                                 },
//                                                 child: Text("Cancel"),
//                                               ),
//                                               ElevatedButton(
//                                                 onPressed: () {
//                                                   context
//                                                       .read<DiseaseCubit>()
//                                                       .deleteDisease(
//                                                         disease.id,
//                                                       );
//                                                   Navigator.pop(context);
//                                                   setState(() {
//                                                     state.diseases.removeWhere(
//                                                       (d) => d.id == disease.id,
//                                                     );
//                                                   });
//                                                   ScaffoldMessenger.of(
//                                                     context,
//                                                   ).showSnackBar(
//                                                     SnackBar(
//                                                       content: Text(
//                                                         "Disease deleted successfully.",
//                                                       ),
//                                                     ),
//                                                   );
//                                                 },
//                                                 child: Text("Delete"),
//                                               ),
//                                             ],
//                                           ),
//                                     );
//                                   },
//                                 ),

//                               SizedBox(height: 8),
//                               Text(
//                                 disease.description,
//                                 style: TextStyle(
//                                   fontSize: 16,
//                                   color: Colors.grey[700],
//                                 ),
//                               ),

//                               SizedBox(height: 8),
//                               Text(
//                                 "Rank: ${disease.rank}",
//                                 style: TextStyle(
//                                   fontSize: 14,
//                                   color: Colors.grey[600],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               );
//             } else if (state is DiseaseError) {
//               return Center(child: Text("Error: ${state.error}"));
//             }
//             return Container();
//           },
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:medease1/core/utils/role_service.dart';
import 'package:medease1/core/utils/service_locator.dart';
import 'package:medease1/features/disease/disease_cubit.dart';
import 'package:medease1/features/disease/disease_form_dialog.dart';
import 'package:medease1/features/disease/disease_repo.dart';
import 'package:medease1/features/treatment/treatment_dialog.dart';

import '../../core/storage/storage_helper.dart';

class DiseasesPage extends StatefulWidget {
  const DiseasesPage({super.key});

  @override
  State<DiseasesPage> createState() => _DiseasesPageState();
}

class _DiseasesPageState extends State<DiseasesPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DiseaseCubit(sl<DiseaseRepo>())..fetchDiseases(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Diseases"),
          backgroundColor: Colors.blueAccent[800],
          actions: [
            if (sl<RoleService>().isAdmin || sl<RoleService>().isDoctor)
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: IconButton(
                  icon: Icon(Icons.add),
                  iconSize: 30,
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder:
                          (context) => DiseaseFormDialog(
                            cubit: context.read<DiseaseCubit>(),
                          ),
                    );
                  },
                ),
              ),
          ],
        ),
        body: BlocBuilder<DiseaseCubit, DiseaseState>(
          builder: (context, state) {
            if (state is DiseaseLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is DiseaseLoaded) {
              return ListView.builder(
                itemCount: state.diseases.length,
                itemBuilder: (context, index) {
                  final disease = state.diseases[index];
                  return Slidable(
                    key: Key(disease.id),
                    endActionPane: ActionPane(
                      motion: ScrollMotion(),
                      children: [
                        if (sl<RoleService>().isAdmin ||
                            sl<RoleService>().isDoctor) ...[
                          SlidableAction(
                            onPressed: (_) {
                              showDialog(
                                context: context,
                                builder:
                                    (context) => DiseaseFormDialog(
                                      cubit: context.read<DiseaseCubit>(),
                                      disease: disease,
                                    ),
                              );
                            },
                            backgroundColor: Colors.blue,
                            icon: Icons.edit,
                            // label: 'تعديل',
                          ),
                          SlidableAction(
                            onPressed: (_) {
                              showDialog(
                                context: context,
                                builder:
                                    (context) => AlertDialog(
                                      title: Text("Confirm Delete"),
                                      content: Text(
                                        "Are you sure you want to delete this disease?",
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed:
                                              () => Navigator.pop(context),
                                          child: Text("Cancel"),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            context
                                                .read<DiseaseCubit>()
                                                .deleteDisease(disease.id);
                                            Navigator.pop(context);
                                            setState(() {
                                              state.diseases.removeWhere(
                                                (d) => d.id == disease.id,
                                              );
                                            });
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  "Disease deleted successfully.",
                                                ),
                                              ),
                                            );
                                          },
                                          child: Text("Delete"),
                                        ),
                                      ],
                                    ),
                              );
                            },
                            backgroundColor: Colors.red,
                            icon: Icons.delete,
                            // label: 'حذف',
                          ),
                        ],
                        SlidableAction(
                          onPressed: (_) {
                            showDialog(
                              context: context,
                              builder:
                                  (_) => TreatmentDialog(
                                    diseaseId: disease.id,
                                    diseaseName: disease.name,
                                  ),
                            );
                          },
                          backgroundColor: Colors.green,
                          icon: Icons.medical_services,
                          // label: 'العلاجات',
                        ),
                      ],
                    ),
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              disease.name,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.blueAccent[800],
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              disease.description,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[700],
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              "Rank: ${disease.rank}",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            } else if (state is DiseaseError) {
              return Center(child: Text("Error: ${state.error}"));
            }
            return Container();
          },
        ),
      ),
    );
  }
}
