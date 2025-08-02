import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medease1/core/networking/api_endpoints.dart';
import 'package:medease1/core/networking/dio_helper.dart';
import 'package:medease1/core/utils/service_locator.dart';
import 'package:medease1/features/Ai%20Chatbot/cubit/aichatbot_states.dart';

class AiChatCubit extends Cubit<AiChatState> {
  AiChatCubit() : super(ChatInitial());

  final Dio dio = DioHelper.dio!;
  String? sessionId;

  Future<void> startSession() async {
    emit(ChatLoading());
    try {
      final res = await dio.post(ApiEndpoints.aiStartSession);
      sessionId = res.data['data']['session_id'];

      emit(
        ChatSuccess(
          prompt: res.data['data']['prompt'],
          options: List<String>.from(res.data['data']['options']),
          state: res.data['data']['state'],
          userInput: null,
        ),
      );
    } catch (e) {
      emit(ChatError('Failed to start session: $e'));
    }
  }

  Future<void> sendMessage(String userInput) async {
    if (sessionId == null) {
      emit(ChatError('Session ID is null. Cannot send message.'));
      return;
    }

    emit(ChatLoading());
    try {
      final res = await dio.post(
        ApiEndpoints.aiSendMessage,
        data: {'session_id': sessionId, 'user_input': userInput},
      );

      emit(
        ChatSuccess(
          prompt: res.data['data']['prompt'],
          options: List<String>.from(res.data['data']['options']),
          state: res.data['data']['state'],
          userInput: userInput,
        ),
      );
    } catch (e) {
      emit(ChatError('Failed to send message: $e'));
    }
  }

  Future<List<String>> getSymptoms() async {
    try {
      final res = await dio.get(ApiEndpoints.aiGetSymptoms);
      return List<String>.from(res.data['data']['symptoms']);
    } catch (e) {
      return [];
    }
  }
}
