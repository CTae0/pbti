class PbtiType {
  const PbtiType({
    required this.code,
    required this.name,
    required this.shortDescription,
    required this.fullDescription,
    required this.keywords,
    required this.soulmatePolitician,
    required this.soulmateReason,
    required this.archenemyPolitician,
    required this.archenemyReason,
    this.imageUrl,
  });

  final String code; // e.g. 'SMIR'
  final String name; // e.g. '냉철한 정책 분석가'
  final String shortDescription;
  final String fullDescription;
  final List<String> keywords;
  final String soulmatePolitician;
  final String soulmateReason;
  final String archenemyPolitician;
  final String archenemyReason;
  final String? imageUrl;

  /// 코드 2번째 글자(축2: M=시장/G=정부)에 따라 8유형이 함께 그려진
  /// 그룹 일러스트 asset 경로를 반환한다.
  String get groupIllustrationAssetPath {
    final axis2 = code[1];
    return 'assets/images/types/${axis2}_test8.png';
  }

  factory PbtiType.fromMap(Map<String, dynamic> map) {
    return PbtiType(
      code: map['code'] as String,
      name: map['name'] as String,
      shortDescription: map['short_description'] as String,
      fullDescription: map['full_description'] as String,
      keywords: List<String>.from(map['keywords'] as List? ?? const []),
      soulmatePolitician: map['soulmate_politician'] as String,
      soulmateReason: map['soulmate_reason'] as String,
      archenemyPolitician: map['archenemy_politician'] as String,
      archenemyReason: map['archenemy_reason'] as String,
      imageUrl: map['image_url'] as String?,
    );
  }
}
