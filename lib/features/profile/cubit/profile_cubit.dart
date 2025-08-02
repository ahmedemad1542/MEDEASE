import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medease1/features/profile/repo/profile_repo.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepo repo;
  ProfileCubit(this.repo) : super(ProfileInitial());

  void fetchProfile() async {
    emit(ProfileLoading());
    final userData = await repo.getUser();

    userData.fold(
      (error) => emit(ProfileError(error)),
      (user) => emit(ProfileLoaded(user)),
    );
  }
}
