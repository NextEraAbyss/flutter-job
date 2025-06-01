import 'package:flutter/material.dart';
import 'pages/company/company_intro_page.dart';
import 'pages/job/job_positions_page.dart';
import 'pages/qa/qa_page.dart';
import 'pages/news/news_page.dart';
import 'constants/app_constants.dart';
import 'constants/app_theme.dart';

/// 应用程序入口函数
///
/// 初始化Flutter应用并启动主页面
void main() {
  // 确保Flutter绑定初始化
  WidgetsFlutterBinding.ensureInitialized();

  // 启动应用
  runApp(const JobApp());
}

/// 应用程序根组件
///
/// 负责配置应用的基础设置，包括主题、路由等
class JobApp extends StatelessWidget {
  const JobApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // 应用基础配置
      title: AppConstants.appName,
      theme: AppTheme.themeData,
      debugShowCheckedModeBanner: false, // 隐藏debug横幅
      // 主页面
      home: const MainTabPage(),

      // 全局配置
      builder: (context, child) {
        return MediaQuery(
          // 禁用系统字体缩放，确保UI一致性
          data: MediaQuery.of(
            context,
          ).copyWith(textScaler: const TextScaler.linear(1.0)),
          child: child!,
        );
      },
    );
  }
}

/// 主标签页面
///
/// 包含底部导航栏和对应的页面内容
class MainTabPage extends StatefulWidget {
  const MainTabPage({super.key});

  @override
  State<MainTabPage> createState() => _MainTabPageState();
}

/// 主标签页面状态管理
class _MainTabPageState extends State<MainTabPage>
    with SingleTickerProviderStateMixin {
  /// 当前选中的底部导航索引
  int _currentIndex = AppConstants.tabCompanyIntro;

  /// 页面控制器，用于优化页面切换性能
  late final PageController _pageController;

  /// 所有标签页面的实例
  static const List<Widget> _pages = [
    CompanyIntroPage(),
    JobPositionsPage(),
    QAPage(),
    NewsPage(),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  /// 处理底部导航栏点击事件
  ///
  /// [index] 点击的标签索引
  void _onTabTapped(int index) {
    if (_currentIndex != index) {
      setState(() {
        _currentIndex = index;
      });

      // 平滑切换到对应页面
      _pageController.animateToPage(
        index,
        duration: Duration(
          milliseconds: AppConstants.standardAnimationDuration,
        ),
        curve: Curves.easeInOut,
      );
    }
  }

  /// 处理页面滑动事件
  ///
  /// [index] 滑动到的页面索引
  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 顶部导航栏
      appBar: _buildAppBar(),

      // 页面内容
      body: _buildPageView(),

      // 底部导航栏
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  /// 构建顶部应用栏
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppTheme.primaryColor,
      title: Text(
        AppConstants.tabLabels[_currentIndex],
        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18.0),
      ),
      centerTitle: true,
      elevation: 0,
      // 添加状态栏样式
      systemOverlayStyle: AppTheme.statusBarStyle,
    );
  }

  /// 构建页面视图
  Widget _buildPageView() {
    return PageView(
      controller: _pageController,
      onPageChanged: _onPageChanged,
      // 禁用物理滚动，只通过导航栏切换
      physics: const NeverScrollableScrollPhysics(),
      children: _pages,
    );
  }

  /// 构建底部导航栏
  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: _currentIndex,
      onTap: _onTabTapped,

      // 样式配置
      selectedItemColor: AppTheme.primaryColor,
      unselectedItemColor: AppTheme.textSecondaryColor,
      selectedFontSize: 12.0,
      unselectedFontSize: 12.0,

      // 导航项
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.business),
          activeIcon: Icon(Icons.business, size: 28),
          label: '企业介绍',
          tooltip: '查看企业介绍和公司信息',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.work),
          activeIcon: Icon(Icons.work, size: 28),
          label: '招聘职位',
          tooltip: '浏览可申请的职位信息',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.question_answer),
          activeIcon: Icon(Icons.question_answer, size: 28),
          label: 'Q&A',
          tooltip: '查看常见问题和解答',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.newspaper),
          activeIcon: Icon(Icons.newspaper, size: 28),
          label: '最新资讯',
          tooltip: '获取最新的公司动态和资讯',
        ),
      ],
    );
  }
}
