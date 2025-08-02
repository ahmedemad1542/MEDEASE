import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medease1/core/storage/storage_helper.dart';
import 'package:medease1/core/utils/my_logger.dart';
import 'package:medease1/core/utils/service_locator.dart';
import 'package:medease1/features/advertisements/getAdvertisement/cubit/advertisements_state.dart';
import 'package:medease1/features/advertisements/getAdvertisement/model/advertisements_model.dart';
import 'package:medease1/features/advertisements/getAdvertisement/repo/advertisements_repo.dart';

import '../../../../core/storage/storage_keys.dart';

class AdvertisementsCubit extends Cubit<AdvertisementsState> {
  final AdvertisementsRepo advertisementsRepo;

  AdvertisementsCubit(this.advertisementsRepo) : super(AdvertisementsInitial());
  static AdvertisementsCubit get(context) =>
      BlocProvider.of<AdvertisementsCubit>(context);

  int page = 1;
  bool hasMore = true;
  List<AdvertisementsModel> advertisements = [];
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  int totalPages = 1;

  Future<void> getAdvertisements({bool isloadMore = false}) async {
    if (!hasMore && isloadMore) return;

    if (!isloadMore) {
      page = 1;
      advertisements.clear();
      hasMore = true;
      emit(AdvertisementsLoading());
    } else {
      emit(
        Advertisementsloaded(
          advertisements,
          hasMore: hasMore,
          isLoadingMore: true,
        ),
      );
    }

    try {
      if (page <= totalPages) {
        final response = await advertisementsRepo.getAdvertisements(page: page);
        final newAdvertisements =
            response['advertisements'] as List<AdvertisementsModel>;
        totalPages = response['totalPages'] as int;
        log("totalPages: $totalPages");
        if (newAdvertisements.isEmpty && page <= totalPages) {
          hasMore = false;
        } else {
          advertisements.addAll(newAdvertisements);
          page++;
        }
      }

      emit(
        Advertisementsloaded(
          advertisements,
          hasMore: hasMore,
          isLoadingMore: false,
        ),
      );
    } on Exception catch (e) {
      emit(AdvertisementsError(e.toString()));
    }
  }

  // Update advertisement
  Future<void> updateAdvertisement({required String id}) async {
    emit(AdvertisementUpdatingLoading());
    try {
      final isUpdated = await advertisementsRepo.updateAdvertisement(
        id: id,
        title: titleController.text,
        description: descriptionController.text,
      );
      if (isUpdated) {
        MyLogger.green('Advertisement updated successfully');
        emit(AdvertisementUpdated('Advertisement updated successfully'));
        getAdvertisements();
      } else {
        MyLogger.red('Failed to update advertisement');
        emit(AdvertisementsError("Failed to update advertisement"));
      }
    } catch (e) {
      MyLogger.red('Error updating advertisement: $e');
      emit(AdvertisementsError(e.toString()));
    }
  }
}
