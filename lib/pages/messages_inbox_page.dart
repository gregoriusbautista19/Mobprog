import 'package:flutter/material.dart';
import '../models/conversation.dart';
import 'chat_detail_page.dart';

class MessagesInboxPage extends StatelessWidget {
  const MessagesInboxPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pesan Masuk"),
      ),
      body: ListView.builder(
        itemCount: dummyConversations.length,
        itemBuilder: (context, index) {
          final conversation = dummyConversations[index];
          return Column(
            children: [
              ListTile(
                leading: CircleAvatar(
                  radius: 28,
                  backgroundImage: AssetImage(conversation.buyerImageUrl),
                ),
                title: Text(conversation.buyerName, style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text(
                  conversation.lastMessage,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "${conversation.timestamp.hour}:${conversation.timestamp.minute.toString().padLeft(2, '0')}",
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    if (conversation.unreadCount > 0) ...[
                      const SizedBox(height: 4),
                      CircleAvatar(
                        radius: 10,
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        child: Text(
                          conversation.unreadCount.toString(),
                          style: const TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                    ]
                  ],
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChatDetailPage(conversation: conversation),
                    ),
                  );
                },
              ),
              const Divider(height: 1, indent: 80),
            ],
          );
        },
      ),
    );
  }
}
