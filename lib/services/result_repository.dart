import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/pbti_type.dart';
import '../models/question.dart';
import '../state/test_session_state.dart';

class ResultRepository {
  ResultRepository(this._client);

  final SupabaseClient _client;

  Future<PbtiType> fetchType(String code) async {
    final row = await _client.from('pbti_types').select().eq('code', code).single();
    return PbtiType.fromMap(row);
  }

  Future<void> submitResponse({
    required String sessionId,
    required TestSessionState session,
    required String resultCode,
    String? ageGroup,
    String? gender,
  }) async {
    final axisScores = session.calculateAxisScores();

    await _client.from('user_responses').insert({
      'session_id': sessionId,
      'test_type': session.testType!.value,
      'raw_answers': session.toRawAnswersJson(),
      'axis1_score': axisScores[0],
      'axis2_score': axisScores[1],
      'axis3_score': axisScores[2],
      'axis4_score': axisScores[3],
      'result_code': resultCode,
      'age_group': ageGroup,
      'gender': gender,
    });
  }
}
