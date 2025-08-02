import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'disease_cubit.dart';
import 'disease_model.dart';

class DiseaseFormDialog extends StatefulWidget {
  final DiseaseModel? disease;
  final DiseaseCubit cubit;
  const DiseaseFormDialog({super.key, this.disease, required this.cubit});

  @override
  State<DiseaseFormDialog> createState() => _DiseaseFormDialogState();
}

class _DiseaseFormDialogState extends State<DiseaseFormDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController nameController;
  late TextEditingController descriptionController;
  late TextEditingController categoryIdController;

  String? selectedRank;

  final List<String> ranks = ["mild", "moderate", "severe", "critical"];

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.disease?.name ?? "");
    descriptionController = TextEditingController(
      text: widget.disease?.description ?? "",
    );
    selectedRank = widget.disease?.rank;
    categoryIdController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.disease == null ? "Add Disease" : "Edit Disease"),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(labelText: "Name"),
                validator: (val) => val!.isEmpty ? "Enter name" : null,
              ),
              TextFormField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: "Description"),
                validator: (val) => val!.isEmpty ? "Enter description" : null,
              ),
              DropdownButtonFormField<String>(
                value: selectedRank,
                items:
                    ranks
                        .map(
                          (rank) => DropdownMenuItem(
                            value: rank,
                            child: Text(
                              rank[0].toUpperCase() + rank.substring(1),
                            ),
                          ),
                        )
                        .toList(),
                decoration: InputDecoration(labelText: "Rank"),
                validator:
                    (val) => val == null || val.isEmpty ? "Select rank" : null,
                onChanged: (val) {
                  setState(() {
                    selectedRank = val;
                  });
                },
              ),
              if (widget.disease == null)
                TextFormField(
                  controller: categoryIdController,
                  decoration: InputDecoration(
                    labelText: "Category ID",
                    helperText: "685e4f54d49a597823733c87",
                  ),
                  validator: (val) => val!.isEmpty ? "Enter Category ID" : null,
                ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          child: Text("Cancel"),
          onPressed: () => Navigator.pop(context),
        ),
        ElevatedButton(
          child: Text("Save"),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              if (widget.disease == null) {
                // create
                context.read<DiseaseCubit>().createDisease(
                  name: nameController.text,
                  description: descriptionController.text,
                  rank: selectedRank!,
                  diseaseCategoryId: categoryIdController.text,
                );
              } else {
                // update
                context.read<DiseaseCubit>().updateDisease(
                  diseaseId: widget.disease!.id,
                  name: nameController.text,
                  description: descriptionController.text,
                  rank: selectedRank!,
                );
              }
              Navigator.pop(context);
            }
          },
        ),
      ],
    );
  }
}
