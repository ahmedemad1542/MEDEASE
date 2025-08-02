import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medease1/core/utils/service_locator.dart';
import 'package:medease1/features/advices/cubit/advices_cubit.dart';
import 'package:medease1/features/advices/cubit/advices_state.dart';
import 'package:medease1/features/advices/model/advices_model.dart';

import '../../core/utils/role_service.dart';

class AdviceScreen extends StatefulWidget {
  const AdviceScreen({super.key});

  @override
  State<AdviceScreen> createState() => _AdviceScreenState();
}

class _AdviceScreenState extends State<AdviceScreen> {
  String? selectedCategory;
  Map<String, bool> likedAdvice = {};
  Map<String, bool> dislikedAdvice = {};

  @override
  void initState() {
    super.initState();
    context.read<AdviceCubit>().getAdvices();
  }

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<AdviceCubit>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Advices', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
        actions: [
          BlocBuilder<AdviceCubit, AdviceState>(
            builder: (context, state) {
              return Visibility(
                visible:
                    sl<RoleService>().isAdmin || sl<RoleService>().isDoctor,
                child: IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Create Advice'),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextField(
                                controller: cubit.titleController,
                                decoration: const InputDecoration(
                                  labelText: 'Title',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(8),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 8),
                              SizedBox(
                                width: double.infinity,
                                child: DropdownMenu(
                                  hintText: 'Select Category',
                                  expandedInsets: EdgeInsets.zero,

                                  dropdownMenuEntries:
                                      cubit.categories
                                          .map(
                                            (category) => DropdownMenuEntry(
                                              value: category,
                                              label: category.name,
                                            ),
                                          )
                                          .toList(),
                                  onSelected: (value) {
                                    cubit.selectedCategory = value;
                                  },
                                ),
                              ),
                              SizedBox(height: 8),
                              TextField(
                                controller: cubit.descriptionController,
                                decoration: const InputDecoration(
                                  labelText: 'Description',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(8),
                                    ),
                                  ),
                                ),
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 12,
                                ),
                                maxLines: 5,
                              ),
                            ],
                          ),
                          actions: [
                            TextButton(
                              onPressed: () async {
                                if (cubit.titleController.text.isEmpty ||
                                    cubit.selectedCategory == null ||
                                    cubit.descriptionController.text.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Please fill all fields'),
                                    ),
                                  );
                                  return;
                                } else {
                                  await cubit.createAdvice(
                                    diseasesCategoryId:
                                        cubit.selectedCategory!.categoryId,
                                    title: cubit.titleController.text,
                                    description:
                                        cubit.descriptionController.text,
                                  );
                                  cubit.titleController.clear();
                                  cubit.descriptionController.clear();
                                  cubit.selectedCategory = null;
                                  if (context.mounted)
                                    Navigator.of(context).pop();
                                }
                              },
                              child: const Text('Create'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  icon: Icon(Icons.add),
                ),
              );
            },
          ),
        ],
      ),
      body: BlocConsumer<AdviceCubit, AdviceState>(
        listener: (context, state) {
          if (state is AdviceCreated) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text('${state.message}')));
          } else if (state is AdviceCreatingError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text('Error: ${state.message}')));
          }
        },
        builder: (context, state) {
          return BlocBuilder<AdviceCubit, AdviceState>(
            builder: (context, state) {
              if (state is AdviceLoading || state is AdviceCreating) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is AdviceLoaded) {
                final categories =
                    state.advices
                        .map((e) => e.diseasesCategoryName)
                        .toSet()
                        .toList();

                return ListView(
                  padding: const EdgeInsets.all(12),
                  children: [
                    ...categories.map(
                      (category) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            tileColor: Colors.green,
                            title: Text(
                              category,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            trailing: Icon(
                              selectedCategory == category
                                  ? Icons.expand_less
                                  : Icons.expand_more,
                            ),
                            onTap: () {
                              setState(
                                () =>
                                    selectedCategory =
                                        selectedCategory == category
                                            ? null
                                            : category,
                              );
                            },
                          ),
                          SizedBox(height: 25),
                          if (selectedCategory == category)
                            ...state.advices
                                .where(
                                  (e) => e.diseasesCategoryName == category,
                                )
                                .map(
                                  (advice) => Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    elevation: 3,
                                    margin: const EdgeInsets.symmetric(
                                      vertical: 6,
                                      horizontal: 12,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            advice.title,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          Text(advice.description),
                                          const SizedBox(height: 12),
                                          Visibility(
                                            visible:
                                                sl<RoleService>().isAdmin ||
                                                sl<RoleService>().isDoctor,
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: ElevatedButton(
                                                    style:
                                                        ElevatedButton.styleFrom(
                                                          backgroundColor:
                                                              Colors.blue,
                                                        ),
                                                    onPressed: () {
                                                      cubit
                                                          .titleController
                                                          .text = advice.title;
                                                      cubit
                                                          .descriptionController
                                                          .text = advice
                                                              .description;
                                                      cubit
                                                          .selectedCategory = cubit
                                                          .categories
                                                          .firstWhere(
                                                            (category) =>
                                                                category.name ==
                                                                advice
                                                                    .diseasesCategoryName,
                                                          );
                                                      showDialog(
                                                        context: context,
                                                        builder: (context) {
                                                          return AlertDialog(
                                                            title: const Text(
                                                              'Edit Advice',
                                                            ),
                                                            content: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: [
                                                                TextField(
                                                                  controller:
                                                                      cubit
                                                                          .titleController,
                                                                  decoration: const InputDecoration(
                                                                    labelText:
                                                                        'Title',
                                                                    border: OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius.all(
                                                                            Radius.circular(
                                                                              8,
                                                                            ),
                                                                          ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 8,
                                                                ),
                                                                SizedBox(
                                                                  width:
                                                                      double
                                                                          .infinity,
                                                                  child: DropdownMenu(
                                                                    hintText:
                                                                        'Select Category',
                                                                    expandedInsets:
                                                                        EdgeInsets
                                                                            .zero,

                                                                    dropdownMenuEntries:
                                                                        cubit
                                                                            .categories
                                                                            .map(
                                                                              (
                                                                                category,
                                                                              ) => DropdownMenuEntry(
                                                                                value:
                                                                                    category,
                                                                                label:
                                                                                    category.name,
                                                                              ),
                                                                            )
                                                                            .toList(),
                                                                    onSelected: (
                                                                      value,
                                                                    ) {
                                                                      cubit.selectedCategory =
                                                                          value;
                                                                    },
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 8,
                                                                ),
                                                                TextField(
                                                                  controller:
                                                                      cubit
                                                                          .descriptionController,
                                                                  decoration: const InputDecoration(
                                                                    labelText:
                                                                        'Description',
                                                                    border: OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius.all(
                                                                            Radius.circular(
                                                                              8,
                                                                            ),
                                                                          ),
                                                                    ),
                                                                  ),
                                                                  style: TextStyle(
                                                                    color:
                                                                        Colors
                                                                            .grey
                                                                            .shade600,
                                                                    fontSize:
                                                                        12,
                                                                  ),
                                                                  maxLines: 5,
                                                                ),
                                                              ],
                                                            ),
                                                            actions: [
                                                              TextButton(
                                                                onPressed: () async {
                                                                  if (cubit
                                                                          .titleController
                                                                          .text
                                                                          .isEmpty ||
                                                                      cubit.selectedCategory ==
                                                                          null ||
                                                                      cubit
                                                                          .descriptionController
                                                                          .text
                                                                          .isEmpty) {
                                                                    ScaffoldMessenger.of(
                                                                      context,
                                                                    ).showSnackBar(
                                                                      const SnackBar(
                                                                        content:
                                                                            Text(
                                                                              'Please fill all fields',
                                                                            ),
                                                                      ),
                                                                    );
                                                                    return;
                                                                  } else {
                                                                    await cubit.updateAdvice(
                                                                      adviceId:
                                                                          advice
                                                                              .id,
                                                                      diseasesCategoryId:
                                                                          cubit
                                                                              .selectedCategory!
                                                                              .categoryId,
                                                                      title:
                                                                          cubit
                                                                              .titleController
                                                                              .text,
                                                                      description:
                                                                          cubit
                                                                              .descriptionController
                                                                              .text,
                                                                    );
                                                                    cubit
                                                                        .titleController
                                                                        .clear();
                                                                    cubit
                                                                        .descriptionController
                                                                        .clear();
                                                                    cubit.selectedCategory =
                                                                        null;
                                                                    if (context
                                                                        .mounted)
                                                                      Navigator.of(
                                                                        context,
                                                                      ).pop();
                                                                  }
                                                                },
                                                                child:
                                                                    const Text(
                                                                      'Edit',
                                                                    ),
                                                              ),
                                                            ],
                                                          );
                                                        },
                                                      );
                                                    },
                                                    child: Text(
                                                      'Edit',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(width: 8),
                                                Expanded(
                                                  child: ElevatedButton(
                                                    style:
                                                        ElevatedButton.styleFrom(
                                                          backgroundColor:
                                                              Colors.red,
                                                        ),
                                                    onPressed: () async {
                                                      showDialog(
                                                        context: context,
                                                        builder: (context) {
                                                          return AlertDialog(
                                                            title: const Text(
                                                              'Delete Advice',
                                                            ),
                                                            content: const Text(
                                                              'Are you sure you want to delete this advice?',
                                                            ),
                                                            actions: [
                                                              TextButton(
                                                                onPressed: () {
                                                                  Navigator.of(
                                                                    context,
                                                                  ).pop();
                                                                },
                                                                child:
                                                                    const Text(
                                                                      'Cancel',
                                                                    ),
                                                              ),
                                                              TextButton(
                                                                onPressed: () async {
                                                                  await cubit
                                                                      .deleteAdvice(
                                                                        advice
                                                                            .id,
                                                                      );
                                                                  Navigator.of(
                                                                    context,
                                                                  ).pop();
                                                                },
                                                                child:
                                                                    const Text(
                                                                      'Delete',
                                                                    ),
                                                              ),
                                                            ],
                                                          );
                                                        },
                                                      );
                                                    },
                                                    child: Text(
                                                      'Delete',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Visibility(
                                            visible:
                                                sl<RoleService>().isPatient,
                                            child: Row(
                                              children: [
                                                IconButton(
                                                  icon: Icon(
                                                    Icons.thumb_up,
                                                    color:
                                                        likedAdvice[advice
                                                                    .id] ==
                                                                true
                                                            ? Colors.green
                                                            : Colors.grey,
                                                  ),
                                                  onPressed: () async {
                                                    await context
                                                        .read<AdviceCubit>()
                                                        .likeAdvice(advice.id);
                                                    setState(() {
                                                      likedAdvice[advice.id] =
                                                          true;
                                                      dislikedAdvice[advice
                                                              .id] =
                                                          false;
                                                    });
                                                    ScaffoldMessenger.of(
                                                      context,
                                                    ).showSnackBar(
                                                      const SnackBar(
                                                        content: Text(
                                                          "Liked successfully",
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                                IconButton(
                                                  icon: Icon(
                                                    Icons.thumb_down,
                                                    color:
                                                        dislikedAdvice[advice
                                                                    .id] ==
                                                                true
                                                            ? Colors.red
                                                            : Colors.grey,
                                                  ),
                                                  onPressed: () async {
                                                    await context
                                                        .read<AdviceCubit>()
                                                        .dislikeAdvice(
                                                          advice.id,
                                                        );
                                                    setState(() {
                                                      dislikedAdvice[advice
                                                              .id] =
                                                          true;
                                                      likedAdvice[advice.id] =
                                                          false;
                                                    });
                                                    ScaffoldMessenger.of(
                                                      context,
                                                    ).showSnackBar(
                                                      const SnackBar(
                                                        content: Text(
                                                          "Disliked successfully",
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                        ],
                      ),
                    ),
                  ],
                );
              } else if (state is AdviceError) {
                return Center(child: Text('Error: ${state.errormessage}'));
              }
              return const SizedBox.shrink();
            },
          );
        },
      ),
    );
  }
}
