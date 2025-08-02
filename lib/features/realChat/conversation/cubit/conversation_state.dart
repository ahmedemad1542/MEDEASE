// conversation_state.dart
import 'package:medease1/features/realChat/conversation/model/conversation_model.dart';

abstract class ConversationState {}

class ConversationInitial extends ConversationState {}

class ConversationLoading extends ConversationState {}

class ConversationLoaded extends ConversationState {
  final List<ConversationModel> conversations;
  ConversationLoaded(this.conversations);
}

class ConversationError extends ConversationState {
  final String error;
  ConversationError(this.error);
}
