// lib/theme/colors.dart
import 'package:flutter/material.dart';

class AppColors {
  // 品牌主色（直播氛围色，常用粉/红/紫/蓝等）
  static const Color primary = Color(0xFFEA5C8B); // 直播主色
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