import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/data_sources/api_core/api.dart';
import '../../../data/models/ChatMessage.dart';
import '../../../data/repositories_impl/chat_repository_impl.dart';
import '../../../domain/chat_repository.dart';
import 'chat state.dart';
import 'chat_notifier.dart';


/// API Provider
final apiProvider = Provider<API>((ref) {
  return API();
});

/// Repository Provider (Abstraction Layer)
final chatRepositoryProvider =
Provider<ChatRepository>((ref) {
  return ChatRepositoryImpl(
    api: ref.read(apiProvider),
    apiKey: "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",
  );
});


/// Final Provider
final chatProvider =
StateNotifierProvider<ChatNotifier, ChatState>((ref) {
  return ChatNotifier(
    ref.read(chatRepositoryProvider),
  );
});