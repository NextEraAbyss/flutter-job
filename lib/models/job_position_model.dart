/// 职位数据模型
class JobPosition {
  final String title;
  final String location;
  final String experience;
  final String education;
  final String company;
  final String? description;
  final String? salary;
  final List<String>? requirements;
  final String? contactEmail;
  final int? id; // 添加ID字段

  JobPosition({
    required this.title,
    required this.location,
    required this.experience,
    required this.education,
    required this.company,
    this.description,
    this.salary,
    this.requirements,
    this.contactEmail,
    this.id,
  });

  // 从JSON构造
  factory JobPosition.fromJson(Map<String, dynamic> json) {
    // 处理requirements字段，可能是字符串或列表
    List<String>? requirementsList;
    if (json['requirements'] != null) {
      if (json['requirements'] is List) {
        requirementsList = List<String>.from(json['requirements']);
      } else if (json['requirements'] is String) {
        // 如果是字符串，尝试按行分割
        requirementsList =
            (json['requirements'] as String)
                .split('\n')
                .where((s) => s.trim().isNotEmpty)
                .toList();
      }
    }

    return JobPosition(
      id: json['id'] is String ? int.tryParse(json['id']) : json['id'],
      title: json['title'] ?? '',
      location: json['location'] ?? '',
      experience: json['experience'] ?? '',
      education: json['education'] ?? '',
      company: json['company'] ?? '',
      description: json['description'],
      salary: json['salary'],
      requirements: requirementsList,
      contactEmail: json['contactEmail'],
    );
  }

  // 转换为JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'location': location,
      'experience': experience,
      'education': education,
      'company': company,
      'description': description,
      'salary': salary,
      'requirements': requirements,
      'contactEmail': contactEmail,
    };
  }
}
