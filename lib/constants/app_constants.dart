/// 应用程序全局常量定义
///
/// 统一管理应用中使用的所有常量，避免魔法数字和重复字符串
class AppConstants {
  // 防止实例化
  AppConstants._();

  // ========== 应用信息 ==========

  /// 应用名称
  static const String appName = 'Flutter Job';

  /// 应用版本
  static const String appVersion = '1.0.0';

  /// 应用描述
  static const String appDescription = '现代化企业招聘移动应用';

  // ========== 底部导航配置 ==========

  /// 企业介绍页面索引
  static const int tabCompanyIntro = 0;

  /// 招聘职位页面索引
  static const int tabJobPositions = 1;

  /// 问答页面索引
  static const int tabQA = 2;

  /// 最新资讯页面索引
  static const int tabNews = 3;

  /// 底部导航标签文本
  static const List<String> tabLabels = ['企业介绍', '招聘职位', 'Q&A', '最新资讯'];

  // ========== 网络配置 ==========

  /// API基础URL
  static const String apiBaseUrl = 'https://api.wat.ink';

  /// API版本
  static const String apiVersion = 'v1';

  /// 网络请求超时时间（秒）
  static const int networkTimeout = 30;

  /// 重试次数
  static const int maxRetryCount = 3;

  // ========== UI尺寸常量 ==========

  /// 默认内边距
  static const double defaultPadding = 16.0;

  /// 小内边距
  static const double smallPadding = 8.0;

  /// 大内边距
  static const double largePadding = 24.0;

  /// 默认圆角半径
  static const double defaultBorderRadius = 8.0;

  /// 卡片高度
  static const double cardHeight = 100.0;

  /// 按钮高度
  static const double buttonHeight = 48.0;

  // ========== 动画时长 ==========

  /// 短动画时长（毫秒）
  static const int shortAnimationDuration = 200;

  /// 标准动画时长（毫秒）
  static const int standardAnimationDuration = 300;

  /// 长动画时长（毫秒）
  static const int longAnimationDuration = 500;

  // ========== 分页配置 ==========

  /// 默认分页大小
  static const int defaultPageSize = 10;

  /// 最大分页大小
  static const int maxPageSize = 50;

  // ========== 缓存配置 ==========

  /// 缓存过期时间（小时）
  static const int cacheExpirationHours = 24;

  /// 最大缓存文件数量
  static const int maxCacheFiles = 100;

  // ========== 应用限制 ==========

  /// 最大文件上传大小（MB）
  static const int maxFileUploadSizeMB = 10;

  /// 最大图片显示数量
  static const int maxImageCount = 20;

  /// 搜索关键词最小长度
  static const int minSearchKeywordLength = 2;

  /// 搜索关键词最大长度
  static const int maxSearchKeywordLength = 50;
}
