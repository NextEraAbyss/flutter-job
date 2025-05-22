import 'package:flutter/material.dart';
import 'pages/company/company_intro_page.dart';
import 'pages/job/job_positions_page.dart';
import 'pages/qa/qa_page.dart';
import 'pages/news/news_page.dart';
import 'constants/app_constants.dart';
import 'constants/app_theme.dart';

/// 应用程序入口函数
void main() {
  runApp(const MyApp());
}

/// 应用程序根组件
/// 配置应用主题和首页
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.appName,
      theme: AppTheme.themeData,
      home: const MyHomePage(title: AppConstants.appName),
    );
  }
}

/// 应用程序主页面
/// 包含底部导航栏和多个子页面
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

/// 主页面状态类
class _MyHomePageState extends State<MyHomePage> {
  // 当前选中的底部导航索引
  int _selectedIndex = 0;

  // 所有可切换的页面列表
  final List<Widget> _pages = [
    const CompanyIntroPage(),
    const JobPositionsPage(),
    const QAPage(),
    const NewsPage(),
  ];
  
  // 页面标题列表
  final List<String> _pageTitles = [
    '企业介绍',
    '招聘职位',
    'Q&A',
    '最新资讯',
  ];

  /// 底部导航项目点击回调函数
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 顶部应用栏，显示当前页面标题
      appBar: AppBar(
        backgroundColor: AppTheme.primaryColor,
        title: Text(_pageTitles[_selectedIndex]),
        centerTitle: true,
        elevation: 0,
      ),
      // 主体内容区域，显示当前选中的页面
      body: _pages[_selectedIndex],
      // 底部导航栏
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppTheme.primaryColor,
        unselectedItemColor: AppTheme.textSecondaryColor,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: '企业介绍',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.work),
            label: '招聘职位',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.question_answer),
            label: 'Q&A',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.newspaper),
            label: '最新资讯',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
