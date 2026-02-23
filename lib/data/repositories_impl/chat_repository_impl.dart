
import '../../domain/chat_repository.dart';
import '../data_sources/api_core/api.dart';


class ChatRepositoryImpl implements ChatRepository {
  final API api;
  final String apiKey;

  ChatRepositoryImpl({
    required this.api,
    required this.apiKey,
  });

  @override
  Future<String> sendMessage(
      List<Map<String, String>> messages) async {

    final response = await api.sendChatMessage(
      apiKey: apiKey,
      messages: messages,
    );

    if (response["Success"] == true) {
      return response["Packet"];
    } else {
      throw Exception(response["Message"]);
    }
  }
}