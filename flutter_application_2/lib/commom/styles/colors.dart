// lib/theme/colors.dart
import 'package:flutter/material.dart';

class AppColors {
  // 品牌主色（直播氛围色，常用粉/红/紫/蓝等）
  static const Color primary = Color.fromARGB(233, 237, 49, 49); // 直播主色
  static const Color secondary = Color(0xFFF9A14A); // 辅助色/高亮
  static const Color accent = Color(0xFF4A90E2); // 强调色/按钮色

  // 状态色
  static const Color success = Color(0xFF4CD964); // 成功/通过
  static const Color warning = Color(0xFFFFC300); // 警告
  static const Color error = Color(0xFFFF3B30);   // 错误/危险

  // 背景色
  static const Color background = Color(0xFFF8F8F8); // 页面背景
  static const Color card = Colors.white;            // 卡片/弹窗背景
  static const Color mask = Color(0x99000000);       // 蒙层/遮罩

  // 文本色
  static const Color textPrimary = Color(0xFF222222);   // 主文本
  static const Color textSecondary = Color(0xFF888888); // 次文本
  static const Color textDisabled = Color(0xFFCCCCCC);  // 禁用文本
  static const Color textInverse = Colors.white;        // 反色文本

  // 边框/分割线
  static const Color divider = Color(0xFFE0E0E0);
  static const Color border = Color(0xFFE5E5E5);

  // 直播专用
  static const Color liveRed = Color(0xFFFF2850);    // 直播红
  static const Color liveBlue = Color(0xFF4A90E2);   // 直播蓝
  static const Color livePurple = Color(0xFF8F5CFF); // 直播紫
  static const Color liveGold = Color(0xFFFFC300);   // 贵族/高亮

  // 其他可扩展
}

class AppDarkColors {
  // 品牌主色（流媒体蓝）
  static const Color primary = Color(0xFF5A8DEE); // 电影流媒体蓝
  static const Color secondary = Color(0xFFFFC300); // 高亮/按钮
  static const Color accent = Color(0xFF00C6AE); // 强调色/按钮色

  // 状态色
  static const Color success = Color(0xFF4CD964);
  static const Color warning = Color(0xFFFFC300);
  static const Color error = Color(0xFFFF3B30);

  // 背景色
  static const Color background = Color(0xFF23243B); // 主背景
  static const Color card = Color(0xFF292B3E);       // 卡片/内容区
  static const Color mask = Color(0x99000000);

  // 文本色
  static const Color textPrimary = Color(0xFFF5F6FA);   // 主文本
  static const Color textSecondary = Color(0xFFA3A3B3); // 次文本
  static const Color textDisabled = Color(0xFF444444);  // 禁用文本
  static const Color textInverse = Colors.white;         // 反色文本

  // 边框/分割线
  static const Color divider = Color(0xFF292B3E);
  static const Color border = Color(0xFF333333);

  // 直播专用/高亮
  static const Color liveRed = Color(0xFFFF2850);
  static const Color liveBlue = Color(0xFF5A8DEE);
  static const Color livePurple = Color(0xFF8F5CFF);
  static const Color liveGold = Color(0xFFFFC300);

  // 其他可扩展
}