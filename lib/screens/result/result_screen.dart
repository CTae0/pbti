import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../models/pbti_type.dart';
import '../../router/app_router.dart';
import '../../services/result_repository.dart';
import '../../services/share_service.dart';
import '../../state/test_session_state.dart';
import '../../theme/app_theme.dart';
import '../../utils/session_id.dart';
import '../../widgets/premium_banner.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({super.key, required this.resultCode});

  final String resultCode;

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  late final ResultRepository _repository;
  late Future<PbtiType> _typeFuture;
  final GlobalKey _shareCardKey = GlobalKey();
  bool _responseSubmitted = false;

  @override
  void initState() {
    super.initState();
    _repository = ResultRepository(Supabase.instance.client);
    _typeFuture = _repository.fetchType(widget.resultCode);
  }

  Future<void> _submitResponseOnce(TestSessionState session) async {
    if (_responseSubmitted || session.testType == null) return;
    _responseSubmitted = true;

    final sessionId = await SessionIdProvider.getOrCreate();
    await _repository.submitResponse(
      sessionId: sessionId,
      session: session,
      resultCode: widget.resultCode,
    );
  }

  Future<void> _handleShare(PbtiType type) async {
    try {
      await ShareService.shareBoundaryAsImage(
        boundaryKey: _shareCardKey,
        fileName: 'pbti_${type.code}.png',
        shareText: '나의 정치 성향은 [${type.code}] ${type.name}! #PBTI',
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('공유에 실패했습니다: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final session = context.watch<TestSessionState>();

    // 테스트를 거치지 않고 결과 URL로 직접 들어온 경우에도 화면은 보여주되,
    // 응답 기록(user_responses insert)만 건너뛴다.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _submitResponseOnce(session);
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('나의 정치 성향'),
        actions: [
          IconButton(
            icon: const Icon(Icons.bar_chart),
            tooltip: '여론 대시보드',
            onPressed: () => context.go(AppRoutes.dashboard),
          ),
        ],
      ),
      body: FutureBuilder<PbtiType>(
        future: _typeFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError || !snapshot.hasData) {
            return Center(child: Text('결과를 불러오지 못했습니다: ${snapshot.error}'));
          }

          final type = snapshot.data!;
          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                RepaintBoundary(
                  key: _shareCardKey,
                  child: _ResultShareCard(type: type),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () => _handleShare(type),
                        icon: const Icon(Icons.share),
                        label: const Text('이미지로 공유'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: FilledButton.icon(
                        onPressed: () => context.go(AppRoutes.home),
                        icon: const Icon(Icons.refresh),
                        label: const Text('다시 테스트하기'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                _MatchSection(type: type),
                const SizedBox(height: 32),
                PremiumReportBanner(onTap: () {
                  // TODO: 실제 결제 플로우 연동
                }),
                const SizedBox(height: 16),
                const AdBannerPlaceholder(),
                const SizedBox(height: 16),
              ],
            ),
          );
        },
      ),
    );
  }
}

/// RepaintBoundary로 캡처되는 밈 공유용 카드.
class _ResultShareCard extends StatelessWidget {
  const _ResultShareCard({required this.type});

  final PbtiType type;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          colors: [AppTheme.primary, AppTheme.secondary],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        children: [
          Text(
            'PBTI',
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: Colors.white70,
                  letterSpacing: 4,
                ),
          ),
          const SizedBox(height: 12),
          Text(
            type.code,
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            type.name,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 12),
          Text(
            type.shortDescription,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.white,
                ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            alignment: WrapAlignment.center,
            children: type.keywords
                .map((k) => Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.25),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        k,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}

class _MatchSection extends StatelessWidget {
  const _MatchSection({required this.type});

  final PbtiType type;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _MatchCard(
          emoji: '🤝',
          label: '나의 소울메이트 정치인',
          politician: type.soulmatePolitician,
          reason: type.soulmateReason,
          color: AppTheme.secondary,
        ),
        const SizedBox(height: 16),
        _MatchCard(
          emoji: '⚔️',
          label: '나의 숙적(아치에너미) 정치인',
          politician: type.archenemyPolitician,
          reason: type.archenemyReason,
          color: Colors.redAccent,
        ),
      ],
    );
  }
}

class _MatchCard extends StatelessWidget {
  const _MatchCard({
    required this.emoji,
    required this.label,
    required this.politician,
    required this.reason,
    required this.color,
  });

  final String emoji;
  final String label;
  final String politician;
  final String reason;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(emoji, style: const TextStyle(fontSize: 20)),
              const SizedBox(width: 8),
              Text(
                label,
                style: Theme.of(context)
                    .textTheme
                    .labelLarge
                    ?.copyWith(color: color, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            politician,
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(reason, style: Theme.of(context).textTheme.bodySmall),
        ],
      ),
    );
  }
}
