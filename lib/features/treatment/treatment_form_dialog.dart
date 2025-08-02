import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'treatment_model.dart';
import 'treatment_cubit.dart';

class TreatmentFormDialog extends StatefulWidget {
  final String diseaseId;
  final TreatmentModel? treatment;

  const TreatmentFormDialog({
    super.key,
    required this.diseaseId,
    this.treatment,
  });

  @override
  State<TreatmentFormDialog> createState() => _TreatmentFormDialogState();
}

class _TreatmentFormDialogState extends State<TreatmentFormDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController nameController;
  late TextEditingController descriptionController;
  late TextEditingController dosageController;
  late TextEditingController instructionsController;
  late TextEditingController quantityController;
  late TextEditingController refillsController;
  late TextEditingController notesController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.treatment?.name ?? '');
    descriptionController = TextEditingController(
      text: widget.treatment?.description ?? '',
    );
    dosageController = TextEditingController(
      text: widget.treatment?.dosage ?? '',
    );
    instructionsController = TextEditingController(
      text: widget.treatment?.instructions ?? '',
    );
    quantityController = TextEditingController(
      text: widget.treatment?.quantity ?? '',
    );
    refillsController = TextEditingController(
      text: widget.treatment?.refills?.toString() ?? '0',
    );
    notesController = TextEditingController(
      text: widget.treatment?.notes ?? '',
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        widget.treatment == null ? 'Add Treatment' : 'Edit Treatment',
      ),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
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
              TextFormField(
                controller: dosageController,
                decoration: InputDecoration(labelText: "Dosage"),
              ),
              TextFormField(
                controller: instructionsController,
                decoration: InputDecoration(labelText: "Instructions"),
              ),
              TextFormField(
                controller: quantityController,
                decoration: InputDecoration(labelText: "Quantity"),
              ),
              TextFormField(
                controller: refillsController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: "Refills"),
              ),
              TextFormField(
                controller: notesController,
                decoration: InputDecoration(labelText: "Notes"),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              final data = {
                "name": nameController.text,
                "description": descriptionController.text,
                "dosage": dosageController.text,
                "instructions": instructionsController.text,
                "quantity": quantityController.text,
                "refills": int.tryParse(refillsController.text) ?? 0,
                "notes": notesController.text,
                "diseaseID": widget.diseaseId,
              };
              final cubit = context.read<TreatmentCubit>();
              if (widget.treatment == null) {
                cubit.createTreatment(data, widget.diseaseId);
              } else {
                cubit.updateTreatment(
                  widget.treatment!.id,
                  data,
                  widget.diseaseId,
                );
              }
              Navigator.pop(context);
            }
          },
          child: Text("Save"),
        ),
      ],
    );
  }
}
