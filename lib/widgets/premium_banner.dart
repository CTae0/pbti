import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// 프리미엄 리포트 결제 유도 카드.
/// 실제 결제 연동은 범위 밖이며, 클릭 시 콜백만 노출한다.
class PremiumReportBanner extends StatelessWidget {
  const PremiumReportBanner({super.key, this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [AppTheme.primary, AppTheme.secondary],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Row(
            children: [
              Icon(Icons.workspace_premium, color: Colors.white, size: 32),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '심층 정치 성향 프리미엄 리포트',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '나의 투표 성향 예측, 세부 정책 매칭까지 확인해보세요',
                      style: TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right, color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }
}

/// 광고 배너 자리 확보용 플레이스홀더.
class AdBannerPlaceholder extends StatelessWidget {
  const AdBannerPlaceholder({super.key, this.height = 90});

  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Text(
        'AD',
        style: TextStyle(color: Colors.grey.shade400, fontSize: 12),
      ),
    );
  }
}
