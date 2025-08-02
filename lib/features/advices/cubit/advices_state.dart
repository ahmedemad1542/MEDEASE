import 'package:medease1/features/advices/model/advices_model.dart';

abstract class AdviceState {}

class AdviceInitial extends AdviceState {}

class AdviceLoading extends AdviceState {}

class AdviceLoaded extends AdviceState {
  final List<AdviceModel> advices;
  AdviceLoaded(this.advices);
}

class AdviceError extends AdviceState {
  final String errormessage;
  AdviceError(this.errormessage);
}

class AdviceCreating extends AdviceState {}

class AdviceCreated extends AdviceState {
  final String message;
  AdviceCreated(this.message);
}

class AdviceUpdated extends AdviceState {}

class AdviceDeleted extends AdviceState {}

class AdviceLikeSuccess extends AdviceState {}

class AdviceDislikeSuccess extends AdviceState {}

class AdviceCreatingError extends AdviceState {
  final String message;
  AdviceCreatingError(this.message);
}
