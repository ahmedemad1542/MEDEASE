import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medease1/features/advertisements/deleteAdvertisement/cubit/delete_advertisement_cubit.dart';
import 'package:medease1/features/advertisements/deleteAdvertisement/cubit/delete_advertisement_state.dart';

class DeleteAdvertisementScreen extends StatelessWidget {
  final String advertisementsId;
  const DeleteAdvertisementScreen({super.key, required this.advertisementsId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Delete Advertisement")),
      body: BlocConsumer<DeleteAdvertisementCubit, DeleteAdvertisementState>(
        listener: (context, state) {
          if (state is DeleteAdvertisementError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
          if (state is DeleteAdvertisementSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Advertisement deleted successfully')),
            );
          }
        },
        builder: (context, state) {
          if (state is DeleteAdvertisementLoading) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 10),
                  Text("Deleting advertisement..."),
                ],
              ),
            );
          } else if (state is DeleteAdvertisementSuccess) {
            return const Center(
              child: Text("Advertisement deleted successfully"),
            );
          }
          return Container();
        },
      ),
    );
  }
}
