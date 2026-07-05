import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../router/app_router.dart';
import '../../theme/app_theme.dart';
import '../../utils/responsive.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: ResponsiveCenter(
            maxWidth: Responsive.value(context, mobile: 600, tablet: 760, desktop: 960),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: Column(
              children: [
                const _HomeHeader(),
                SizedBox(height: Responsive.value(context, mobile: 32, tablet: 40, desktop: 48)),
                const _TestTrackSection(),
                const SizedBox(height: 20),
                const _DashboardLinkCard(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _HomeHeader extends StatelessWidget {
  const _HomeHeader();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'PBTI',
          style: Theme.of(context)
              .textTheme
              .headlineMedium
              ?.copyWith(
                fontWeight: FontWeight.w900,
                color: AppTheme.onGradientText,
                fontSize: Responsive.value(context, mobile: 34, tablet: 40, desktop: 46),
              ),
        ),
        const SizedBox(height: 8),
        Text(
          '나의 정치 성향은 어떤 타입일까?\n가볍게 혹은 자세하게, 지금 확인해보세요.',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.black54,
                height: 1.5,
              ),
        ),
      ],
    );
  }
}

class _TestTrackSection extends StatelessWidget {
  const _TestTrackSection();

  @override
  Widget build(BuildContext context) {
    final cards = [
      _TestTrackCard(
        emoji: '⚡',
        title: '미니 테스트',
        duration: '3분',
        questionCount: '12문항',
        description: 'A/B로 빠르게 훑어보는\n간단 버전',
        color: AppTheme.secondary,
        onTap: () => context.go(AppRoutes.miniTest),
      ),
      _TestTrackCard(
        emoji: '🔎',
        title: '상세 테스트',
        duration: '10분',
        questionCount: '40문항',
        description: '5점 척도로 정밀하게 알아보는\n정식 버전',
        color: AppTheme.primary,
        onTap: () => context.go(AppRoutes.fullTest),
      ),
    ];

    if (Responsive.isMobile(context)) {
      return Column(
        children: [
          cards[0],
          const SizedBox(height: 16),
          cards[1],
        ],
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: cards[0]),
        const SizedBox(width: 16),
        Expanded(child: cards[1]),
      ],
    );
  }
}

class _TestTrackCard extends StatelessWidget {
  const _TestTrackCard({
    required this.emoji,
    required this.title,
    required this.duration,
    required this.questionCount,
    required this.description,
    required this.color,
    required this.onTap,
  });

  final String emoji;
  final String title;
  final String duration;
  final String questionCount;
  final String description;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: color.withValues(alpha: 0.2),
                blurRadius: 16,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(emoji, style: const TextStyle(fontSize: 32)),
              const SizedBox(height: 12),
              Text(
                title,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppTheme.onGradientText,
                    ),
              ),
              const SizedBox(height: 4),
              Text(
                '$duration · $questionCount',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: AppTheme.onGradientText.withValues(alpha: 0.7),
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(height: 12),
              Text(
                description,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.black54,
                      height: 1.4,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DashboardLinkCard extends StatelessWidget {
  const _DashboardLinkCard();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => context.go(AppRoutes.dashboard),
        borderRadius: BorderRadius.circular(16),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppTheme.primary.withValues(alpha: 0.4), width: 1.5),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '실시간 여론 대시보드 보러가기',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppTheme.onGradientText,
                    ),
              ),
              const Icon(Icons.arrow_forward, color: AppTheme.onGradientText),
            ],
          ),
        ),
      ),
    );
  }
}
