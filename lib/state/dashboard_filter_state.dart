import 'package:flutter/foundation.dart';

class DashboardFilterState extends ChangeNotifier {
  String? _ageGroup; // null = 전체
  String? _gender; // null = 전체

  String? get ageGroup => _ageGroup;
  String? get gender => _gender;

  static const ageGroups = ['10s', '20s', '30s', '40s', '50s', '60plus'];
  static const genders = ['male', 'female', 'other', 'unspecified'];

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
