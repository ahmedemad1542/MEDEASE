import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medease1/features/realChat/chats/cubit/realchat_state.dart';
import 'package:medease1/features/realChat/conversation/model/message_model.dart';
import 'package:medease1/features/realChat/conversation/repo/chat_repo.dart';

class RealChatCubit extends Cubit<RealChatState> {
  final ChatRepo chatRepo;

  RealChatCubit(this.chatRepo)
    : super(RealChatState(messages: [], loading: false));

  Future<void> loadMessages(String conversationId) async {
    emit(state.copyWith(loading: true));
    final data = await chatRepo.getMessages(conversationId);
    final messages =
        data.map((e) => MessageModel.fromJson(e)).toList().reversed.toList();
    emit(state.copyWith(messages: messages, loading: false));
  }

  Future<void> sendMessage(String convId, String senderId, String text) async {
    await chatRepo.sendMessage(
      conversationId: convId,
      senderId: senderId,
      text: text,
    );
    await loadMessages(convId);
  }
}
