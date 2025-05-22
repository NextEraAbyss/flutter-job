import 'package:flutter/material.dart';
import '../../models/qa_model.dart';
import '../../services/api/qa_api.dart';

/// QA页面组件
/// 显示常见问题及答案列表
class QAPage extends StatefulWidget {
  const QAPage({super.key});

  @override
  State<QAPage> createState() => _QAPageState();
}

/// QA页面状态类
class _QAPageState extends State<QAPage> {
  // 是否正在加载数据
  bool _isLoading = true;
  // 错误信息，如果为null则表示没有错误
  String? _errorMessage;
  // 问答数据列表
  List<QAItem> _qaItems = [];

  @override
  void initState() {
    super.initState();
    // 组件初始化时加载问答数据
    _loadQAData();
  }

  /// 从API加载问答数据
  Future<void> _loadQAData() async {
    try {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });

      // 调用API服务获取问答列表
      final qaList = await QAApi.getQAList();
      
      setState(() {
        _qaItems = qaList;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = '加载问答数据失败: $e';
        _isLoading = false;
      });
      print('加载问答数据错误: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: _isLoading
            // 加载中显示加载指示器
            ? const Center(child: CircularProgressIndicator())
            // 有错误时显示错误信息
            : _errorMessage != null
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '出错了',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.red[700],
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        Text(_errorMessage!),
                        const SizedBox(height: 16.0),
                        ElevatedButton(
                          onPressed: _loadQAData,
                          child: const Text('重试'),
                        ),
                      ],
                    ),
                  )
                // 成功加载数据后显示问答列表，支持下拉刷新
                : RefreshIndicator(
                    onRefresh: _loadQAData,
                    child: ListView.builder(
                      padding: const EdgeInsets.all(16.0),
                      itemCount: _qaItems.length,
                      itemBuilder: (context, index) {
                        final qaItem = _qaItems[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: QAItemWidget(
                            question: qaItem.question,
                            answer: qaItem.answer,
                          ),
                        );
                      },
                    ),
                  ),
      ),
    );
  }
}

/// 单个问答项目组件
/// 负责展示一个问题和答案对
class QAItemWidget extends StatelessWidget {
  // 问题文本
  final String question;
  // 答案文本
  final String answer;

  const QAItemWidget({
    super.key,
    required this.question,
    required this.answer,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // 添加卡片样式
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
            // 问题部分，以"Q"开头
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Q',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal[600],
                  ),
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    question,
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12.0),
            // 答案部分，以"A"开头
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'A',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange[600],
                  ),
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    // 将\n字符转换为实际换行
                    answer.replaceAll(r'\n', '\n'),
                    style: const TextStyle(
                      fontSize: 14.0,
                      color: Colors.black87,
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}