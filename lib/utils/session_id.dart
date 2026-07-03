import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

const _prefsKey = 'pbti_session_id';

/// 기기(브라우저)에 영속되는 익명 식별자.
/// user_responses.session_id 컬럼에 사용되며, 개인 식별 정보는 포함하지 않는다.
class SessionIdProvider {
  SessionIdProvider._();

  static Future<String> getOrCreate() async {
    final prefs = await SharedPreferences.getInstance();
    final existing = prefs.getString(_prefsKey);
    if (existing != null) return existing;

    final newId = const Uuid().v4();
    await prefs.setString(_prefsKey, newId);
    return newId;
  }
}
