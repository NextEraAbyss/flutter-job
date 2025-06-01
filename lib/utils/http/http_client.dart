import 'package:http/http.dart' as http;
import 'dart:convert';
import 'api_config.dart';

/// HTTP客户端
class HttpClient {
  /// 执行GET请求
  static Future<Map<String, dynamic>> get(String endpoint) async {
    final url = '${ApiConfig.baseUrl}$endpoint';
    print('请求: GET $url');

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: ApiConfig.defaultHeaders,
      );

      return _processResponse(response);
    } catch (e, stackTrace) {
      print('HTTP GET错误: $e');
      print('堆栈: $stackTrace');
      throw Exception('请求失败: $e');
    }
  }

  /// 执行POST请求
  static Future<Map<String, dynamic>> post(
    String endpoint,
    Map<String, dynamic> body,
  ) async {
    final url = '${ApiConfig.baseUrl}$endpoint';
    print('请求: POST $url, body: $body');

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: ApiConfig.defaultHeaders,
        body: json.encode(body),
      );

      return _processResponse(response);
    } catch (e, stackTrace) {
      print('HTTP POST错误: $e');
      print('堆栈: $stackTrace');
      throw Exception('请求失败: $e');
    }
  }

  /// 处理HTTP响应
  static Map<String, dynamic> _processResponse(http.Response response) {
    print('响应状态码: ${response.statusCode}');

    // 使用utf8解码响应体
    final String responseBody = utf8.decode(response.bodyBytes);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      try {
        final jsonData = json.decode(responseBody);
        if (jsonData is Map<String, dynamic>) {
          return jsonData;
        } else {
          throw Exception('响应格式错误: 不是一个有效的JSON对象');
        }
      } catch (e) {
        throw Exception('解析响应失败: $e, 响应内容: $responseBody');
      }
    } else {
      throw Exception('请求失败: ${response.statusCode}, 响应: $responseBody');
    }
  }
}
