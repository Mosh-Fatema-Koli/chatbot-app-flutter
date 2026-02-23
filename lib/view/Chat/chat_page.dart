import 'package:boilerplate_of_cubit/view/Chat/provider/chat_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class ChatPage extends ConsumerWidget {
  ChatPage({super.key});

  final TextEditingController controller =
  TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(chatProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("AI Chat")),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: state.messages.length,
              itemBuilder: (context, index) {
                final message =
                state.messages[index];

                final isUser =
                    message.role == "user";

                return Align(
                  alignment: isUser
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: isUser
                          ? Colors.blue
                          : Colors.grey[300],
                      borderRadius:
                      BorderRadius.circular(12),
                    ),
                    child: Text(
                      message.content,
                      style: TextStyle(
                        color: isUser
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          if (state.isLoading)
            const Padding(
              padding: EdgeInsets.all(8),
              child: CircularProgressIndicator(),
            ),

          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  decoration: const InputDecoration(
                    hintText: "Type message...",
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.send),
                onPressed: () {
                  ref
                      .read(chatProvider.notifier)
                      .sendMessage(controller.text);
                  controller.clear();
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}