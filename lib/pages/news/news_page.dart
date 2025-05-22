import 'package:flutter/material.dart';
import 'package:bruno/bruno.dart';
import '../../models/news_model.dart';
import '../../services/api/news_api.dart';
import 'news_detail_page.dart';

/// 新闻页面组件
/// 用于显示新闻列表，支持下拉刷新和点击查看详情
class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

/// 新闻页面状态类
class _NewsPageState extends State<NewsPage> {
  // 新闻列表
  List<NewsItem> _newsItems = [];
  // 加载状态
  bool _isLoading = true;
  // 错误信息
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    // 组件初始化时获取新闻数据
    _fetchNewsData();
  }

  /// 从API获取新闻数据
  Future<void> _fetchNewsData() async {
    try {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });

      // 从API获取新闻数据
      final newsList = await NewsApi.getNewsList();

      setState(() {
        _newsItems = newsList;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = '获取新闻数据失败: $e';
        _isLoading = false;
      });
      print('Error fetching news: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: _buildContent(),
      ),
    );
  }

  /// 根据当前状态构建页面内容
  Widget _buildContent() {
    // 加载中状态显示加载指示器
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    
    // 发生错误时显示错误信息和重试按钮
    if (_errorMessage != null) {
      return Center(
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
              onPressed: _fetchNewsData,
              child: const Text('重试'),
            ),
          ],
        ),
      );
    }
    
    // 数据为空时显示提示信息和刷新按钮
    if (_newsItems.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '没有找到新闻',
              style: TextStyle(color: Colors.grey[600]),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _fetchNewsData,
              child: const Text('刷新'),
            ),
          ],
        ),
      );
    }
    
    // 显示新闻列表，支持下拉刷新
    return RefreshIndicator(
      onRefresh: _fetchNewsData,
      child: ListView.builder(
        padding: const EdgeInsets.all(12.0),
        itemCount: _newsItems.length,
        itemBuilder: (context, index) {
          return NewsCard(
            newsItem: _newsItems[index],
          );
        },
      ),
    );
  }
}

/// 新闻卡片组件
/// 显示单条新闻信息，包括图片和标题，点击可查看详情
class NewsCard extends StatelessWidget {
  final NewsItem newsItem;

  const NewsCard({
    super.key,
    required this.newsItem,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12.0),
      child: BrnShadowCard(
        padding: EdgeInsets.zero,
        child: InkWell(
          onTap: () {
            // 导航到新闻详情页
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NewsDetailPage(
                  id: newsItem.id,
                  title: newsItem.title,
                  image: newsItem.image ?? '',
                  content: newsItem.content,
                  publishDate: newsItem.publishDate,
                ),
              ),
            );
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // 新闻图片区域
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  bottomLeft: Radius.circular(8.0),
                ),
                child: SizedBox(
                  width: 100.0,
                  height: 100.0,
                  child: newsItem.image != null
                      ? (newsItem.image!.startsWith('http')
                          // 网络图片处理
                          ? Image.network(
                              newsItem.image!,
                              fit: BoxFit.cover,
                              loadingBuilder: (context, child, loadingProgress) {
                                // 图片加载过程中显示进度指示器
                                if (loadingProgress == null) return child;
                                return Container(
                                  color: Colors.grey[200],
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
                                // 图片加载错误时显示占位符
                                return Container(
                                  color: _getColorFromHex(newsItem.placeholderColor) ?? Colors.grey[300],
                                  child: Center(
                                    child: Icon(
                                      newsItem.getIconData() ?? Icons.image,
                                      color: Colors.white,
                                      size: 40.0,
                                    ),
                                  ),
                                );
                              },
                            )
                          // 本地图片处理
                          : Image.asset(
                              newsItem.image!,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                // 图片加载错误时显示占位符
                                return ColoredBox(
                                  color: newsItem.getPlaceholderColor(),
                                  child: Center(
                                    child: Icon(
                                      newsItem.getIconData(),
                                      color: Colors.white,
                                      size: 40.0,
                                    ),
                                  ),
                                );
                              },
                            ))
                      // 无图片时显示占位符
                      : ColoredBox(
                          color: newsItem.getPlaceholderColor(),
                          child: Center(
                            child: Icon(
                              newsItem.getIconData(),
                              color: Colors.white,
                              size: 40.0,
                            ),
                          ),
                        ),
                ),
              ),
              // 新闻标题区域
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    newsItem.title,
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              // 右侧箭头指示可点击查看详情
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Icon(
                  Icons.chevron_right,
                  color: Colors.grey[400],
                  size: 20.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// 将十六进制颜色字符串转换为Color对象
/// 如果输入为null，则返回null
Color? _getColorFromHex(String? hexColor) {
  if (hexColor == null) return null;
  hexColor = hexColor.replaceAll('#', '');
  if (hexColor.length == 6) {
    hexColor = 'FF$hexColor';
  }
  return Color(int.parse(hexColor, radix: 16));
}