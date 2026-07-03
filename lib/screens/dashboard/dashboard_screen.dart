import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../services/dashboard_repository.dart';
import '../../state/dashboard_filter_state.dart';
import '../../theme/app_theme.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late final DashboardRepository _repository;

  @override
  void initState() {
    super.initState();
    _repository = DashboardRepository(Supabase.instance.client);
  }

  @override
  Widget build(BuildContext context) {
    final filter = context.watch<DashboardFilterState>();

    return Scaffold(
      appBar: AppBar(title: const Text('실시간 여론 대시보드')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _FilterBar(filter: filter),
            const SizedBox(height: 24),
            Expanded(
              child: FutureBuilder<Map<String, int>>(
                future: _repository.fetchDistribution(
                  ageGroup: filter.ageGroup,
                  gender: filter.gender,
                ),
                builder: (context, snapshot) {
                  if (snapshot.connectionState != ConnectionState.done) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('데이터를 불러오지 못했습니다: ${snapshot.error}'));
                  }

                  final distribution = snapshot.data ?? {};
                  if (distribution.isEmpty) {
                    return const Center(child: Text('아직 집계된 응답이 없습니다.'));
                  }

                  return _DistributionChart(distribution: distribution);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FilterBar extends StatelessWidget {
  const _FilterBar({required this.filter});

  final DashboardFilterState filter;

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
    'unspecified': '미응답',
  };

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        DropdownButton<String?>(
          value: filter.ageGroup,
          hint: const Text('연령 전체'),
          items: [
            const DropdownMenuItem(value: null, child: Text('연령 전체')),
            ...DashboardFilterState.ageGroups.map(
              (a) => DropdownMenuItem(value: a, child: Text(_ageLabels[a] ?? a)),
            ),
          ],
          onChanged: (value) => filter.setAgeGroup(value),
        ),
        DropdownButton<String?>(
          value: filter.gender,
          hint: const Text('성별 전체'),
          items: [
            const DropdownMenuItem(value: null, child: Text('성별 전체')),
            ...DashboardFilterState.genders.map(
              (g) => DropdownMenuItem(value: g, child: Text(_genderLabels[g] ?? g)),
            ),
          ],
          onChanged: (value) => filter.setGender(value),
        ),
        if (filter.ageGroup != null || filter.gender != null)
          TextButton(
            onPressed: filter.reset,
            child: const Text('필터 초기화'),
          ),
      ],
    );
  }
}

class _DistributionChart extends StatelessWidget {
  const _DistributionChart({required this.distribution});

  final Map<String, int> distribution;

  @override
  Widget build(BuildContext context) {
    final codes = distribution.keys.toList()..sort();
    final maxCount = distribution.values.fold<int>(0, (a, b) => a > b ? a : b);

    return BarChart(
      BarChartData(
        maxY: (maxCount * 1.2).clamp(1, double.infinity),
        barTouchData: BarTouchData(
          touchTooltipData: BarTouchTooltipData(
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              final code = codes[group.x.toInt()];
              return BarTooltipItem(
                '$code\n${rod.toY.toInt()}명',
                const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              );
            },
          ),
        ),
        titlesData: FlTitlesData(
          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 36,
              getTitlesWidget: (value, meta) => Text(
                value.toInt().toString(),
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                final index = value.toInt();
                if (index < 0 || index >= codes.length) return const SizedBox.shrink();
                return Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    codes[index],
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                );
              },
            ),
          ),
        ),
        gridData: const FlGridData(drawVerticalLine: false),
        borderData: FlBorderData(show: false),
        barGroups: [
          for (var i = 0; i < codes.length; i++)
            BarChartGroupData(
              x: i,
              barRods: [
                BarChartRodData(
                  toY: distribution[codes[i]]!.toDouble(),
                  color: AppTheme.primary,
                  width: 22,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(6)),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
