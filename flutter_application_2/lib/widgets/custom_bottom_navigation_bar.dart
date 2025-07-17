import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  final VoidCallback onCreateTap;

  const CustomBottomNavigationBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
    required this.onCreateTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80, // 增加高度，确保有足够空间显示凸起按钮
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none, // 允许子元素超出边界
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0), // 为凸起按钮留出空间
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(0, Icons.home, '首页'),
                _buildNavItem(1, Icons.live_tv, '直播'),
                // 中间留空给"+"按钮
                const SizedBox(width: 80), // 增加宽度
                _buildNavItem(3, Icons.notifications, '消息'),
                _buildNavItem(4, Icons.person, '我'),
              ],
            ),
          ),
          // 中间的"+"按钮
          Positioned(
            left: 0,
            right: 0,
            top: -20, // 调整向上偏移量
            child: Center(
              child: _buildCreateButton(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    final bool isSelected = currentIndex == index;
    return InkWell(
      onTap: () => onTap(index),
      child: Container(
        width: 60,
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected ? const Color(0xFFFF2850) : const Color(0xFF8E8E93),
              size: 24,
            ),
            const SizedBox(height: 3),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? const Color(0xFFFF2850) : const Color(0xFF8E8E93),
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCreateButton(BuildContext context) {
    return GestureDetector(
      onTap: onCreateTap,
      child: Container(
        width: 60, // 增加宽度
        height: 60, // 增加高度
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFFF2850), Color(0xFFFF5E80)], // 更接近抖音的颜色
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(30), // 保持圆形
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFFF2850).withOpacity(0.3),
              blurRadius: 12,
              spreadRadius: 2,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border.all(color: Colors.white, width: 3), // 添加白色边框
        ),
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 32, // 增大图标
        ),
      ),
    );
  }
}