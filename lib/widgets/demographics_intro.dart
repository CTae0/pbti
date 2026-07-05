import 'package:flutter/material.dart';

import '../state/dashboard_filter_state.dart';
import '../theme/app_theme.dart';
import '../utils/responsive.dart';

/// 테스트 시작 직전, 연령대/성별을 선택사항으로 입력받는 화면.
/// 입력하지 않아도 "시작하기"로 건너뛸 수 있다.
class DemographicsIntro extends StatefulWidget {
  const DemographicsIntro({super.key, required this.onSubmit});

  final void Function(String? ageGroup, String? gender) onSubmit;

  @override
  State<DemographicsIntro> createState() => _DemographicsIntroState();
}

class _DemographicsIntroState extends State<DemographicsIntro> {
  static const _ageLabels = {
    '10s': '10대',
    '20s': '20대',
    '30s': '30대',
    '40s': '40대',
    '50s': '50대',
    '60plus': '60대+',
  };

  static const _genderLabels = {
    'male': '남성',
    'female': '여성',
    'other': '기타',
    'unspecified': '선택 안함',
  };

  String? _selectedAge;
  String? _selectedGender;
  bool _ageChosen = false;
  bool _genderChosen = false;

  bool get _canStart => _ageChosen && _genderChosen;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: SingleChildScrollView(
          child: ResponsiveCenter(
            maxWidth: Responsive.value(context, mobile: double.infinity, tablet: 480, desktop: 440),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '몇 가지만 알려주세요',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppTheme.onGradientText,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  '여론 통계에만 사용되며, 입력하지 않아도 괜찮아요.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.black54),
                ),
                const SizedBox(height: 32),
                const _SectionLabel('연령대'),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  alignment: WrapAlignment.center,
                  children: [
                    ...DashboardFilterState.ageGroups.map(
                      (a) => FilterChip(
                        label: Text(_ageLabels[a] ?? a),
                        selected: _ageChosen && _selectedAge == a,
                        onSelected: (_) => setState(() {
                          _selectedAge = a;
                          _ageChosen = true;
                        }),
                      ),
                    ),
                    FilterChip(
                      label: const Text('선택 안함'),
                      selected: _ageChosen && _selectedAge == null,
                      onSelected: (_) => setState(() {
                        _selectedAge = null;
                        _ageChosen = true;
                      }),
                    ),
                  ],
                ),
                const SizedBox(height: 28),
                const _SectionLabel('성별'),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  alignment: WrapAlignment.center,
                  children: DashboardFilterState.genders
                      .map(
                        (g) => FilterChip(
                          label: Text(_genderLabels[g] ?? g),
                          selected: _genderChosen && _selectedGender == g,
                          onSelected: (_) => setState(() {
                            _selectedGender = g;
                            _genderChosen = true;
                          }),
                        ),
                      )
                      .toList(),
                ),
                const SizedBox(height: 36),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: _canStart
                        ? () => widget.onSubmit(_selectedAge, _selectedGender)
                        : null,
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: Text('시작하기'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: AppTheme.onGradientText,
          ),
    );
  }
}
