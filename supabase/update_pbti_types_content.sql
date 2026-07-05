-- ============================================================
-- pbti_types 16개 유형 콘텐츠 전면 개편
-- 사용자 제공 매칭표 기반, 사례 중심 설명으로 재작성.
-- 정치인 매칭은 정책 성향/스타일 기준이며, 시사성 있는 서술(재판, 거취 등)은 제외.
-- ============================================================

update pbti_types set
  name = '거침없는 자유혁신가',
  short_description = '낡은 규제를 부수고 능력으로 승부하는 개혁가',
  full_description = '"오래된 규칙이 불공정하다면 바꾸는 게 맞다"고 믿는 유형입니다. 학교나 회사에서 연공서열보다 실력이 우선되어야 한다고 생각하고, 낡은 관행에 예외 없이 문제를 제기합니다. 경쟁을 두려워하지 않고, 규제가 진입장벽을 만든다면 과감히 걷어내야 한다고 봅니다.',
  keywords = array['능력주의', '공정경쟁', '규제완화', '직진형'],
  soulmate_politician = '이준석',
  soulmate_reason = '능력주의와 공정경쟁을 앞세워 낡은 관행에 거침없이 문제를 제기하는 스타일이 CMII와 맞닿아 있습니다.',
  archenemy_politician = '이재명',
  archenemy_reason = '정부 주도의 재분배와 공동체 중심 정책을 우선하는 노선이 CMII의 시장·개인 중심 접근과 대비됩니다.'
where code = 'CMII';

update pbti_types set
  name = '실용적 데이터 분석가',
  short_description = '이념보다 데이터로 문제를 푸는 현실주의자',
  full_description = '어떤 사안이든 "일단 데이터부터 보자"는 태도를 가진 유형입니다. 친구들과 논쟁할 때도 감정이나 진영논리보다 통계와 근거를 먼저 찾고, 정책 하나를 판단할 때도 실제 효과가 검증됐는지를 따집니다. 변화 자체는 지지하지만, 그 변화가 실질적으로 작동하는지가 더 중요합니다.',
  keywords = array['실용주의', '데이터기반', '개인주의', '개혁'],
  soulmate_politician = '안철수',
  soulmate_reason = '이념보다 과학·데이터 기반의 문제해결을 우선하는 태도가 CMIR과 잘 맞습니다.',
  archenemy_politician = '심상정',
  archenemy_reason = '도덕적 이상과 연대를 우선하는 가치 지향이 CMIR의 데이터·효율 중심 접근과 대비됩니다.'
where code = 'CMIR';

update pbti_types set
  name = '합리적 연대주의자',
  short_description = '시장의 효율과 공동체의 책임을 함께 보는 유형',
  full_description = '동아리나 회사에서 "효율은 챙기되 다 같이 잘 되는 방법"을 고민하는 유형입니다. 경쟁과 자율을 지지하면서도, 그 결과가 공동체 전체에 무리 없이 돌아가는지를 함께 신경 씁니다. 시장 원리를 믿지만 그것이 배려나 책임과 배치된다고 생각하지 않습니다.',
  keywords = array['시장친화', '공동체', '공화주의', '균형감각'],
  soulmate_politician = '유승민',
  soulmate_reason = '시장 원리와 공동체적 책임을 동시에 강조하는 태도가 CMCI와 통합니다.',
  archenemy_politician = '홍준표',
  archenemy_reason = '개인 중심의 직설적 경쟁 우선 태도가 CMCI가 지향하는 공동체적 균형과 대비됩니다.'
where code = 'CMCI';

update pbti_types set
  name = '미래지향적 기획자',
  short_description = '시장친화적 인프라로 변화를 실현하는 실행가',
  full_description = '"바꾸려면 눈에 보이는 결과물을 만들어야 한다"고 믿는 유형입니다. 동네나 조직의 오래된 시설, 낡은 시스템을 인프라 투자와 실행력으로 개선하는 데 관심이 많고, 아이디어보다 실제 완공된 결과를 중시합니다. 다만 그 과정에서 소외되는 이들을 함께 챙기는 것도 중요하게 생각합니다.',
  keywords = array['인프라혁신', '시장친화', '실행력', '약자동행'],
  soulmate_politician = '오세훈',
  soulmate_reason = '시장친화적 인프라 혁신과 실행력을 앞세우면서도 약자동행을 함께 강조하는 스타일이 CMCR과 닮아 있습니다.',
  archenemy_politician = '조국',
  archenemy_reason = '절차적 정의와 이념적 선명성을 우선하는 태도가 CMCR의 실리·성과 중심 접근과 대비됩니다.'
where code = 'CMCR';

update pbti_types set
  name = '선명성 우선 명분주의자',
  short_description = '타협 없이 원칙을 지키는 개혁가',
  full_description = '"맞다고 생각하면 끝까지 밀고 나간다"는 유형입니다. 팀 프로젝트에서 편법으로 빨리 끝낼 수 있어도 원칙대로 정공법을 택하고, 다수의 눈치를 보기보다 스스로 옳다고 믿는 방향으로 직진합니다. 개혁을 지지하되 그 개혁이 지켜야 할 가치와 명분에서 벗어나지 않아야 한다고 봅니다.',
  keywords = array['선명성', '원칙주의', '개인주의', '명분'],
  soulmate_politician = '조국',
  soulmate_reason = '이념적 선명성과 타협 없는 직진, 원칙을 앞세우는 태도가 CGII와 강하게 공명합니다.',
  archenemy_politician = '오세훈',
  archenemy_reason = '실리와 성과를 우선하는 실용적 접근이 CGII가 지키려는 명분·원칙과 대비됩니다.'
where code = 'CGII';

update pbti_types set
  name = '실용적 국가 개혁가',
  short_description = '관료적 실용과 진보 가치를 함께 추구하는 유형',
  full_description = '"바뀌는 건 좋은데, 당장 체감되는 변화였으면 좋겠다"고 생각하는 유형입니다. 정부나 조직이 나서서 문제를 해결해야 한다고 믿지만, 그 방식은 구호보다 즉각적인 효과와 기회를 만드는 쪽을 선호합니다. 이상보다 오늘 당장 달라지는 것에 관심이 많습니다.',
  keywords = array['실용주의', '정부개입', '기회', '체감성과'],
  soulmate_politician = '김동연',
  soulmate_reason = '관료적 실용주의와 진보적 가치를 결합해 즉각적인 효능감을 추구하는 태도가 CGIR과 맞닿아 있습니다.',
  archenemy_politician = '김진태',
  archenemy_reason = '강경한 질서·통제를 우선하는 태도가 CGIR의 유연한 진보적 개입과 대비됩니다.'
where code = 'CGIR';

update pbti_types set
  name = '포용적 평등주의자',
  short_description = '노동과 연대의 가치를 지키는 이상주의자',
  full_description = '"함께 가야 진짜 바뀐다"고 믿는 유형입니다. 동창회 회비를 걷어 어려운 친구를 돕자는 제안에 가장 먼저 동의하고, 노동·인권·환경 같은 가치를 실현하는 데 정부가 적극적인 역할을 해야 한다고 생각합니다. 국가가 공동체 전체를 무한히 책임져야 한다는 믿음이 강합니다.',
  keywords = array['평등주의', '연대', '노동인권', '이상주의'],
  soulmate_politician = '심상정',
  soulmate_reason = '노동·인권·환경 가치와 국가의 무한 책임, 연대를 강조하는 태도가 CGCI와 강하게 공명합니다.',
  archenemy_politician = '이준석',
  archenemy_reason = '개인의 능력주의와 경쟁을 우선하는 태도가 CGCI의 연대·평등 지향과 대비됩니다.'
where code = 'CGCI';

update pbti_types set
  name = '실행력 강한 현실주의자',
  short_description = '정부 주도로 성과를 밀어붙이는 행동가',
  full_description = '"복지도 결국 실현돼야 의미가 있다"고 믿는 유형입니다. 회사에서 다 함께 야근하는 분위기라면 팀을 위해 남는 쪽을 택하듯, 공동체를 위한 결정이라면 다소 강하게라도 밀어붙이는 것을 주저하지 않습니다. 정부가 적극적으로 개입해 억강부약(강자를 누르고 약자를 돕는)의 성과를 만들어야 한다고 생각합니다.',
  keywords = array['실행력', '정부주도', '복지', '억강부약'],
  soulmate_politician = '이재명',
  soulmate_reason = '정부 주도의 성과와 복지를 강하게 추진하는 실행력이 CGCR과 맞닿아 있습니다.',
  archenemy_politician = '한동훈',
  archenemy_reason = '법치와 제도적 절차를 우선하는 엘리트주의적 접근이 CGCR의 실행 중심 성과주의와 대비됩니다.'
where code = 'CGCR';

update pbti_types set
  name = '전통적 자유주의자',
  short_description = '제도와 원칙 안에서 개인의 자유를 지키는 유형',
  full_description = '"바꾸는 것보다 지켜야 할 원칙을 지키는 게 우선"이라고 믿는 유형입니다. 오래된 규정이라도 문제가 없다면 그대로 두는 편을 택하고, 법과 제도의 틀 안에서 개인의 자유와 신념을 정교하게 방어하는 것을 중요하게 생각합니다. 감정보다 논리와 원칙으로 설득하는 편입니다.',
  keywords = array['법치주의', '제도수호', '개인주의', '원칙방어'],
  soulmate_politician = '한동훈',
  soulmate_reason = '법치와 헌법질서, 정교한 논리로 개인의 자유와 원칙을 방어하는 태도가 SMII와 잘 맞습니다.',
  archenemy_politician = '이재명',
  archenemy_reason = '정부 주도의 실행력과 성과주의가 SMII의 제도·원칙 중심 접근과 대비됩니다.'
where code = 'SMII';

update pbti_types set
  name = '냉철한 정책 분석가',
  short_description = '데이터와 시장 원리로 세상을 읽는 현실주의자',
  full_description = '"강자든 약자든 시장의 규칙 안에서 스스로 답을 찾아야 한다"고 믿는 유형입니다. 배달 플랫폼 수수료 논쟁에서도 규제보다는 경쟁 속에서 적정선이 찾아진다고 보고, 돌려 말하기보다 직설적으로 의견을 냅니다. 감정보다 데이터를 앞세우고, 이상보다 실현 가능성을 따집니다.',
  keywords = array['현실주의', '시장친화', '직설화법', '데이터기반'],
  soulmate_politician = '홍준표',
  soulmate_reason = '직설적 화법과 강자생존·자유시장 실용주의가 SMIR 유형의 가치관과 맞닿아 있습니다.',
  archenemy_politician = '심상정',
  archenemy_reason = '급진적 변화와 공동체 중심 재분배를 강조하는 노선이 SMIR과 정반대 축에 있습니다.'
where code = 'SMIR';

update pbti_types set
  name = '전통적 가치 수호자',
  short_description = '가족과 공동체의 전통적 가치를 지키는 유형',
  full_description = '"오래 지켜온 것에는 이유가 있다"고 믿는 유형입니다. 동네에 재개발 이야기가 나와도 지금 이대로도 충분히 좋다고 느끼고, 가족·안보·공동체 같은 전통적 가치를 우선시합니다. 시장의 자율성을 지지하면서도 그 바탕에는 정통적인 질서와 관습이 있어야 한다고 생각합니다.',
  keywords = array['전통가치', '공동체', '안보', '가족중심'],
  soulmate_politician = '나경원',
  soulmate_reason = '정통 보수의 가족·안보·공동체 전통가치를 중시하는 태도가 SMCI와 통합니다.',
  archenemy_politician = '김동연',
  archenemy_reason = '실용적 기회와 즉각적 효능감을 우선하는 태도가 SMCI의 전통가치 수호와 대비됩니다.'
where code = 'SMCI';

update pbti_types set
  name = '실용적 보수주의자',
  short_description = '안정 속에서 시장 친화적으로 조율하는 관리자',
  full_description = '"급하게 바꾸기보다 안정적으로 관리하는 게 낫다"고 믿는 유형입니다. 팀 프로젝트에서 신념보다 조건이 좋으면 그 길을 택하는 실용적인 태도를 가지고 있고, 거시적인 안정을 지키면서도 시장 친화적인 방향으로 점진적으로 조율해 나가는 것을 선호합니다.',
  keywords = array['안정관리', '시장친화', '점진조율', '실용주의'],
  soulmate_politician = '추경호',
  soulmate_reason = '거시경제 안정관리와 시장친화적 점진 조율을 중시하는 스타일이 SMCR과 맞닿아 있습니다.',
  archenemy_politician = '조국',
  archenemy_reason = '이념적 선명성과 원칙을 우선하는 태도가 SMCR의 실용적 안정 지향과 대비됩니다.'
where code = 'SMCR';

update pbti_types set
  name = '원칙주의 행정가',
  short_description = '공권력과 제도의 엄정함을 지키는 유형',
  full_description = '"규칙은 규칙대로 지켜져야 한다"고 믿는 유형입니다. 룸메이트와 청소 당번을 정할 때도 다 같이 정한 규칙을 예외 없이 지키는 걸 선호하고, 공권력이나 제도의 엄정함이 흔들리면 사회 전체가 흔들린다고 생각합니다. 안정과 질서를 지키는 것이 최우선 가치입니다.',
  keywords = array['질서주의', '제도수호', '공동체', '원칙'],
  soulmate_politician = '김진태',
  soulmate_reason = '공권력과 제도의 엄정함, 보수적 원칙과 질서를 수호하는 태도가 SGII와 공명합니다.',
  archenemy_politician = '김동연',
  archenemy_reason = '유연한 진보적 개입과 실용적 성과를 우선하는 태도가 SGII의 질서·원칙 중심 접근과 대비됩니다.'
where code = 'SGII';

update pbti_types set
  name = '유연한 타협가',
  short_description = '극단을 피하고 아우르며 조율하는 안정추구자',
  full_description = '"모두를 만족시킬 수는 없어도, 극단으로 가지 않는 게 중요하다"고 믿는 유형입니다. 여행 계획이 어긋나도 일정을 바꿔서라도 실속 있게 조율하는 편이고, 여야나 지역, 세대 간 입장 차이를 무리 없이 아우르는 데 능숙합니다. 안정적인 통합과 조율을 최우선 가치로 둡니다.',
  keywords = array['조율형', '통합', '안정추구', '중도실용'],
  soulmate_politician = '김부겸',
  soulmate_reason = '극단을 배제하고 여야·지역을 아우르는 조율과 안정 추구가 SGIR과 잘 맞습니다.',
  archenemy_politician = '이준석',
  archenemy_reason = '선명한 개인주의와 급진적 경쟁 우선 태도가 SGIR의 통합·조율 지향과 대비됩니다.'
where code = 'SGIR';

update pbti_types set
  name = '공동체 수호자',
  short_description = '정부가 공동체를 지켜야 한다고 믿는 신중한 이상주의자',
  full_description = '"공동체가 흔들리지 않도록 지키는 게 우선"이라고 믿는 유형입니다. 동아리나 조직에서 회장이 원칙을 세워 관리해야 안심이 된다고 느끼고, 정부가 공동체의 안정을 책임지고 지켜야 한다고 생각합니다. 신중하면서도 공동체적 이상과 연대를 함께 중요하게 여깁니다.',
  keywords = array['공동체수호', '정부개입', '안정주의', '신중함'],
  soulmate_politician = '심상정',
  soulmate_reason = '공동체 보호와 정부 역할을 강조하는 원칙적 태도가 SGCI와 공명합니다.',
  archenemy_politician = '이준석',
  archenemy_reason = '개인주의적이고 급진적인 변화 지향이 SGCI의 공동체 수호 성향과 대비됩니다.'
where code = 'SGCI';

update pbti_types set
  name = '신중한 균형 실무자',
  short_description = '공동체의 안정을 실용적으로 지켜내는 조율자',
  full_description = '"원칙도 중요하지만 결국 잘 돌아가는 게 우선"이라고 믿는 유형입니다. 절차와 품격을 지키면서도 실질적으로 공동체 전체에 도움이 되는 실용적인 관리 방식을 선호합니다. 정부의 역할을 신뢰하되 안정을 우선시하며, 신중한 복지국가 운영을 중요하게 생각합니다.',
  keywords = array['안정주의', '공동체', '실용주의', '균형감각'],
  soulmate_politician = '이낙연',
  soulmate_reason = '절차와 품격, 신중한 복지국가 관리를 중시하는 스타일이 SGCR과 맞닿아 있습니다.',
  archenemy_politician = '홍준표',
  archenemy_reason = '직설적이고 급진적인 시장 우선 태도가 SGCR의 신중한 균형 지향과 대비됩니다.'
where code = 'SGCR';
