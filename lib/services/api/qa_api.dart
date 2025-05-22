import 'dart:convert';
import '../../models/qa_model.dart';
import '../../utils/http/index.dart';

/// 问答API服务
class QAApi {
  /// 获取问答列表
  static Future<List<QAItem>> getQAList() async {
    try {
      print('开始请求问答数据: /api/v1/qa');
      
      // 使用Http工具类获取数据
      final response = await HttpClient.get('/api/v1/qa');
      
      // 检查响应结构
      if (response.containsKey('data')) {
        final data = response['data'];
        
        if (data is Map && data.containsKey('items') && data['items'] is List) {
          final List<dynamic> items = data['items'];
          print('解析到 ${items.length} 条问答');
          return items.map((item) => QAItem.fromJson(item)).toList();
        } else if (data is List) {
          // 如果data直接是列表
          print('解析到 ${data.length} 条问答');
          return data.map((item) => QAItem.fromJson(item)).toList();
        }
      }
      
      throw Exception('QA API响应结构异常: $response');
    } catch (e) {
      print('Error fetching QA: $e');
      throw Exception('获取问答列表失败: $e');
    }
  }
}
