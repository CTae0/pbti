enum TestType { mini, full }

extension TestTypeX on TestType {
  String get value => name; // 'mini' | 'full' - matches Postgres enum

  static TestType fromString(String value) {
    return TestType.values.firstWhere((e) => e.value == value);
  }
}

class Question {
  const Question({
    required this.id,
    required this.testType,
    required this.orderIndex,
    required this.axis,
    required this.direction,
    required this.content,
    this.optionALabel,
    this.optionBLabel,
  });

  final int id;
  final TestType testType;
  final int orderIndex;

  /// 1~4 (축 1~4)
  final int axis;

  /// +1 또는 -1. 응답이 클수록(동의할수록) axis가 이 방향으로 가중됨.
  final int direction;

  final String content;

  /// mini 전용
  final String? optionALabel;
  final String? optionBLabel;

  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
      id: map['id'] as int,
      testType: TestTypeX.fromString(map['test_type'] as String),
      orderIndex: map['order_index'] as int,
      axis: map['axis'] as int,
      direction: map['direction'] as int,
      content: map['content'] as String,
      optionALabel: map['option_a_label'] as String?,
      optionBLabel: map['option_b_label'] as String?,
    );
  }
}
