
abstract class ChatRepository {
  Future<String> sendMessage(List<Map<String, String>> messages);
}