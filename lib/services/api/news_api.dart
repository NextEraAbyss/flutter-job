import 'dart:convert';
import '../../models/news_model.dart';
import '../../utils/http/index.dart';

/// 新闻API服务
class NewsApi {
  /// 获取新闻列表
  static Future<List<NewsItem>> getNewsList() async {
    try {
      print('开始请求新闻数据: /api/v1/news?page=1&page_size=10');

      // 使用Http工具类获取数据
      final response = await HttpClient.get('/api/v1/news?page=1&page_size=10');

      // 检查响应结构
      if (response.containsKey('data')) {
        final data = response['data'];

        if (data is Map && data.containsKey('items') && data['items'] is List) {
          final List<dynamic> items = data['items'];
          print('解析到 ${items.length} 条新闻');
          return items.map((item) => NewsItem.fromJson(item)).toList();
        } else if (data is List) {
          // 如果data直接是列表
          print('解析到 ${data.length} 条新闻');
          return data.map((item) => NewsItem.fromJson(item)).toList();
        }
      }

      throw Exception('新闻API响应结构异常: $response');
    } catch (e) {
      print('Error fetching news: $e');
      throw Exception('获取新闻列表失败: $e');
    }
  }

  /// 获取新闻详情
  static Future<NewsItem> getNewsDetail(int id) async {
    try {
      print('开始请求新闻详情: /api/v1/news/$id');

      // 使用Http工具类获取数据
      final response = await HttpClient.get('/api/v1/news/$id');

      // 检查响应结构
      if (response.containsKey('data')) {
        final data = response['data'];
        return NewsItem.fromJson(data);
      }

      throw Exception('新闻详情API响应结构异常: $response');
    } catch (e) {
      print('Error fetching news detail: $e');
      throw Exception('获取新闻详情失败: $e');
    }
  }
}
