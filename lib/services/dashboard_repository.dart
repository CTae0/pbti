import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/question.dart';
import '../models/result_distribution.dart';

class DashboardRepository {
  DashboardRepository(this._client);

  final SupabaseClient _client;

  /// v_result_distribution 뷰를 조회하고, 필터가 있으면 클라이언트 측에서
  /// (age_group, gender) 기준으로 합산한다. 뷰 자체가 이미 그룹핑된 소규모
  /// 집계 데이터이므로 매번 전체를 가져와도 부담이 적다.
  Future<Map<String, int>> fetchDistribution({
    required TestType testType,
    String? ageGroup,
    String? gender,
  }) async {
    dynamic query = _client
        .from('v_result_distribution')
        .select()
        .eq('test_type', testType.value);

    if (ageGroup != null) {
      query = query.eq('age_group', ageGroup);
    }
    if (gender != null) {
      query = query.eq('gender', gender);
    }

    final rows = await query as List;
    final parsed = rows
        .map((r) => ResultDistributionRow.fromMap(r as Map<String, dynamic>))
        .toList();

    final Map<String, int> byCode = {};
    for (final row in parsed) {
      byCode[row.resultCode] = (byCode[row.resultCode] ?? 0) + row.responseCount;
    }
    return byCode;
  }
}
