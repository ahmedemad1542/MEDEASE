import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:medease1/core/routing/app_routes.dart';
import 'package:medease1/core/utils/role_service.dart';
import 'package:medease1/core/utils/service_locator.dart';
import 'package:medease1/features/advertisements/getAdvertisement/cubit/advertisements_cubit.dart';
import 'package:medease1/features/advertisements/getAdvertisement/cubit/advertisements_state.dart';

class AdvertisementScreen extends StatelessWidget {
  const AdvertisementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Advertisements")),
      body: BlocConsumer<AdvertisementsCubit, AdvertisementsState>(
        listener: (context, state) {
          if (state is AdvertisementsError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
          if (state is AdvertisementUpdated) {
            context.pop();
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          var cubit = AdvertisementsCubit.get(context);
          if (state is AdvertisementsLoading ||
              state is AdvertisementUpdatingLoading) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 10),
                  Text("Loading advertisements..."),
                ],
              ),
            );
          } else if (state is Advertisementsloaded) {
            return NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification notification) {
                if (notification is ScrollEndNotification &&
                    notification.metrics.pixels >=
                        notification.metrics.maxScrollExtent * 0.8) {
                  log("scrolled to bottom");
                  context.read<AdvertisementsCubit>().getAdvertisements(
                    isloadMore: true,
                  );
                }
                return true;
              },
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: state.advertisements.length,
                itemBuilder: (context, index) {
                  final advertisement = state.advertisements[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 8.0,
                    ),
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              advertisement.title,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              advertisement.description,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              advertisement.creatorName,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.indigoAccent,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Created At: ${DateFormat('dd/MM/yyyy').format(advertisement.createdAt)}',
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Visibility(
                              visible: sl<RoleService>().isAdmin,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                  onPressed: () {
                                    context.pushReplacement(
                                      AppRoutes.deleteAdvertisementScreen,
                                      extra: advertisement.id,
                                    );
                                  },
                                  child: const Text(
                                    "Delete",
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),
                              ),
                            ),
                            Visibility(
                              visible: sl<RoleService>().isAdmin,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                  onPressed: () {
                                    cubit.titleController.text =
                                        advertisement.title;
                                    cubit.descriptionController.text =
                                        advertisement.description;
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: const Text(
                                            "Update Advertisement",
                                          ),
                                          content: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              TextField(
                                                controller:
                                                    cubit.titleController,
                                                decoration:
                                                    const InputDecoration(
                                                      hintText:
                                                          "Enter new Title",
                                                      border:
                                                          OutlineInputBorder(),
                                                    ),
                                              ),
                                              const SizedBox(height: 10),
                                              TextField(
                                                maxLines: 5,
                                                controller:
                                                    cubit.descriptionController,
                                                decoration: const InputDecoration(
                                                  hintText:
                                                      "Enter new description",
                                                  border: OutlineInputBorder(),
                                                ),
                                              ),
                                            ],
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed:
                                                  () => Navigator.pop(context),
                                              child: const Text("Cancel"),
                                            ),
                                            BlocProvider.value(
                                              value: cubit,
                                              child: Builder(
                                                builder: (context) {
                                                  return BlocBuilder<
                                                    AdvertisementsCubit,
                                                    AdvertisementsState
                                                  >(
                                                    builder: (context, state) {
                                                      return TextButton(
                                                        onPressed: () {
                                                          cubit.updateAdvertisement(
                                                            id:
                                                                advertisement
                                                                    .id,
                                                          );
                                                        },
                                                        child:
                                                            state
                                                                    is AdvertisementUpdatingLoading
                                                                ? CircularProgressIndicator()
                                                                : const Text(
                                                                  "Update",
                                                                ),
                                                      );
                                                    },
                                                  );
                                                },
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  child: const Text(
                                    "Update",
                                    style: TextStyle(color: Colors.green),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          } else {
            return const Center(
              child: Text(
                'No advertisements found.',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            );
          }
        },
      ),
    );
  }
}
