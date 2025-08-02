abstract class DeleteAdvertisementState {}

class DeleteAdvertisementInitial extends DeleteAdvertisementState {}

class DeleteAdvertisementLoading extends DeleteAdvertisementState {}

class DeleteAdvertisementError extends DeleteAdvertisementState {
  final String message;
  DeleteAdvertisementError(this.message);
}

class DeleteAdvertisementSuccess extends DeleteAdvertisementState {}
