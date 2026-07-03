import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../models/question.dart';
import '../../router/app_router.dart';
import '../../services/question_repository.dart';
import '../../state/test_session_state.dart';
import '../../widgets/likert_scale_selector.dart';
import '../../widgets/progress_bar.dart';

class FullTestScreen extends StatefulWidget {
  const FullTestScreen({super.key});

  @override
  State<FullTestScreen> createState() => _FullTestScreenState();
}

class _FullTestScreenState extends State<FullTestScreen> {
  late final QuestionRepository _repository;
  late Future<List<Question>> _questionsFuture;

  @override
  void initState() {
    super.initState();
    _repository = QuestionRepository(Supabase.instance.client);
    _questionsFuture = _repository.fetchQuestions(TestType.full);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<List<Question>>(
          future: _questionsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text('문항을 불러오지 못했습니다: ${snapshot.error}'));
            }

            final questions = snapshot.data ?? const [];
            if (questions.isEmpty) {
              return const Center(child: Text('등록된 문항이 없습니다.'));
            }

            return _FullTestBody(questions: questions);
          },
        ),
      ),
    );
  }
}

class _FullTestBody extends StatefulWidget {
  const _FullTestBody({required this.questions});

  final List<Question> questions;

  @override
  State<_FullTestBody> createState() => _FullTestBodyState();
}

class _FullTestBodyState extends State<_FullTestBody> {
  bool _sessionStarted = false;

  @override
  Widget build(BuildContext context) {
    final session = context.watch<TestSessionState>();

    if (!_sessionStarted) {
      // build 중 상태 변경을 피하기 위해 다음 프레임에 시작
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        context.read<TestSessionState>().startSession(TestType.full, widget.questions);
        setState(() => _sessionStarted = true);
      });
      return const Center(child: CircularProgressIndicator());
    }

    if (session.isComplete) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        final code = session.calculateResultCode();
        context.go(AppRoutes.resultPath(code));
      });
      return const Center(child: CircularProgressIndicator());
    }

    final question = session.currentQuestion;
    if (question == null) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (session.currentIndex > 0)
                IconButton(
                  onPressed: () => context.read<TestSessionState>().goToPrevious(),
                  icon: const Icon(Icons.arrow_back_ios_new),
                ),
              Expanded(
                child: TestProgressBar(
                  progress: session.progress,
                  currentStep: session.currentIndex + 1,
                  totalSteps: session.totalQuestions,
                ),
              ),
            ],
          ),
          const Spacer(),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            transitionBuilder: (child, animation) => FadeTransition(
              opacity: animation,
              child: child,
            ),
            child: Text(
              question.content,
              key: ValueKey(question.id),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ),
          const Spacer(),
          LikertScaleSelector(
            key: ValueKey('scale-${question.id}'),
            onSelect: (value) => context.read<TestSessionState>().answerLikert(value),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
