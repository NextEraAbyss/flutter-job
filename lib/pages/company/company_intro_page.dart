import 'package:flutter/material.dart';
import 'package:bruno/bruno.dart';
import 'dart:async';
import '../../services/api/company_api.dart';

/// 公司介绍页面组件
/// 展示公司轮播图和公司信息
class CompanyIntroPage extends StatefulWidget {
  const CompanyIntroPage({super.key});

  @override
  State<CompanyIntroPage> createState() => _CompanyIntroPageState();
}

/// 公司介绍页面状态类
class _CompanyIntroPageState extends State<CompanyIntroPage> {
  // 轮播图控制器
  final PageController _pageController = PageController();
  // 当前页面索引
  int _currentPage = 0;
  // 自动轮播定时器
  Timer? _timer;

  // 轮播图数据列表
  final List<String> bannerImages = [
    'assets/images/company/company-banner1.jpg',
    'assets/images/company/company-banner2.jpg',
    'assets/images/company/company-banner3.jpg',
  ];

  @override
  void initState() {
    super.initState();
    // 启动定时器，自动轮播
    _startAutoPlay();
  }

  @override
  void dispose() {
    // 销毁定时器和控制器，防止内存泄漏
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  /// 启动自动轮播功能
  /// 每3秒切换一次轮播图
  void _startAutoPlay() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_currentPage < bannerImages.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      
      // 确保控制器已附加到视图
      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 顶部轮播图部分
            SizedBox(
              height: 200,
              width: double.infinity,
              child: Stack(
                children: [
                  // 轮播图主体
                  PageView.builder(
                    controller: _pageController,
                    itemCount: bannerImages.length,
                    onPageChanged: (index) {
                      setState(() {
                        _currentPage = index;
                      });
                    },
                    itemBuilder: (context, index) {
                      return Image.asset(
                        bannerImages[index],
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          // 图片加载失败时显示提示信息
                          return Container(
                            color: Colors.grey[300],
                            child: const Center(
                              child: Text('图片加载失败'),
                            ),
                          );
                        },
                      );
                    },
                  ),
                  // 底部页面指示器
                  Positioned(
                    bottom: 10,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: bannerImages.asMap().entries.map((entry) {
                        return Container(
                          width: 8,
                          height: 8,
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            // 当前页面对应的指示器显示为白色，其他为半透明
                            color: _currentPage == entry.key
                                ? Colors.white
                                : Colors.white.withOpacity(0.5),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
            // 公司信息卡片部分
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // 公司简介卡片
                  _buildInfoCard(
                    title: '公司简介',
                    content: '''绿境中苏泽于2024年创立，致力于前沿研究技术开发和应用制造，实现全球化运营，是国务院120家试点企业集团，国家双创示范基地，国家产教融合试点企业，创中国世名品牌，获中国工业大奖等。

改革开放初期第一个产品出口，配套国际主流品牌，现已成为全球知名的高科技企业。''',
                  ),
                  const SizedBox(height: 16.0),
                  // 公司地址卡片
                  _buildInfoCard(
                    title: '公司地址',
                    content: '湖北省武汉市自由贸易试验区临港新片区江山路00001号',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 构建信息卡片组件
  /// [title] 卡片标题
  /// [content] 卡片内容
  Widget _buildInfoCard({required String title, required String content}) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4.0,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 卡片标题栏，左侧带有绿色竖线
            Row(
              children: [
                Container(
                  width: 4,
                  height: 16,
                  color: Colors.teal,
                  margin: const EdgeInsets.only(right: 8.0),
                ),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            // 卡片内容文本
            Text(
              content,
              style: const TextStyle(
                fontSize: 14.0,
                height: 1.5,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}