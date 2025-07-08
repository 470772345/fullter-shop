import 'package:flutter/material.dart';
import 'package:flutter_application_2/commom/styles/colors.dart';

class MyPage extends StatelessWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 顶部搜索栏
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.primary, AppColors.liveRed],
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
                      hintStyle: TextStyle(color: Theme.of(context).colorScheme.onPrimary.withAlpha((0.7 * 255).toInt())),
                      filled: true,
                      fillColor: Theme.of(context).colorScheme.onPrimary.withAlpha((0.2 * 255).toInt()),
                      prefixIcon: Icon(Icons.search, color: AppColors.textInverse),
                      contentPadding: const EdgeInsets.symmetric(vertical: 0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
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
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(8),
                    child: Icon(Icons.qr_code_scanner, color: Theme.of(context).colorScheme.onPrimary),
                  ),
                  title: Text('Scan QR Code', style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color)),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {},
                ),
                const SizedBox(height: 8),
                ListTile(
                  leading: Container(
                    decoration: const BoxDecoration(
                      color: AppColors.accent,
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(8),
                    child: Icon(Icons.facebook, color: Theme.of(context).colorScheme.onPrimary),
                  ),
                  title: Text('Facebook Friends', style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color)),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {},
                ),
                const SizedBox(height: 8),
                ListTile(
                  leading: Container(
                    decoration: const BoxDecoration(
                      color: AppColors.success,
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(8),
                    child: Icon(Icons.contacts, color: Theme.of(context).colorScheme.onPrimary),
                  ),
                  title: Text('Contacts', style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color)),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {},
                ),
              ],
            ),
          ),
          Divider(height: 1, thickness: 1, color: Theme.of(context).dividerColor),
          // 推荐好友
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 0, 8),
            child: Text('You May Like', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Theme.of(context).textTheme.bodyLarge?.color)),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              itemCount: 5,
              itemBuilder: (context, index) {
                return _buildUserItem(
                  context: context,
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

  Widget _buildUserItem({
    required BuildContext context,
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
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(badge, style: TextStyle(color: Theme.of(context).colorScheme.onPrimary, fontSize: 10)),
                ),
              ),
            if (isVip)
              Positioned(
                left: -2,
                bottom: -2,
                child: Icon(Icons.verified, color: AppColors.liveGold, size: 16),
              ),
          ],
        ),
        title: Row(
          children: [
            Text(name, style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).textTheme.bodyLarge?.color)),
            const SizedBox(width: 4),
            if (isVip)
              Icon(Icons.verified, color: AppColors.liveGold, size: 16),
          ],
        ),
        subtitle: Row(
          children: [
            Text('$id, Fans:$fans', style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color)),
            if (isLive)
              Container(
                margin: const EdgeInsets.only(left: 8),
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.accent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text('Live', style: TextStyle(color: Theme.of(context).colorScheme.onPrimary, fontSize: 12)),
              ),
          ],
        ),
        trailing: isChecked
            ? Icon(Icons.check_circle, color: AppColors.primary)
            : Icon(Icons.radio_button_unchecked, color: Theme.of(context).disabledColor),
      ),
    );
  }
}
