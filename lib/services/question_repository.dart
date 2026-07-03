import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/question.dart';

class QuestionRepository {
  QuestionRepository(this._client);

  final SupabaseClient _client;

  Future<List<Question>> fetchQuestions(TestType testType) async {
    final rows = await _client
        .from('questions')
        .select()
        .eq('test_type', testType.value)
        .eq('is_active', true)
        .order('order_index');

    return (rows as List)
        .map((row) => Question.fromMap(row as Map<String, dynamic>))
        .toList();
  }
}
