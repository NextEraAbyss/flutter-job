// Flutter Job应用基础组件测试
//
// 测试应用的基本功能，包括底部导航、页面切换等

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_job/main.dart';

void main() {
  group('Flutter Job App Tests', () {
    testWidgets('应用启动测试', (WidgetTester tester) async {
      // 构建应用并触发一帧渲染
      await tester.pumpWidget(const JobApp());

      // 验证应用正常启动
      expect(find.byType(MainTabPage), findsOneWidget);

      // 验证底部导航栏存在
      expect(find.byType(BottomNavigationBar), findsOneWidget);

      // 验证默认显示企业介绍页面
      expect(find.text('企业介绍'), findsWidgets);
    });

    testWidgets('底部导航栏切换测试', (WidgetTester tester) async {
      // 构建应用
      await tester.pumpWidget(const JobApp());

      // 验证初始状态为企业介绍页面
      expect(find.text('企业介绍'), findsWidgets);

      // 点击招聘职位标签
      await tester.tap(find.text('招聘职位'));
      await tester.pumpAndSettle();

      // 验证切换到招聘职位页面
      expect(find.text('招聘职位'), findsWidgets);

      // 点击Q&A标签
      await tester.tap(find.text('Q&A'));
      await tester.pumpAndSettle();

      // 验证切换到Q&A页面
      expect(find.text('Q&A'), findsWidgets);

      // 点击最新资讯标签
      await tester.tap(find.text('最新资讯'));
      await tester.pumpAndSettle();

      // 验证切换到资讯页面
      expect(find.text('最新资讯'), findsWidgets);
    });

    testWidgets('应用栏标题更新测试', (WidgetTester tester) async {
      // 构建应用
      await tester.pumpWidget(const JobApp());

      // 验证初始标题
      expect(find.text('企业介绍'), findsWidgets);

      // 切换到不同页面并验证标题更新
      final tabLabels = ['招聘职位', 'Q&A', '最新资讯'];

      for (String label in tabLabels) {
        await tester.tap(find.text(label));
        await tester.pumpAndSettle();

        // 验证AppBar标题更新
        expect(find.text(label), findsWidgets);
      }
    });
  });
}
