import 'package:flutter/material.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('消息')),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                'https://picsum.photos/seed/user$index/100/100',
              ),
            ),
            title: Text('用户 ${index + 1}'),
            subtitle: Text('发来了一条消息 ${DateTime.now().toString().substring(0, 16)}'),
            trailing: index % 3 == 0 
                ? Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                  )
                : null,
          );
        },
      ),
    );
  }
}