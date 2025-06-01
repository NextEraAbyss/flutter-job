import 'package:flutter/material.dart';
import '../../models/job_position_model.dart';
import 'job_detail_page.dart';
import '../../services/api/job_api.dart';

/// 招聘职位页面组件
/// 显示职位列表、提供搜索和筛选功能
class JobPositionsPage extends StatefulWidget {
  const JobPositionsPage({super.key});

  @override
  State<JobPositionsPage> createState() => _JobPositionsPageState();
}

/// 招聘职位页面状态类
class _JobPositionsPageState extends State<JobPositionsPage> {
  // 搜索关键字控制器
  final TextEditingController _searchController = TextEditingController();

  // 筛选条件
  String _selectedCity = '全部';
  String _selectedEducation = '全部';

  // 城市选项列表
  final List<String> _cityOptions = ['全部', '武汉', '广州', '上海', '北京', '深圳'];

  // 学历选项列表
  final List<String> _educationOptions = ['全部', '大专', '本科', '硕士', '博士'];

  // 当前展示的职位列表
  List<JobPosition> _displayedPositions = [];

  // 所有职位数据
  List<JobPosition> _allPositions = [];

  // 加载状态
  bool _isLoading = true;

  // 错误状态
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    // 页面初始化时加载职位数据
    _loadJobPositions();
  }

  /// 从API加载职位数据
  Future<void> _loadJobPositions() async {
    try {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });

      // 从API获取职位列表
      final positions = await JobApi.getJobPositions();

      setState(() {
        _allPositions = positions;
        _displayedPositions = List.from(_allPositions);
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = '加载职位列表失败: $e';
        _isLoading = false;
      });
      print('加载职位列表错误: $e');
    }
  }

  /// 根据筛选条件过滤职位列表
  void _filterPositions() {
    setState(() {
      _displayedPositions =
          _allPositions.where((position) {
            // 匹配关键字
            final bool matchesKeyword =
                _searchController.text.isEmpty ||
                position.title.toLowerCase().contains(
                  _searchController.text.toLowerCase(),
                );

            // 匹配城市
            final bool matchesCity =
                _selectedCity == '全部' || position.location == _selectedCity;

            // 匹配学历
            final bool matchesEducation =
                _selectedEducation == '全部' ||
                position.education == _selectedEducation;

            return matchesKeyword && matchesCity && matchesEducation;
          }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body:
          _isLoading
              // 加载中显示进度指示器
              ? const Center(child: CircularProgressIndicator())
              // 出错时显示错误信息
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
                      onPressed: _loadJobPositions,
                      child: const Text('重试'),
                    ),
                  ],
                ),
              )
              // 正常显示职位列表
              : Column(
                children: [
                  // 搜索框部分
                  _buildSearchBar(),
                  // 筛选条件部分
                  _buildFilterSection(),
                  // 职位列表，支持下拉刷新
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: _loadJobPositions,
                      child:
                          _displayedPositions.isEmpty
                              // 没有符合条件的职位时显示提示信息
                              ? Center(
                                child: Text(
                                  '没有找到符合条件的职位',
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 16,
                                  ),
                                ),
                              )
                              // 显示职位列表
                              : ListView.builder(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                ),
                                itemCount:
                                    _displayedPositions.length +
                                    1, // 增加一个项目用于底部空间
                                itemBuilder: (context, index) {
                                  // 如果是最后一个索引，返回一个空白区域作为底部空间
                                  if (index == _displayedPositions.length) {
                                    return const SizedBox(height: 30); // 底部预留空间
                                  }
                                  return _buildJobCard(
                                    _displayedPositions[index],
                                    context,
                                  );
                                },
                              ),
                    ),
                  ),
                ],
              ),
    );
  }

  /// 构建搜索栏
  Widget _buildSearchBar() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          // 搜索输入框
          Expanded(
            child: Container(
              height: 48, // 增加高度，提供更好的触摸体验
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8), // 更圆润的圆角
                border: Border.all(color: Colors.grey[300]!, width: 1),
              ),
              child: TextField(
                controller: _searchController,
                style: const TextStyle(fontSize: 16, color: Colors.black87),
                decoration: InputDecoration(
                  // 使用 prefixIcon 替代 icon，避免布局问题
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.grey[600],
                    size: 20,
                  ),
                  // 添加清除按钮
                  suffixIcon:
                      _searchController.text.isNotEmpty
                          ? IconButton(
                            icon: Icon(
                              Icons.clear,
                              color: Colors.grey[600],
                              size: 20,
                            ),
                            onPressed: () {
                              _searchController.clear();
                              _filterPositions();
                            },
                          )
                          : null,
                  hintText: '请输入职位关键字搜索',
                  hintStyle: TextStyle(color: Colors.grey[500], fontSize: 14),
                  // 移除所有边框
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  // 优化内边距
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  // 设置密度为紧凑
                  isDense: true,
                ),
                onChanged: (value) {
                  // 实时搜索
                  setState(() {}); // 触发重建以显示/隐藏清除按钮
                  _filterPositions();
                },
                onSubmitted: (value) {
                  // 按回车键搜索
                  _filterPositions();
                  FocusScope.of(context).unfocus();
                },
              ),
            ),
          ),
          const SizedBox(width: 12),
          // 搜索按钮
          Material(
            color: Colors.teal,
            borderRadius: BorderRadius.circular(8),
            child: InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: () {
                // 点击搜索按钮时执行搜索
                _filterPositions();
                // 收起键盘
                FocusScope.of(context).unfocus();
              },
              child: Container(
                height: 48, // 与输入框相同高度
                padding: const EdgeInsets.symmetric(horizontal: 20),
                alignment: Alignment.center,
                child: const Text(
                  '搜索',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 构建筛选条件部分
  Widget _buildFilterSection() {
    return Container(
      color: Colors.white,
      margin: const EdgeInsets.only(top: 1), // 添加与搜索框的间距
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          // 城市选择
          Expanded(
            child: _buildFilterDropdown(
              '城市',
              _selectedCity,
              _cityOptions,
              Icons.location_on_outlined,
              (value) {
                setState(() {
                  _selectedCity = value;
                  _filterPositions();
                });
              },
            ),
          ),
          // 分割线
          Container(
            width: 1,
            height: 32,
            margin: const EdgeInsets.symmetric(horizontal: 12),
            color: Colors.grey[300],
          ),
          // 学历选择
          Expanded(
            child: _buildFilterDropdown(
              '学历',
              _selectedEducation,
              _educationOptions,
              Icons.school_outlined,
              (value) {
                setState(() {
                  _selectedEducation = value;
                  _filterPositions();
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  /// 构建筛选下拉选择器
  Widget _buildFilterDropdown(
    String title,
    String currentValue,
    List<String> options,
    IconData icon,
    Function(String) onChanged,
  ) {
    final displayText = currentValue == '全部' ? title : currentValue;
    final isSelected = currentValue != '全部';

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(6),
        onTap: () {
          _showFilterOptions(context, title, currentValue, options, onChanged);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            border: Border.all(
              color: isSelected ? Colors.teal : Colors.grey[300]!,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(6),
            color:
                isSelected
                    ? Colors.teal.withValues(alpha: 0.05)
                    : Colors.transparent,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              // 图标
              Icon(
                icon,
                size: 16,
                color: isSelected ? Colors.teal : Colors.grey[600],
              ),
              const SizedBox(width: 6),
              // 显示当前选中的选项
              Flexible(
                child: Text(
                  displayText,
                  style: TextStyle(
                    fontSize: 14,
                    color: isSelected ? Colors.teal : Colors.grey[700],
                    fontWeight:
                        isSelected ? FontWeight.w500 : FontWeight.normal,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 4),
              // 下拉箭头
              Icon(
                Icons.arrow_drop_down,
                size: 16,
                color: isSelected ? Colors.teal : Colors.grey[600],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 显示筛选选项弹窗
  void _showFilterOptions(
    BuildContext context,
    String title,
    String currentValue,
    List<String> options,
    Function(String) onChanged,
  ) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 300,
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            children: [
              // 弹窗标题
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '选择$title',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // 关闭按钮
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
              const Divider(),
              // 选项列表
              Expanded(
                child: ListView.builder(
                  itemCount: options.length,
                  itemBuilder: (context, index) {
                    final option = options[index];
                    final isSelected = option == currentValue;
                    return ListTile(
                      title: Text(
                        option,
                        style: TextStyle(
                          color: isSelected ? Colors.teal : Colors.black,
                          fontWeight:
                              isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                      // 选中项显示对勾图标
                      trailing:
                          isSelected
                              ? const Icon(Icons.check, color: Colors.teal)
                              : null,
                      onTap: () {
                        onChanged(option);
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  /// 构建职位卡片
  Widget _buildJobCard(JobPosition position, BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 职位标题
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Text(
              position.title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          // 职位要求：工作地点、经验、学历
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                _buildRequirementTag(position.location),
                const SizedBox(width: 12),
                _buildRequirementTag(position.experience),
                const SizedBox(width: 12),
                _buildRequirementTag(position.education),
              ],
            ),
          ),
          // 公司名称
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              position.company,
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
          ),
          // 申请按钮
          Container(
            width: double.infinity,
            height: 44,
            margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: ElevatedButton(
              onPressed: () {
                // 导航到职位详情页
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => JobDetailPage(
                          title: position.title,
                          location: position.location,
                          experience: position.experience,
                          education: position.education,
                          company: position.company,
                          description: position.description,
                          requirements: position.requirements,
                          salary: position.salary,
                        ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal, // 将按钮颜色设置为绿色
                foregroundColor: Colors.white, // 文字颜色为白色
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0), // 圆角
                ),
              ),
              child: const Text('申请职位', style: TextStyle(fontSize: 16)),
            ),
          ),
        ],
      ),
    );
  }

  /// 构建职位要求标签
  Widget _buildRequirementTag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(2),
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: 12, color: Colors.grey[700]),
      ),
    );
  }

  @override
  void dispose() {
    // 释放控制器资源
    _searchController.dispose();
    super.dispose();
  }
}
