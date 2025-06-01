import 'dart:convert';
import '../../utils/http/index.dart';

/// 公司API服务
class CompanyApi {
  /// 获取公司简介信息
  static Future<Map<String, dynamic>> getCompanyInfo() async {
    try {
      print('开始请求公司信息: /api/v1/company/info');

      // 使用Http工具类获取数据
      final response = await HttpClient.get('/api/v1/company/info');

      // 检查响应结构
      if (response.containsKey('data')) {
        return response['data'] as Map<String, dynamic>;
      }

      throw Exception('公司信息API响应结构异常: $response');
    } catch (e) {
      print('Error fetching company info: $e');
      throw Exception('获取公司信息失败: $e');
    }
  }
}
