import 'package:flutter/material.dart';

class MyPage extends StatelessWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 顶部搜索栏
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFF857A6), Color(0xFFFF5858)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search username/ID',
                      hintStyle: const TextStyle(color: Colors.white70),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.2),
                      prefixIcon: const Icon(Icons.search, color: Colors.white),
                      contentPadding: const EdgeInsets.symmetric(vertical: 0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          // 扫码、好友、通讯录
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(
              children: [
                ListTile(
                  leading: Container(
                    decoration: const BoxDecoration(
                      color: Color(0xFFF857A6),
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(8),
                    child: const Icon(Icons.qr_code_scanner, color: Colors.white),
                  ),
                  title: const Text('Scan QR Code'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {},
                ),
                const SizedBox(height: 8),
                ListTile(
                  leading: Container(
                    decoration: const BoxDecoration(
                      color: Color(0xFF1877F3),
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(8),
                    child: const Icon(Icons.facebook, color: Colors.white),
                  ),
                  title: const Text('Facebook Friends'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {},
                ),
                const SizedBox(height: 8),
                ListTile(
                  leading: Container(
                    decoration: const BoxDecoration(
                      color: Color(0xFF4CAF50),
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(8),
                    child: const Icon(Icons.contacts, color: Colors.white),
                  ),
                  title: const Text('Contacts'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {},
                ),
              ],
            ),
          ),
          const Divider(height: 1, thickness: 1),
          // 推荐好友
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 0, 8),
            child: Text('You May Like', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              itemCount: 5,
              itemBuilder: (context, index) {
                return _buildUserItem(
                  avatar: 'https://picsum.photos/seed/$index/400/300',
                  name: [
                    'Jeanette King',
                    'The King',
                    'Akshay Syal',
                    'Jeanette King',
                    'Nicholas Reyes',
                  ][index],
                  id: [
                    'kingjean',
                    'kingjean',
                    'syalakshay',
                    'kingjean',
                    'nicholas',
                  ][index],
                  fans: [
                    '13K',
                    '12K',
                    '66K',
                    '25K',
                    '13K',
                  ][index],
                  isLive: true,
                  isChecked: [true, false, false, true, false][index],
                  badge: ['', '2', '', '1', ''][index],
                  isVip: index == 2,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  static Widget _buildUserItem({
    required String avatar,
    required String name,
    required String id,
    required String fans,
    bool isLive = false,
    bool isChecked = false,
    String badge = '',
    bool isVip = false,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
      elevation: 0,
      child: ListTile(
        leading: Stack(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(avatar),
              radius: 24,
            ),
            if (badge.isNotEmpty)
              Positioned(
                right: -2,
                bottom: -2,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.pink,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(badge, style: const TextStyle(color: Colors.white, fontSize: 10)),
                ),
              ),
            if (isVip)
              Positioned(
                left: -2,
                bottom: -2,
                child: Icon(Icons.verified, color: Colors.amber, size: 16),
              ),
          ],
        ),
        title: Row(
          children: [
            Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(width: 4),
            if (isVip)
              const Icon(Icons.verified, color: Colors.amber, size: 16),
          ],
        ),
        subtitle: Row(
          children: [
            Text('$id, Fans:$fans'),
            if (isLive)
              Container(
                margin: const EdgeInsets.only(left: 8),
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text('Live', style: TextStyle(color: Colors.white, fontSize: 12)),
              ),
          ],
        ),
        trailing: isChecked
            ? const Icon(Icons.check_circle, color: Colors.pink)
            : const Icon(Icons.radio_button_unchecked, color: Colors.grey),
      ),
    );
  }
}
