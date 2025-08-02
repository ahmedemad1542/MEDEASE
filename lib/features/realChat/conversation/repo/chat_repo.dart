import 'package:medease1/core/networking/api_endpoints.dart';
import 'package:medease1/core/networking/dio_helper.dart';

class ChatRepo {
  final DioHelper dioHelper;

  ChatRepo({required this.dioHelper});

  // 1. Get all conversations for user
  Future<List> getUserConversations(String userId) async {
    final response = await dioHelper.getResponse(
      endpoint: ApiEndpoints.getUserConversations(userId),
    );
    return response?.data ?? [];
  }

  // 2. Get messages for a conversation
  Future<List> getMessages(String conversationId) async {
    final response = await dioHelper.getResponse(
      endpoint: ApiEndpoints.getConversationMessages(conversationId),
    );
    return response?.data ?? [];
  }

  // 3. Send message
  Future<void> sendMessage({
    required String conversationId,
    required String senderId,
    required String text,
  }) async {
    await dioHelper.postRequest(
      endpoint: ApiEndpoints.sendMessage,
      data: {
        'conversationId': conversationId,
        'sender': senderId,
        'text': text,
      },
    );
  }

  // 4. Create new conversation
  Future<void> createConversation({
    required String senderId,
    required String receiverId,
  }) async {
    await dioHelper.postRequest(
      endpoint: ApiEndpoints.createConversation,
      data: {
        'senderId': senderId,
        'receiverId': receiverId,
      },
    );
  }
}
