import 'package:flutter/material.dart';
import '../../constants/app_theme.dart';
import '../../models/job_position_model.dart';
import '../../services/api/job_api.dart';

class JobDetailPage extends StatefulWidget {
  final int? id;
  final String? title;
  final String? location;
  final String? experience;
  final String? education;
  final String? company;
  final String? description;
  final String? salary;
  final List<String>? requirements;

  const JobDetailPage({
    super.key,
    this.id,
    this.title,
    this.location,
    this.experience,
    this.education,
    this.company,
    this.description,
    this.salary,
    this.requirements,
  });

  @override
  State<JobDetailPage> createState() => _JobDetailPageState();
}

class _JobDetailPageState extends State<JobDetailPage> {
  bool _isLoading = false;
  String? _errorMessage;
  JobPosition? _jobPosition;
  bool _isApplying = false;

  @override
  void initState() {
    super.initState();

    // 如果有ID，则从API获取详情
    if (widget.id != null) {
      _loadJobDetail(widget.id!);
    } else {
      // 否则使用传入的数据
      _jobPosition = JobPosition(
        title: widget.title ?? '',
        location: widget.location ?? '',
        experience: widget.experience ?? '',
        education: widget.education ?? '',
        company: widget.company ?? '',
        description: widget.description,
        salary: widget.salary,
        requirements: widget.requirements,
      );
    }
  }

  Future<void> _loadJobDetail(int id) async {
    try {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });

      final jobDetail = await JobApi.getJobDetail(id);

      setState(() {
        _jobPosition = jobDetail;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = '加载职位详情失败: $e';
        _isLoading = false;
      });
      print('加载职位详情错误: $e');
    }
  }

  // 处理职位申请
  void _handleJobApplication() async {
    // 防止重复点击
    if (_isApplying) return;

    setState(() {
      _isApplying = true;
    });

    // 清除之前的所有SnackBar
    ScaffoldMessenger.of(context).clearSnackBars();

    // 显示申请成功提示
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('申请已提交，请等待HR联系'),
        duration: Duration(seconds: 2),
      ),
    );

    // 延时后重置按钮状态
    await Future.delayed(const Duration(seconds: 2));

    // 确保widget还在挂载状态才执行setState
    if (mounted) {
      setState(() {
        _isApplying = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.primaryColor,
        title: const Text('职位详情'),
        centerTitle: true,
        elevation: 0,
      ),
      body:
          _isLoading
              ? const Center(child: CircularProgressIndicator())
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
                    if (widget.id != null)
                      ElevatedButton(
                        onPressed: () => _loadJobDetail(widget.id!),
                        child: const Text('重试'),
                      ),
                  ],
                ),
              )
              : _jobPosition == null
              ? const Center(child: Text('无职位数据'))
              : SingleChildScrollView(
                child: Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 职位标题
                        Text(
                          _jobPosition!.title,
                          style: const TextStyle(
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.textPrimaryColor,
                          ),
                        ),
                        const SizedBox(height: 24.0),

                        // 职位信息
                        _buildInfoRow('工作地点：', _jobPosition!.location),
                        const SizedBox(height: 8.0),
                        _buildInfoRow('工作经验：', _jobPosition!.experience),
                        const SizedBox(height: 8.0),
                        _buildInfoRow('学历要求：', _jobPosition!.education),
                        if (_jobPosition!.salary != null) ...[
                          const SizedBox(height: 8.0),
                          _buildInfoRow('薪资范围：', _jobPosition!.salary!),
                        ],
                        const SizedBox(height: 24.0),

                        // 职位描述
                        const Text(
                          '职位描述',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.textPrimaryColor,
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        Text(
                          _jobPosition!.description?.replaceAll(r'\n', '\n') ??
                              '负责公司核心业务系统的设计和开发，参与需求分析和系统架构设计，编写高质量、可维护的代码，解决系统运行中的技术问题。',
                          style: const TextStyle(
                            fontSize: 16.0,
                            color: AppTheme.textPrimaryColor,
                            height: 1.6,
                          ),
                        ),
                        const SizedBox(height: 24.0),

                        // 任职要求
                        const Text(
                          '任职要求',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.textPrimaryColor,
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        if (_jobPosition!.requirements != null &&
                            _jobPosition!.requirements!.isNotEmpty)
                          ...(_jobPosition!.requirements!.map(
                            (req) => _buildRequirementItem(req),
                          ))
                        else ...[
                          _buildRequirementItem('1. 本科及以上学历，计算机相关专业；'),
                          _buildRequirementItem(
                            '2. 5年以上Java开发经验，熟练掌握Java核心技术；',
                          ),
                          _buildRequirementItem(
                            '3. 熟悉Spring、SpringBoot、MyBatis等主流框架；',
                          ),
                          _buildRequirementItem(
                            '4. 熟悉MySQL等关系型数据库，具有良好的SQL编写能力；',
                          ),
                          _buildRequirementItem('5. 具有良好的系统设计能力和问题解决能力。'),
                        ],
                        const SizedBox(height: 32.0),

                        // 申请按钮
                        SizedBox(
                          width: double.infinity,
                          height: 48.0,
                          child: ElevatedButton(
                            onPressed:
                                _isApplying ? null : _handleJobApplication,
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  _isApplying ? Colors.grey : Colors.teal,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24.0),
                              ),
                            ),
                            child:
                                _isApplying
                                    ? const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: 16.0,
                                          height: 16.0,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2.0,
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                                  Colors.white,
                                                ),
                                          ),
                                        ),
                                        SizedBox(width: 8.0),
                                        Text(
                                          '申请中...',
                                          style: TextStyle(fontSize: 16.0),
                                        ),
                                      ],
                                    )
                                    : const Text(
                                      '立即申请',
                                      style: TextStyle(fontSize: 16.0),
                                    ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 16.0, color: Colors.grey[600])),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 16.0,
              color: AppTheme.textPrimaryColor,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRequirementItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Text(
        text.replaceAll(r'\n', '\n'),
        style: const TextStyle(
          fontSize: 16.0,
          color: AppTheme.textPrimaryColor,
          height: 1.5,
        ),
      ),
    );
  }
}
