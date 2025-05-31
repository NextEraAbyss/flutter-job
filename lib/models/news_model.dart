import 'package:flutter/material.dart';

/// 新闻数据模型
class NewsItem {
  final int? id;
  final String title;
  final String? content;
  final String? image;
  final String? placeholderColor;
  final String? icon;
  final DateTime? publishDate;
  final String? description;
  final String? source;
  final String? category;
  final String? url;

  NewsItem({
    this.id,
    required this.title,
    this.content,
    this.image,
    this.placeholderColor,
    this.icon,
    this.publishDate,
    this.description,
    this.source,
    this.category,
    this.url,
  });

  // 从JSON构造
  factory NewsItem.fromJson(Map<String, dynamic> json) {
    // 处理API返回的日期格式
    DateTime? parsedDate;
    if (json['publishDate'] != null) {
      try {
        parsedDate = DateTime.parse(json['publishDate']);
      } catch (e) {
        print('Error parsing publishDate: ${json['publishDate']} - $e');
      }
    } else if (json['created_at'] != null) {
      try {
        // 尝试解析可能不标准的日期格式
        final dateStr = json['created_at'].toString();

        // 处理"2025年01月10日 17:24:59"格式
        if (dateStr.contains('年') &&
            dateStr.contains('月') &&
            dateStr.contains('日')) {
          final year = int.parse(dateStr.split('年')[0]);
          final month = int.parse(dateStr.split('年')[1].split('月')[0]);
          final day = int.parse(dateStr.split('月')[1].split('日')[0]);

          final timePart =
              dateStr.split(' ').length > 1
                  ? dateStr.split(' ')[1]
                  : '00:00:00';
          final hour = int.parse(timePart.split(':')[0]);
          final minute = int.parse(timePart.split(':')[1]);
          final second = int.parse(timePart.split(':')[2]);

          parsedDate = DateTime(year, month, day, hour, minute, second);
        } else {
          // 尝试标准格式解析
          parsedDate = DateTime.parse(dateStr);
        }
      } catch (e) {
        print('Error parsing created_at: ${json['created_at']} - $e');
      }
    }

    // 获取并打印各个字段的值，帮助调试
    final String rawTitle = json['title']?.toString() ?? '';
    final String rawContent = json['content']?.toString() ?? '';

    print('原始title: $rawTitle');
    print('原始content: $rawContent');

    return NewsItem(
      id: json['id'] is String ? int.tryParse(json['id']) : json['id'],
      title: rawTitle,
      content: rawContent,
      image: json['image'],
      placeholderColor: json['placeholderColor'],
      icon: json['icon'],
      publishDate: parsedDate,
      description: json['description'],
      source: json['source'] ?? json['author'],
      category: json['category'],
      url: json['url'],
    );
  }

  // 转换为JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'image': image,
      'placeholderColor': placeholderColor,
      'icon': icon,
      'publishDate': publishDate?.toIso8601String(),
      'description': description,
      'source': source,
      'category': category,
      'url': url,
    };
  }

  // 获取图标数据
  IconData getIconData() {
    // 根据字符串映射到对应的图标
    switch (icon) {
      case 'emoji_events':
        return Icons.emoji_events;
      case 'people':
        return Icons.people;
      case 'eco':
        return Icons.eco;
      case 'trending_up':
        return Icons.trending_up;
      case 'school':
        return Icons.school;
      case 'handshake':
        return Icons.handshake;
      case 'attach_money':
        return Icons.attach_money;
      case 'verified':
        return Icons.verified;
      default:
        return Icons.article;
    }
  }

  // 获取占位符颜色
  Color getPlaceholderColor() {
    try {
      if (placeholderColor != null && placeholderColor!.startsWith('#')) {
        return Color(int.parse(placeholderColor!.substring(1, 9), radix: 16));
      }
    } catch (e) {
      print('Error parsing color: $e');
    }
    return Colors.grey.shade300;
  }

  // 获取轮换显示的图片路径
  String getDisplayImage() {
    // 定义可用的新闻图片列表
    const List<String> newsImages = [
      'assets/images/news/news1.jpg',
      'assets/images/news/news2.jpg',
      'assets/images/news/news3.jpg',
      'assets/images/news/news4.jpg',
      'assets/images/news/news5.jpg',
    ];

    // 如果已有图片且不是网络图片，直接返回
    if (image != null && !image!.startsWith('http')) {
      return image!;
    }

    // 根据ID或title的hash值轮换选择图片
    int index;
    if (id != null) {
      index = id! % newsImages.length;
    } else {
      // 如果没有ID，使用title的hash值
      index = title.hashCode.abs() % newsImages.length;
    }

    return newsImages[index];
  }
}
