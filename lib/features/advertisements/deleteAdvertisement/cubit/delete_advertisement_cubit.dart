import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medease1/features/advertisements/deleteAdvertisement/cubit/delete_advertisement_state.dart';
import 'package:medease1/features/advertisements/deleteAdvertisement/repo/delete_advertisement_repo.dart';

class DeleteAdvertisementCubit extends Cubit<DeleteAdvertisementState> {
  final DeleteAdvertisementRepo deleteAdvertisementRepo;
  DeleteAdvertisementCubit(this.deleteAdvertisementRepo)
    : super(DeleteAdvertisementInitial());

  void deleteAdvertisement({required String id}) async {
    emit(DeleteAdvertisementLoading());
    final Either<String, dynamic> response = await deleteAdvertisementRepo
        .deleteAdvertisement(id: id);

    response.fold(
      (error) => emit(DeleteAdvertisementError(error.toString())),
      (data) => emit(DeleteAdvertisementSuccess()),
    );
  }
}
