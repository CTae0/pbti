class ResultDistributionRow {
  const ResultDistributionRow({
    required this.testType,
    required this.resultCode,
    required this.ageGroup,
    required this.gender,
    required this.responseCount,
  });

  final String testType;
  final String resultCode;
  final String? ageGroup;
  final String? gender;
  final int responseCount;

  factory ResultDistributionRow.fromMap(Map<String, dynamic> map) {
    return ResultDistributionRow(
      testType: map['test_type'] as String,
      resultCode: map['result_code'] as String,
      ageGroup: map['age_group'] as String?,
      gender: map['gender'] as String?,
      responseCount: map['response_count'] as int,
    );
  }
}
