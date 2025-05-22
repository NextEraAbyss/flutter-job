import 'package:flutter/material.dart';

/// 应用主题定义
class AppTheme {
  // 主色
  static const Color primaryColor = Colors.teal;
  
  // 背景色
  static const Color backgroundColor = Color(0xFFF5F5F5);
  
  // 卡片背景色
  static const Color cardColor = Colors.white;
  
  // 文本颜色
  static const Color textPrimaryColor = Color(0xFF333333);
  static const Color textSecondaryColor = Color(0xFF666666);
  static const Color textHintColor = Color(0xFF999999);
  
  // 边框颜色
  static const Color borderColor = Color(0xFFEEEEEE);
  
  // 分割线颜色
  static const Color dividerColor = Color(0xFFEEEEEE);
  
  // 按钮颜色
  static const Color buttonPrimaryColor = Colors.teal;
  static const Color buttonTextColor = Colors.white;
  
  // 图标颜色
  static const Color iconPrimaryColor = Colors.teal;
  static const Color iconSecondaryColor = Color(0xFF666666);
  
  // 主题数据
  static ThemeData get themeData {
    return ThemeData(
      primaryColor: primaryColor,
      scaffoldBackgroundColor: backgroundColor,
      cardColor: cardColor,
      dividerColor: dividerColor,
      textTheme: const TextTheme(
        titleLarge: TextStyle(
          color: textPrimaryColor,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        titleMedium: TextStyle(
          color: textPrimaryColor,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        bodyLarge: TextStyle(
          color: textPrimaryColor,
          fontSize: 14,
        ),
        bodyMedium: TextStyle(
          color: textSecondaryColor,
          fontSize: 12,
        ),
      ),
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        primary: primaryColor,
        background: backgroundColor,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
      ),
    );
  }
}
