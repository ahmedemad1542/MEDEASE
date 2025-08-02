import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medease1/features/realChat/conversation/cubit/conversation_state.dart';
import 'package:medease1/features/realChat/conversation/model/conversation_model.dart';
import 'package:medease1/features/realChat/conversation/repo/chat_repo.dart';

class ConversationCubit extends Cubit<ConversationState> {
  final ChatRepo repo;
  ConversationCubit(this.repo) : super(ConversationInitial());

  Future<void> loadConversations(String userId) async {
    emit(ConversationLoading());
    try {
      final data = await repo.getUserConversations(userId);
      final conversations = data.map((e) => ConversationModel.fromJson(e)).toList();
      emit(ConversationLoaded(conversations));
    } catch (e) {
      emit(ConversationError(e.toString()));
    }
  }
}
