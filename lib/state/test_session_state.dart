import 'package:flutter/foundation.dart';

import '../models/question.dart';

/// 축 1~4 각각의 +/- 방향을 나타내는 문자.
/// index: 0=axis1, 1=axis2, 2=axis3, 3=axis4
const List<String> _positiveLetters = ['C', 'M', 'I', 'I']; // 변화/시장/개인/명분
const List<String> _negativeLetters = ['S', 'G', 'C', 'R']; // 안정/정부/공동체/실용

/// 진행 중인 테스트(미니 또는 상세)의 답변을 누적하고,
/// 완료 시 4자리 Type Code를 산출하는 상태 클래스.
class TestSessionState extends ChangeNotifier {
  TestType? _testType;
  List<Question> _questions = const [];
  int _currentIndex = 0;
  String? _ageGroup;
  String? _gender;

  /// questionId -> answer
  /// full: 1~5 (5점 척도)
  /// mini: 1(A 선택) 또는 5(B 선택)로 정규화하여 저장
  final Map<int, int> _answers = {};

  TestType? get testType => _testType;
  int get currentIndex => _currentIndex;
  int get totalQuestions => _questions.length;
  Question? get currentQuestion =>
      _currentIndex < _questions.length ? _questions[_currentIndex] : null;
  bool get isComplete => _answers.length == _questions.length && _questions.isNotEmpty;
  double get progress => _questions.isEmpty ? 0 : _answers.length / _questions.length;
  String? get ageGroup => _ageGroup;
  String? get gender => _gender;

  void startSession(
    TestType type,
    List<Question> questions, {
    String? ageGroup,
    String? gender,
  }) {
    _testType = type;
    _questions = List.unmodifiable(questions);
    _currentIndex = 0;
    _answers.clear();
    _ageGroup = ageGroup;
    _gender = gender;
    notifyListeners();
  }

  /// 5점 척도 응답 (상세 테스트용). value: 1(매우 비동의) ~ 5(매우 동의)
  void answerLikert(int value) {
    assert(value >= 1 && value <= 5, 'Likert value must be 1~5');
    _submitAnswer(value);
  }

  /// A/B 양자택일 응답 (미니 테스트용).
  /// isOptionA: true면 A안(direction 반대쪽) 선택, false면 B안 선택.
  ///
  /// 문항의 direction은 '동의(응답값이 큼)했을 때의 axis 방향'을 의미하므로,
  /// A안 = 비동의 쪽(1), B안 = 동의 쪽(5)으로 정규화한다.
  void answerBinary({required bool isOptionA}) {
    _submitAnswer(isOptionA ? 1 : 5);
  }

  void _submitAnswer(int normalizedValue) {
    final question = currentQuestion;
    if (question == null) return;

    _answers[question.id] = normalizedValue;

    if (_currentIndex < _questions.length - 1) {
      _currentIndex++;
    }
    notifyListeners();
  }

  void goToPrevious() {
    if (_currentIndex > 0) {
      _currentIndex--;
      notifyListeners();
    }
  }

  /// 4개 축의 원점수 합계. index: [axis1, axis2, axis3, axis4]
  List<int> calculateAxisScores() {
    final scores = [0, 0, 0, 0];

    for (final question in _questions) {
      final answer = _answers[question.id];
      if (answer == null) continue;

      // 1~5 -> -2~+2 (중립값 3 기준 정규화)
      final normalized = answer - 3;
      final weighted = normalized * question.direction;

      scores[question.axis - 1] += weighted;
    }

    return scores;
  }

  /// 4자리 Type Code 산출 (예: 'SMIR').
  /// 동점(0점)은 편의상 양수 쪽 문자로 처리한다.
  String calculateResultCode() {
    final scores = calculateAxisScores();

    final buffer = StringBuffer();
    for (var i = 0; i < 4; i++) {
      buffer.write(scores[i] >= 0 ? _positiveLetters[i] : _negativeLetters[i]);
    }
    return buffer.toString();
  }

  /// Supabase user_responses.raw_answers 컬럼에 저장할 형태로 변환.
  List<Map<String, dynamic>> toRawAnswersJson() {
    return _answers.entries
        .map((e) => {'question_id': e.key, 'answer': e.value})
        .toList();
  }

  void reset() {
    _testType = null;
    _questions = const [];
    _currentIndex = 0;
    _ageGroup = null;
    _gender = null;
    _answers.clear();
    notifyListeners();
  }
}
