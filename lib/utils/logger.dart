import 'package:flutter/foundation.dart';

/// 日志级别枚举
enum LogLevel { debug, info, warning, error }

/// 应用日志工具类
///
/// 提供统一的日志输出管理，支持不同级别的日志记录
/// 在发布版本中自动禁用debug日志
class Logger {
  // 防止实例化
  Logger._();

  /// 是否启用日志输出 (仅在debug模式下启用)
  static bool get _isEnabled => kDebugMode;

  /// 格式化日志时间戳
  static String get _timestamp {
    final now = DateTime.now();
    return '${now.hour.toString().padLeft(2, '0')}:'
        '${now.minute.toString().padLeft(2, '0')}:'
        '${now.second.toString().padLeft(2, '0')}'
        '.${now.millisecond.toString().padLeft(3, '0')}';
  }

  /// 输出debug级别日志
  ///
  /// [tag] 日志标签，用于标识日志来源
  /// [message] 日志消息
  static void debug(String tag, String message) {
    _log(LogLevel.debug, tag, message);
  }

  /// 输出info级别日志
  ///
  /// [tag] 日志标签
  /// [message] 日志消息
  static void info(String tag, String message) {
    _log(LogLevel.info, tag, message);
  }

  /// 输出warning级别日志
  ///
  /// [tag] 日志标签
  /// [message] 日志消息
  static void warning(String tag, String message) {
    _log(LogLevel.warning, tag, message);
  }

  /// 输出error级别日志
  ///
  /// [tag] 日志标签
  /// [message] 日志消息
  /// [error] 错误对象（可选）
  /// [stackTrace] 堆栈跟踪（可选）
  static void error(
    String tag,
    String message, [
    Object? error,
    StackTrace? stackTrace,
  ]) {
    _log(LogLevel.error, tag, message);
    if (error != null && _isEnabled) {
      debugPrint('Error details: $error');
    }
    if (stackTrace != null && _isEnabled) {
      debugPrint('Stack trace: $stackTrace');
    }
  }

  /// 核心日志输出方法
  ///
  /// [level] 日志级别
  /// [tag] 日志标签
  /// [message] 日志消息
  static void _log(LogLevel level, String tag, String message) {
    if (!_isEnabled) return;

    final levelStr = level.name.toUpperCase().padRight(7);
    final tagStr = tag.padRight(15);
    final logMessage = '$_timestamp $levelStr [$tagStr] $message';

    debugPrint(logMessage);
  }

  /// 网络请求日志
  ///
  /// [method] HTTP方法
  /// [url] 请求URL
  /// [statusCode] 响应状态码（可选）
  /// [duration] 请求耗时（可选）
  static void network(
    String method,
    String url, [
    int? statusCode,
    Duration? duration,
  ]) {
    if (!_isEnabled) return;

    final statusStr = statusCode != null ? ' [$statusCode]' : '';
    final durationStr =
        duration != null ? ' (${duration.inMilliseconds}ms)' : '';
    debug('Network', '$method $url$statusStr$durationStr');
  }

  /// API响应数据日志
  ///
  /// [endpoint] API端点
  /// [data] 响应数据
  static void apiResponse(String endpoint, dynamic data) {
    if (!_isEnabled) return;
    debug('API', '$endpoint response: $data');
  }

  /// API错误日志
  ///
  /// [endpoint] API端点
  /// [error] 错误信息
  static void apiError(String endpoint, String error) {
    Logger.error('API', '$endpoint error: $error');
  }

  /// 页面导航日志
  ///
  /// [from] 来源页面
  /// [to] 目标页面
  static void navigation(String from, String to) {
    info('Navigation', '$from -> $to');
  }

  /// 用户操作日志
  ///
  /// [action] 操作类型
  /// [details] 操作详情
  static void userAction(String action, String details) {
    info('UserAction', '$action: $details');
  }
}
