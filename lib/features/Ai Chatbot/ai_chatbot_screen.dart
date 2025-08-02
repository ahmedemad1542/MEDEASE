import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medease1/features/Ai%20Chatbot/cubit/aichatbot_cubit.dart';
import 'package:medease1/features/Ai%20Chatbot/cubit/aichatbot_states.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen.aiChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> messages = [];

  @override
  void initState() {
    super.initState();
    context.read<AiChatCubit>().startSession();
  }

  void _sendMessage(String text) {
    if (text.isEmpty) return;
    setState(() {
      messages.add({'role': 'user', 'text': text});
    });
    context.read<AiChatCubit>().sendMessage(text);
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff161717),
      appBar: AppBar(
        title: const Text('AI Chatbot', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xff242626),
        iconTheme: const IconThemeData(color: Colors.white), // ← هنا السحر
      ),
      body: SafeArea(
        child: BlocConsumer<AiChatCubit, AiChatState>(
          listener: (context, state) {
            if (state is ChatSuccess) {
              setState(() {
                messages.add({'role': 'bot', 'text': state.prompt});
              });
            }
          },
          builder: (context, state) {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(10),
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final msg = messages[index];
                      final isUser = msg['role'] == 'user';
                      return Align(
                        alignment:
                            isUser
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color:
                                isUser ? Color(0xff144D37) : Color(0xff242626),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            msg['text'] ?? '',
                            style: TextStyle(
                              color: isUser ? Colors.white : Colors.white,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                // ✅ عرض الاختيارات كأزرار:
                if (state is ChatSuccess && state.options.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children:
                          state.options.map((option) {
                            return ElevatedButton(
                              onPressed: () => _sendMessage(option),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(
                                  0xff144D37,
                                ), // ← لون الزرار
                                foregroundColor:
                                    Colors
                                        .white, // ← لون النص (الرقم اللي جواه)
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 12,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Text(
                                option,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            );
                          }).toList(),
                    ),
                  ),

                // ✅ صندوق الإدخال وزر الإرسال
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          style: TextStyle(color: Colors.white),
                          controller: _controller,
                          decoration: InputDecoration(
                            hintText: 'Type your message...',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 75, 170, 134),
                                width: 2.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        color: Color.fromARGB(255, 75, 170, 134),
                        icon: const Icon(Icons.send),
                        onPressed: () => _sendMessage(_controller.text.trim()),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
