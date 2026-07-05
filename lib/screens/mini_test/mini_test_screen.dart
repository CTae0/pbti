import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../models/question.dart';
import '../../router/app_router.dart';
import '../../services/question_repository.dart';
import '../../state/test_session_state.dart';
import '../../utils/responsive.dart';
import '../../widgets/ab_choice_card.dart';
import '../../widgets/demographics_intro.dart';
import '../../widgets/progress_bar.dart';

class MiniTestScreen extends StatefulWidget {
  const MiniTestScreen({super.key});

  @override
  State<MiniTestScreen> createState() => _MiniTestScreenState();
}

class _MiniTestScreenState extends State<MiniTestScreen> {
  late final QuestionRepository _repository;
  late Future<List<Question>> _questionsFuture;

  @override
  void initState() {
    super.initState();
    _repository = QuestionRepository(Supabase.instance.client);
    _questionsFuture = _repository.fetchQuestions(TestType.mini);
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

            return _MiniTestBody(questions: questions);
          },
        ),
      ),
    );
  }
}

class _MiniTestBody extends StatefulWidget {
  const _MiniTestBody({required this.questions});

  final List<Question> questions;

  @override
  State<_MiniTestBody> createState() => _MiniTestBodyState();
}

class _MiniTestBodyState extends State<_MiniTestBody> {
  bool _sessionStarted = false;

  @override
  Widget build(BuildContext context) {
    final session = context.watch<TestSessionState>();

    if (!_sessionStarted) {
      return DemographicsIntro(
        onSubmit: (ageGroup, gender) {
          context.read<TestSessionState>().startSession(
                TestType.mini,
                widget.questions,
                ageGroup: ageGroup,
                gender: gender,
              );
          setState(() => _sessionStarted = true);
        },
      );
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

    return ResponsiveCenter(
      maxWidth: Responsive.value(context, mobile: double.infinity, tablet: 640, desktop: 560),
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
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            transitionBuilder: (child, animation) => FadeTransition(
              opacity: animation,
              child: child,
            ),
            child: Column(
              key: ValueKey('choices-${question.id}'),
              children: [
                AbChoiceCard(
                  label: question.optionALabel ?? 'A',
                  onTap: () =>
                      context.read<TestSessionState>().answerBinary(isOptionA: true),
                ),
                const SizedBox(height: 16),
                AbChoiceCard(
                  label: question.optionBLabel ?? 'B',
                  onTap: () =>
                      context.read<TestSessionState>().answerBinary(isOptionA: false),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
