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