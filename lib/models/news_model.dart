import 'package:flutter/material.dart';

/// 新闻数据模型
///
/// 包含新闻的基础信息、显示配置和工具方法
/// 支持从JSON数据创建和序列化
class NewsItem {
  // ========== 基础信息字段 ==========

  /// 新闻唯一标识ID
  final int? id;

  /// 新闻标题 (必填)
  final String title;

  /// 新闻内容
  final String? content;

  /// 新闻图片URL或本地路径
  final String? image;

  /// 发布日期
  final DateTime? publishDate;

  /// 新闻描述/摘要
  final String? description;

  /// 新闻来源
  final String? source;

  /// 新闻分类
  final String? category;

  /// 新闻详情链接
  final String? url;

  // ========== 显示配置字段 ==========

  /// 占位符背景色 (十六进制字符串)
  final String? placeholderColor;

  /// 占位符图标标识
  final String? icon;

  // ========== 构造函数 ==========

  /// 创建新闻项实例
  ///
  /// [title] 是必填参数，其他为可选参数
  const NewsItem({
    this.id,
    required this.title,
    this.content,
    this.image,
    this.publishDate,
    this.description,
    this.source,
    this.category,
    this.url,
    this.placeholderColor,
    this.icon,
  });

  // ========== 工厂构造函数 ==========

  /// 从JSON数据创建新闻项实例
  ///
  /// 支持多种日期格式解析，具有良好的容错性
  /// [json] JSON数据映射
  factory NewsItem.fromJson(Map<String, dynamic> json) {
    return NewsItem(
      id: _parseId(json['id']),
      title: _parseTitle(json['title']),
      content: _parseContent(json['content']),
      image: json['image'] as String?,
      publishDate: _parsePublishDate(json),
      description: json['description'] as String?,
      source: _parseSource(json),
      category: json['category'] as String?,
      url: json['url'] as String?,
      placeholderColor: json['placeholderColor'] as String?,
      icon: json['icon'] as String?,
    );
  }

  // ========== 私有解析方法 ==========

  /// 解析ID字段，支持字符串和数字类型
  static int? _parseId(dynamic idValue) {
    if (idValue == null) return null;
    if (idValue is int) return idValue;
    if (idValue is String) return int.tryParse(idValue);
    return null;
  }

  /// 解析标题字段，确保非空
  static String _parseTitle(dynamic titleValue) {
    final title = titleValue?.toString() ?? '';
    return title.isEmpty ? '无标题' : title;
  }

  /// 解析内容字段
  static String? _parseContent(dynamic contentValue) {
    return contentValue?.toString();
  }

  /// 解析来源字段，支持source和author两个字段名
  static String? _parseSource(Map<String, dynamic> json) {
    return json['source']?.toString() ?? json['author']?.toString();
  }

  /// 解析发布日期，支持多种格式
  static DateTime? _parsePublishDate(Map<String, dynamic> json) {
    // 优先使用publishDate字段
    if (json['publishDate'] != null) {
      return _tryParseDateTime(json['publishDate'].toString());
    }

    // 回退使用created_at字段
    if (json['created_at'] != null) {
      return _tryParseDateTime(json['created_at'].toString());
    }

    return null;
  }

  /// 尝试解析日期时间字符串
  ///
  /// 支持标准ISO格式和中文格式 "2025年01月10日 17:24:59"
  static DateTime? _tryParseDateTime(String dateStr) {
    try {
      // 处理中文日期格式
      if (dateStr.contains('年') &&
          dateStr.contains('月') &&
          dateStr.contains('日')) {
        return _parseChineseDateFormat(dateStr);
      }

      // 标准格式解析
      return DateTime.parse(dateStr);
    } catch (e) {
      debugPrint('日期解析失败: $dateStr - $e');
      return null;
    }
  }

  /// 解析中文日期格式 "2025年01月10日 17:24:59"
  static DateTime? _parseChineseDateFormat(String dateStr) {
    try {
      final year = int.parse(dateStr.split('年')[0]);
      final month = int.parse(dateStr.split('年')[1].split('月')[0]);
      final day = int.parse(dateStr.split('月')[1].split('日')[0]);

      // 解析时间部分，如果没有则默认为00:00:00
      final timePart =
          dateStr.split(' ').length > 1 ? dateStr.split(' ')[1] : '00:00:00';

      final timeComponents = timePart.split(':');
      final hour = int.parse(timeComponents[0]);
      final minute =
          timeComponents.length > 1 ? int.parse(timeComponents[1]) : 0;
      final second =
          timeComponents.length > 2 ? int.parse(timeComponents[2]) : 0;

      return DateTime(year, month, day, hour, minute, second);
    } catch (e) {
      debugPrint('中文日期格式解析失败: $dateStr - $e');
      return null;
    }
  }

  // ========== 序列化方法 ==========

  /// 将新闻项转换为JSON格式
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'image': image,
      'publishDate': publishDate?.toIso8601String(),
      'description': description,
      'source': source,
      'category': category,
      'url': url,
      'placeholderColor': placeholderColor,
      'icon': icon,
    };
  }

  // ========== 显示相关方法 ==========

  /// 获取图标数据
  ///
  /// 根据icon字段值映射到对应的Material图标
  /// 默认返回文章图标
  IconData getIconData() {
    const iconMap = {
      'emoji_events': Icons.emoji_events,
      'people': Icons.people,
      'eco': Icons.eco,
      'trending_up': Icons.trending_up,
      'school': Icons.school,
      'handshake': Icons.handshake,
      'attach_money': Icons.attach_money,
      'verified': Icons.verified,
      'business': Icons.business,
      'work': Icons.work,
      'news': Icons.newspaper,
      'tech': Icons.computer,
      'health': Icons.local_hospital,
      'sports': Icons.sports,
      'entertainment': Icons.movie,
    };

    return iconMap[icon] ?? Icons.article;
  }

  /// 获取占位符背景颜色
  ///
  /// 解析十六进制颜色字符串，如果解析失败则返回默认灰色
  Color getPlaceholderColor() {
    if (placeholderColor == null || !placeholderColor!.startsWith('#')) {
      return Colors.grey.shade300;
    }

    try {
      final colorStr = placeholderColor!.substring(1);
      final colorValue =
          colorStr.length == 6
              ? 'FF$colorStr' // 添加透明度
              : colorStr;

      return Color(int.parse(colorValue, radix: 16));
    } catch (e) {
      debugPrint('颜色解析失败: $placeholderColor - $e');
      return Colors.grey.shade300;
    }
  }

  /// 获取显示用的图片路径
  ///
  /// 优先使用image字段，如果没有则基于ID或标题hash轮换选择本地图片
  String getDisplayImage() {
    // 如果有图片且是本地路径，直接返回
    if (image != null && !image!.startsWith('http')) {
      return image!;
    }

    // 轮换选择本地图片
    return _getRotatingImagePath();
  }

  /// 定义可用的新闻图片列表
  static const List<String> _availableNewsImages = [
    'assets/images/news/news1.jpg',
    'assets/images/news/news2.jpg',
    'assets/images/news/news3.jpg',
    'assets/images/news/news4.jpg',
    'assets/images/news/news5.jpg',
  ];

  /// 根据ID或标题hash轮换选择图片
  String _getRotatingImagePath() {
    final hashValue = id ?? title.hashCode.abs();
    final index = hashValue % _availableNewsImages.length;
    return _availableNewsImages[index];
  }

  // ========== 工具方法 ==========

  /// 获取格式化的发布日期字符串
  String getFormattedDate() {
    if (publishDate == null) return '未知日期';

    final date = publishDate!;
    return '${date.year}年${date.month.toString().padLeft(2, '0')}月'
        '${date.day.toString().padLeft(2, '0')}日';
  }

  /// 获取格式化的发布时间字符串
  String getFormattedTime() {
    if (publishDate == null) return '';

    final date = publishDate!;
    return '${date.hour.toString().padLeft(2, '0')}:'
        '${date.minute.toString().padLeft(2, '0')}';
  }

  /// 获取相对时间描述 (如: 2小时前, 3天前)
  String getRelativeTime() {
    if (publishDate == null) return '未知时间';

    final now = DateTime.now();
    final difference = now.difference(publishDate!);

    if (difference.inMinutes < 1) {
      return '刚刚';
    } else if (difference.inHours < 1) {
      return '${difference.inMinutes}分钟前';
    } else if (difference.inDays < 1) {
      return '${difference.inHours}小时前';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}天前';
    } else if (difference.inDays < 30) {
      return '${(difference.inDays / 7).floor()}周前';
    } else {
      return getFormattedDate();
    }
  }

  /// 检查是否为今日新闻
  bool get isToday {
    if (publishDate == null) return false;

    final now = DateTime.now();
    final date = publishDate!;

    return now.year == date.year &&
        now.month == date.month &&
        now.day == date.day;
  }

  /// 检查新闻是否有图片
  bool get hasImage => image != null && image!.isNotEmpty;

  /// 检查新闻是否有内容
  bool get hasContent => content != null && content!.isNotEmpty;

  // ========== 相等性比较 ==========

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NewsItem &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title;

  @override
  int get hashCode => id.hashCode ^ title.hashCode;

  @override
  String toString() {
    return 'NewsItem{id: $id, title: $title, category: $category, '
        'publishDate: ${getFormattedDate()}}';
  }
}
