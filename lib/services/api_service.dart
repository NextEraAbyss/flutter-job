import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/news_model.dart';
import '../models/qa_model.dart';
import '../models/job_position_model.dart';

class ApiService {
  // 基础URL，实际开发中应该根据环境配置不同的URL
  static const String baseUrl = 'https://api.wat.ink';
  
  // 获取新闻列表
  static Future<List<NewsItem>> getNewsList() async {
    try {
      print('开始请求: $baseUrl/api/v1/news?page=1&page_size=10');
      
      // 设置请求头，处理字符编码
      final headers = {
        'Content-Type': 'application/json; charset=utf-8',
        'Accept': 'application/json',
      };
      
      final response = await http.get(Uri.parse('$baseUrl/api/v1/news?page=1&page_size=10'), headers: headers);
      print('响应状态码: ${response.statusCode}');
      
      // 检查响应状态
      if (response.statusCode == 200) {
        // 解析响应数据，确保使用utf-8解码
        final String responseBody = utf8.decode(response.bodyBytes);
        print('解码后的响应: $responseBody');
        
        final jsonData = json.decode(responseBody);
        print('完整响应JSON: $jsonData');
        
        // 检查响应结构
        if (jsonData is Map && jsonData.containsKey('data')) {
          final data = jsonData['data'];
          
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
        
        throw Exception('API响应结构异常: $jsonData');
      } else {
        // 服务器返回错误码
        throw Exception('Failed to load news: ${response.statusCode}');
      }
    } catch (e, stackTrace) {
      // 捕获异常并记录错误
      print('Error fetching news: $e');
      print('错误堆栈: $stackTrace');
      throw Exception('获取新闻列表失败: $e');
    }
  }
  
  // 获取新闻详情
  static Future<NewsItem> getNewsDetail(int id) async {
    try {
      print('开始请求新闻详情: $baseUrl/api/v1/news/$id');
      
      // 设置请求头，处理字符编码
      final headers = {
        'Content-Type': 'application/json; charset=utf-8',
        'Accept': 'application/json',
      };
      
      final response = await http.get(Uri.parse('$baseUrl/api/v1/news/$id'), headers: headers);
      print('响应状态码: ${response.statusCode}');
      
      if (response.statusCode == 200) {
        // 解析响应数据，确保使用utf-8解码
        final String responseBody = utf8.decode(response.bodyBytes);
        print('解码后的响应: $responseBody');
        
        final jsonData = json.decode(responseBody);
        print('新闻详情响应JSON: $jsonData');
        
        if (jsonData is Map && jsonData.containsKey('data')) {
          final data = jsonData['data'];
          return NewsItem.fromJson(data);
        }
        
        throw Exception('API详情响应结构异常: $jsonData');
      } else {
        throw Exception('Failed to load news detail: ${response.statusCode}');
      }
    } catch (e) {
      // 捕获异常并记录错误
      print('Error fetching news detail: $e');
      throw Exception('获取新闻详情失败: $e');
    }
  }
  
  // 获取常见问题列表
  static Future<List<QAItem>> getQAList() async {
    try {
      print('开始请求问答数据: $baseUrl/api/v1/qa');
      
      // 设置请求头，处理字符编码
      final headers = {
        'Content-Type': 'application/json; charset=utf-8',
        'Accept': 'application/json',
      };
      
      final response = await http.get(Uri.parse('$baseUrl/api/v1/qa'), headers: headers);
      print('QA响应状态码: ${response.statusCode}');
      
      // 检查响应状态
      if (response.statusCode == 200) {
        // 解析响应数据，确保使用utf-8解码
        final String responseBody = utf8.decode(response.bodyBytes);
        print('QA解码后的响应: $responseBody');
        
        final jsonData = json.decode(responseBody);
        print('QA完整响应JSON: $jsonData');
        
        // 检查响应结构
        if (jsonData is Map && jsonData.containsKey('data')) {
          final data = jsonData['data'];
          
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
        
        throw Exception('QA API响应结构异常: $jsonData');
      } else {
        // 服务器返回错误码
        throw Exception('Failed to load QA: ${response.statusCode}');
      }
    } catch (e, stackTrace) {
      // 捕获异常并记录错误
      print('Error fetching QA: $e');
      print('错误堆栈: $stackTrace');
      throw Exception('获取问答列表失败: $e');
    }
  }
  
  // 获取职位列表
  static Future<List<JobPosition>> getJobPositions() async {
    try {
      print('开始请求职位列表: $baseUrl/api/v1/jobs');
      
      // 设置请求头，处理字符编码
      final headers = {
        'Content-Type': 'application/json; charset=utf-8',
        'Accept': 'application/json',
      };
      
      final response = await http.get(Uri.parse('$baseUrl/api/v1/jobs?page=1&page_size=10'), headers: headers);
      print('职位列表响应状态码: ${response.statusCode}');
      
      // 检查响应状态
      if (response.statusCode == 200) {
        // 解析响应数据，确保使用utf-8解码
        final String responseBody = utf8.decode(response.bodyBytes);
        print('职位列表解码后的响应: $responseBody');
        
        final jsonData = json.decode(responseBody);
        print('职位列表完整响应JSON: $jsonData');
        
        // 检查响应结构
        if (jsonData is Map && jsonData.containsKey('data')) {
          final data = jsonData['data'];
          
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
        
        throw Exception('职位列表API响应结构异常: $jsonData');
      } else {
        // 服务器返回错误码
        throw Exception('Failed to load job positions: ${response.statusCode}');
      }
    } catch (e, stackTrace) {
      // 捕获异常并记录错误
      print('Error fetching job positions: $e');
      print('错误堆栈: $stackTrace');
      throw Exception('获取职位列表失败: $e');
    }
  }
  
  // 获取职位详情
  static Future<JobPosition> getJobDetail(int id) async {
    try {
      print('开始请求职位详情: $baseUrl/api/v1/jobs/$id');
      
      // 设置请求头，处理字符编码
      final headers = {
        'Content-Type': 'application/json; charset=utf-8',
        'Accept': 'application/json',
      };
      
      final response = await http.get(Uri.parse('$baseUrl/api/v1/jobs/$id'), headers: headers);
      print('职位详情响应状态码: ${response.statusCode}');
      
      if (response.statusCode == 200) {
        // 解析响应数据，确保使用utf-8解码
        final String responseBody = utf8.decode(response.bodyBytes);
        print('职位详情解码后的响应: $responseBody');
        
        final jsonData = json.decode(responseBody);
        print('职位详情响应JSON: $jsonData');
        
        if (jsonData is Map && jsonData.containsKey('data')) {
          final data = jsonData['data'];
          return JobPosition.fromJson(data);
        }
        
        throw Exception('职位详情API响应结构异常: $jsonData');
      } else {
        throw Exception('Failed to load job detail: ${response.statusCode}');
      }
    } catch (e) {
      // 捕获异常并记录错误
      print('Error fetching job detail: $e');
      throw Exception('获取职位详情失败: $e');
    }
  }
}
