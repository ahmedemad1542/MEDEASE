abstract class AiChatState {}

class ChatInitial extends AiChatState {}

class ChatLoading extends AiChatState {}

class ChatSuccess extends AiChatState {
  final String prompt;
  final List<String> options;
  final String state;
  final String? userInput;

  ChatSuccess({
    required this.prompt,
    required this.options,
    required this.state,
    this.userInput,
  });
}

class ChatError extends AiChatState {
  final String message;

  ChatError(this.message);
}
