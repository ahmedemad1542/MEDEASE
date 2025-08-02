import 'package:medease1/features/realChat/conversation/model/message_model.dart';

class RealChatState {
  final List<MessageModel> messages;
  final bool loading;

  RealChatState({required this.messages, required this.loading});

  RealChatState copyWith({List<MessageModel>? messages, bool? loading}) {
    return RealChatState(
      messages: messages ?? this.messages,
      loading: loading ?? this.loading,
    );
  }
}
