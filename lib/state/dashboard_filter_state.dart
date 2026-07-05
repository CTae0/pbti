import 'package:flutter/foundation.dart';

import '../models/question.dart';

class DashboardFilterState extends ChangeNotifier {
  TestType _testType = TestType.mini;
  String? _ageGroup; // null = 전체
  String? _gender; // null = 전체

  TestType get testType => _testType;
  String? get ageGroup => _ageGroup;
  String? get gender => _gender;

  static const ageGroups = ['10s', '20s', '30s', '40s', '50s', '60plus'];
  static const genders = ['male', 'female', 'other', 'unspecified'];

  void setTestType(TestType value) {
    _testType = value;
    notifyListeners();
  }

  void setAgeGroup(String? value) {
    _ageGroup = value;
    notifyListeners();
  }

  void setGender(String? value) {
    _gender = value;
    notifyListeners();
  }

  void reset() {
    _ageGroup = null;
    _gender = null;
    notifyListeners();
  }
}
