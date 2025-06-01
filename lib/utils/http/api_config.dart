/// API配置类
class ApiConfig {
  /// API基础URL
  static const String baseUrl = 'https://api.wat.ink';

  /// 默认请求头
  static Map<String, String> get defaultHeaders => {
    'Content-Type': 'application/json; charset=utf-8',
    'Accept': 'application/json',
  };

  /// 分页默认参数
  static const int defaultPageSize = 10;
  static const int defaultPage = 1;
}
