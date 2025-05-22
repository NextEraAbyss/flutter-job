import 'package:flutter/material.dart';
import '../../constants/app_theme.dart';
import '../../services/api/news_api.dart';
import '../../models/news_model.dart';

class NewsDetailPage extends StatefulWidget {
  final String title;
  final String image;
  final String? content;
  final DateTime? publishDate;
  final int? id;

  const NewsDetailPage({
    super.key,
    required this.title,
    required this.image,
    this.content,
    this.publishDate,
    this.id,
  });

  @override
  State<NewsDetailPage> createState() => _NewsDetailPageState();
}

class _NewsDetailPageState extends State<NewsDetailPage> {
  bool _isLoading = false;
  String? _errorMessage;
  NewsItem? _newsDetail;

  @override
  void initState() {
    super.initState();
    // 如果提供了id，则从API获取详细信息
    if (widget.id != null) {
      _fetchNewsDetail(widget.id!);
    }
  }

  Future<void> _fetchNewsDetail(int id) async {
    try {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });

      final detail = await NewsApi.getNewsDetail(id);
      
      setState(() {
        _newsDetail = detail;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = '获取新闻详情失败: $e';
        _isLoading = false;
      });
      print('Error fetching news detail: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    // 使用从API获取的详情，如果没有则使用传入的参数
    final title = _newsDetail?.title ?? widget.title;
    final image = _newsDetail?.image ?? widget.image;
    final content = _newsDetail?.content ?? widget.content;
    final publishDate = _newsDetail?.publishDate ?? widget.publishDate;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.primaryColor,
        title: const Text('资讯详情'),
        centerTitle: true,
        elevation: 0,
      ),
      body: _isLoading 
        ? const Center(child: CircularProgressIndicator())
        : (_errorMessage != null)
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _errorMessage!,
                    style: TextStyle(color: Colors.red[700]),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: widget.id != null ? () => _fetchNewsDetail(widget.id!) : null,
                    child: const Text('重试'),
                  ),
                ],
              ),
            )
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 标题
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.textPrimaryColor,
                      ),
                    ),
                  ),
                  
                  // 日期时间
                  if (publishDate != null)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        '${publishDate.year}年${publishDate.month}月${publishDate.day}日 ${_formatTime(publishDate)}',
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                  
                  // 间距
                  const SizedBox(height: 16.0),
                  
                  // 图片
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(4.0),
                      child: SizedBox(
                        width: double.infinity,
                        child: image.startsWith('http') 
                          ? Image.network(
                              image,
                              fit: BoxFit.cover,
                              loadingBuilder: (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Container(
                                  height: 200,
                                  color: Colors.grey[300],
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      value: loadingProgress.expectedTotalBytes != null
                                          ? loadingProgress.cumulativeBytesLoaded / 
                                              loadingProgress.expectedTotalBytes!
                                          : null,
                                    ),
                                  ),
                                );
                              },
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  height: 200,
                                  color: Colors.grey[300],
                                  child: const Center(
                                    child: Icon(
                                      Icons.image_not_supported,
                                      color: Colors.grey,
                                      size: 50.0,
                                    ),
                                  ),
                                );
                              },
                            )
                          : Image.asset(
                              image,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  height: 200,
                                  color: Colors.grey[300],
                                  child: const Center(
                                    child: Icon(
                                      Icons.image_not_supported,
                                      color: Colors.grey,
                                      size: 50.0,
                                    ),
                                  ),
                                );
                              },
                            ),
                      ),
                    ),
                  ),
                  
                  // 内容
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      content ?? '在近日举行的2024年度科技创新大会上，绿境科技凭借在环保技术领域的突出贡献，荣获年度创新企业奖。该奖项彰显了公司在技术创新方向的领先地位。',
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: AppTheme.textPrimaryColor,
                        height: 1.6,
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
  
  // 格式化时间
  String _formatTime(DateTime date) {
    String hour = date.hour.toString().padLeft(2, '0');
    String minute = date.minute.toString().padLeft(2, '0');
    String second = date.second.toString().padLeft(2, '0');
    return '$hour:$minute:$second';
  }
}
