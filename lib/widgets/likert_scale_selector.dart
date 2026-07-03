import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// MBTI류 테스트의 5점 척도 선택 UI.
/// 원형 버튼 5개를 좌(비동의)~우(동의) 배치하고, 버튼 크기로 강도를 시각화한다.
class LikertScaleSelector extends StatelessWidget {
  const LikertScaleSelector({
    super.key,
    required this.onSelect,
    this.selectedValue,
  });

  final ValueChanged<int> onSelect;
  final int? selectedValue;

  static const _sizes = [52.0, 44.0, 36.0, 44.0, 52.0];
  static const _leftLabel = '전혀 그렇지 않다';
  static const _rightLabel = '매우 그렇다';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: List.generate(5, (i) {
            final value = i + 1;
            final isSelected = selectedValue == value;
            return _ScaleDot(
              size: _sizes[i],
              isSelected: isSelected,
              onTap: () => onSelect(value),
            );
          }),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(_leftLabel, style: Theme.of(context).textTheme.bodySmall),
            Text(_rightLabel, style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
      ],
    );
  }
}

class _ScaleDot extends StatelessWidget {
  const _ScaleDot({
    required this.size,
    required this.isSelected,
    required this.onTap,
  });

  final double size;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isSelected ? AppTheme.primary : Colors.white,
          border: Border.all(
            color: isSelected ? AppTheme.primary : Colors.grey.shade400,
            width: 2,
          ),
        ),
      ),
    );
  }
}
