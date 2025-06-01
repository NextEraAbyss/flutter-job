import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// 应用主题定义
///
/// 统一管理应用的颜色、字体、尺寸等视觉元素
class AppTheme {
  // 防止实例化
  AppTheme._();

  // ========== 主要颜色定义 ==========

  /// 主题色
  static const Color primaryColor = Colors.teal;

  /// 主题色变种
  static const Color primaryLightColor = Color(0xFF4DB6AC);
  static const Color primaryDarkColor = Color(0xFF00695C);

  /// 次要颜色
  static const Color secondaryColor = Color(0xFF26A69A);

  /// 强调色
  static const Color accentColor = Color(0xFFFF5722);

  // ========== 背景色定义 ==========

  /// 主背景色
  static const Color backgroundColor = Color(0xFFF5F5F5);

  /// 卡片背景色
  static const Color cardColor = Colors.white;

  /// 表面颜色
  static const Color surfaceColor = Colors.white;

  /// 错误颜色
  static const Color errorColor = Color(0xFFE57373);

  /// 成功颜色
  static const Color successColor = Color(0xFF66BB6A);

  /// 警告颜色
  static const Color warningColor = Color(0xFFFFB74D);

  // ========== 文本颜色定义 ==========

  /// 主要文本颜色
  static const Color textPrimaryColor = Color(0xFF212121);

  /// 次要文本颜色
  static const Color textSecondaryColor = Color(0xFF757575);

  /// 提示文本颜色
  static const Color textHintColor = Color(0xFFBDBDBD);

  /// 禁用文本颜色
  static const Color textDisabledColor = Color(0xFF9E9E9E);

  // ========== 边框和分割线 ==========

  /// 边框颜色
  static const Color borderColor = Color(0xFFE0E0E0);

  /// 分割线颜色
  static const Color dividerColor = Color(0xFFEEEEEE);

  // ========== 按钮颜色 ==========

  /// 主要按钮颜色
  static const Color buttonPrimaryColor = primaryColor;

  /// 次要按钮颜色
  static const Color buttonSecondaryColor = Color(0xFFEEEEEE);

  /// 按钮文本颜色
  static const Color buttonTextColor = Colors.white;

  /// 禁用按钮颜色
  static const Color buttonDisabledColor = Color(0xFFBDBDBD);

  // ========== 图标颜色 ==========

  /// 主要图标颜色
  static const Color iconPrimaryColor = primaryColor;

  /// 次要图标颜色
  static const Color iconSecondaryColor = Color(0xFF757575);

  /// 禁用图标颜色
  static const Color iconDisabledColor = Color(0xFFBDBDBD);

  // ========== 状态栏样式 ==========

  /// 状态栏样式配置
  static const SystemUiOverlayStyle statusBarStyle = SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
    statusBarBrightness: Brightness.dark,
    systemNavigationBarColor: backgroundColor,
    systemNavigationBarIconBrightness: Brightness.dark,
  );

  // ========== 阴影定义 ==========

  /// 卡片阴影
  static final List<BoxShadow> cardShadow = [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.05),
      blurRadius: 4.0,
      offset: const Offset(0, 2),
    ),
  ];

  /// 按钮阴影
  static final List<BoxShadow> buttonShadow = [
    BoxShadow(
      color: primaryColor.withValues(alpha: 0.3),
      blurRadius: 8.0,
      offset: const Offset(0, 4),
    ),
  ];

  // ========== 字体大小定义 ==========

  /// 特大标题
  static const double fontSizeXLarge = 24.0;

  /// 大标题
  static const double fontSizeLarge = 20.0;

  /// 中等标题
  static const double fontSizeMedium = 18.0;

  /// 正文
  static const double fontSizeBody = 16.0;

  /// 小文本
  static const double fontSizeSmall = 14.0;

  /// 标签文本
  static const double fontSizeCaption = 12.0;

  // ========== 主题数据 ==========

  /// 主题配置
  static ThemeData get themeData {
    return ThemeData(
      // 基础颜色
      primaryColor: primaryColor,
      scaffoldBackgroundColor: backgroundColor,
      cardColor: cardColor,
      dividerColor: dividerColor,

      // 颜色方案
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        primary: primaryColor,
        secondary: secondaryColor,
        surface: surfaceColor,
        error: errorColor,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: textPrimaryColor,
        onError: Colors.white,
        brightness: Brightness.light,
      ),

      // 文本主题
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          color: textPrimaryColor,
          fontSize: fontSizeXLarge,
          fontWeight: FontWeight.bold,
        ),
        headlineMedium: TextStyle(
          color: textPrimaryColor,
          fontSize: fontSizeLarge,
          fontWeight: FontWeight.w600,
        ),
        titleLarge: TextStyle(
          color: textPrimaryColor,
          fontSize: fontSizeMedium,
          fontWeight: FontWeight.w600,
        ),
        titleMedium: TextStyle(
          color: textPrimaryColor,
          fontSize: fontSizeBody,
          fontWeight: FontWeight.w500,
        ),
        bodyLarge: TextStyle(color: textPrimaryColor, fontSize: fontSizeBody),
        bodyMedium: TextStyle(
          color: textSecondaryColor,
          fontSize: fontSizeSmall,
        ),
        bodySmall: TextStyle(color: textHintColor, fontSize: fontSizeCaption),
      ),

      // AppBar主题
      appBarTheme: const AppBarTheme(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        systemOverlayStyle: statusBarStyle,
      ),

      // 卡片主题
      cardTheme: CardThemeData(
        color: cardColor,
        elevation: 2,
        shadowColor: Colors.black.withValues(alpha: 0.1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      ),

      // 按钮主题
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonPrimaryColor,
          foregroundColor: buttonTextColor,
          elevation: 2,
          shadowColor: primaryColor.withValues(alpha: 0.3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          textStyle: const TextStyle(
            fontSize: fontSizeBody,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),

      // 输入框主题
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: borderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: primaryColor, width: 2.0),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 12.0,
        ),
        hintStyle: const TextStyle(color: textHintColor),
      ),

      // 图标主题
      iconTheme: const IconThemeData(color: iconSecondaryColor, size: 24.0),
      primaryIconTheme: const IconThemeData(
        color: iconPrimaryColor,
        size: 24.0,
      ),
    );
  }
}
