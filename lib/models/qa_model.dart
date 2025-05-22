/// 问答数据模型
class QAItem {
  final String question;
  final String answer;
  final String? category;
  final int? order;

  QAItem({
    required this.question,
    required this.answer,
    this.category,
    this.order,
  });

  // 从JSON构造
  factory QAItem.fromJson(Map<String, dynamic> json) {
    return QAItem(
      question: json['question'] ?? '',
      answer: json['answer'] ?? '',
      category: json['category'],
      order: json['order'],
    );
  }

  // 转换为JSON
  Map<String, dynamic> toJson() {
    return {
      'question': question,
      'answer': answer,
      'category': category,
      'order': order,
    };
  }
}
