
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/models/ChatMessage.dart';
import '../../../domain/chat_repository.dart';
import 'chat state.dart';

/// Notifier
class ChatNotifier extends StateNotifier<ChatState> {
  final ChatRepository repository;

  ChatNotifier(this.repository)
      : super(ChatState(messages: []));

  Future<void> sendMessage(String text) async {
    if (text.trim().isEmpty) return;

    final userMessage =
    ChatMessage(role: "user", content: text);

    state = state.copyWith(
      messages: [...state.messages, userMessage],
      isLoading: true,
      error: null,
    );

    try {
      final response = await repository.sendMessage(
        state.messages
            .map((e) => {
          "role": e.role,
          "content": e.content,
        })
            .toList(),
      );

      final botMessage = ChatMessage(
        role: "assistant",
        content: response,
      );

      state = state.copyWith(
        messages: [...state.messages, botMessage],
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }
}
