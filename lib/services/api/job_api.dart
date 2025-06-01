import 'dart:convert';
import '../../models/job_position_model.dart';
import '../../utils/http/index.dart';

/// 职位API服务
class JobApi {
  /// 获取职位列表
  static Future<List<JobPosition>> getJobPositions() async {
    try {
      print('开始请求职位数据: /api/v1/jobs');

      // 使用Http工具类获取数据
      final response = await HttpClient.get('/api/v1/jobs?page=1&page_size=10');

      // 检查响应结构
      if (response.containsKey('data')) {
        final data = response['data'];

        if (data is Map && data.containsKey('items') && data['items'] is List) {
          final List<dynamic> items = data['items'];
          print('解析到 ${items.length} 个职位');
          return items.map((item) => JobPosition.fromJson(item)).toList();
        } else if (data is List) {
          // 如果data直接是列表
          print('解析到 ${data.length} 个职位');
          return data.map((item) => JobPosition.fromJson(item)).toList();
        }
      }

      throw Exception('职位API响应结构异常: $response');
    } catch (e) {
      print('Error fetching jobs: $e');
      throw Exception('获取职位列表失败: $e');
    }
  }

  /// 获取职位详情
  static Future<JobPosition> getJobDetail(int id) async {
    try {
      print('开始请求职位详情: /api/v1/jobs/$id');

      // 使用Http工具类获取数据
      final response = await HttpClient.get('/api/v1/jobs/$id');

      // 检查响应结构
      if (response.containsKey('data')) {
        final data = response['data'];
        return JobPosition.fromJson(data);
      }

      throw Exception('职位详情API响应结构异常: $response');
    } catch (e) {
      print('Error fetching job detail: $e');
      throw Exception('获取职位详情失败: $e');
    }
  }
}
