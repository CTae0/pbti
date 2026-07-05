-- ============================================================
-- 미니 테스트(12문항) 문구 개선: 추상적 정치 개념 -> 일상 사례 기반
-- 기존 axis/direction 방향은 그대로 유지 (A안=음수 방향, B안=양수 방향)
-- seed.sql을 이미 실행한 DB에 적용하는 UPDATE문 (재실행해도 안전)
-- ============================================================

update questions set
  content = '다니는 학교/회사가 오래된 규정을 유지 중이다. 나는?',
  option_a_label = '문제없으면 그대로 두는 게 낫다',
  option_b_label = '낡았으면 바꿔봐야 안다'
where test_type = 'mini' and order_index = 1;

update questions set
  content = '단골 카페가 메뉴판을 싹 바꾼다고 한다. 나는?',
  option_a_label = '이전 메뉴가 좋았는데 아쉽다',
  option_b_label = '새로운 시도니까 기대된다'
where test_type = 'mini' and order_index = 2;

update questions set
  content = '우리 동네에 재개발 이야기가 나왔다. 나는?',
  option_a_label = '지금 이대로도 충분히 좋다',
  option_b_label = '낡은 동네는 정비가 필요하다'
where test_type = 'mini' and order_index = 3;

update questions set
  content = '학교 앞 문구점 가격이 들쭉날쭉하다. 나는?',
  option_a_label = '정부가 가격 기준을 정해줘야 한다',
  option_b_label = '가게마다 다른 게 자연스럽다'
where test_type = 'mini' and order_index = 4;

update questions set
  content = '동아리 회비를 어떻게 쓸지 정할 때, 나는?',
  option_a_label = '회장(운영진)이 원칙을 세워 관리해야 한다',
  option_b_label = '각자 알아서 쓰고 나중에 정산하면 된다'
where test_type = 'mini' and order_index = 5;

update questions set
  content = '새로 생긴 배달 플랫폼이 수수료를 마음대로 정한다. 나는?',
  option_a_label = '규제가 필요하다',
  option_b_label = '경쟁하다 보면 알아서 적정선을 찾는다'
where test_type = 'mini' and order_index = 6;

update questions set
  content = '룸메이트와 청소 당번을 정할 때, 나는?',
  option_a_label = '다 같이 규칙을 정해 지키는 게 맞다',
  option_b_label = '각자 자기 공간만 챙기면 된다'
where test_type = 'mini' and order_index = 7;

update questions set
  content = '동창회 회비를 걷어 어려운 친구를 돕자고 한다. 나는?',
  option_a_label = '다 같이 돕는 게 당연하다',
  option_b_label = '개인 사정이니 강요는 안 된다'
where test_type = 'mini' and order_index = 8;

update questions set
  content = '회사에서 다 함께 야근하는 분위기다. 나는?',
  option_a_label = '팀을 위해 남는 게 맞다',
  option_b_label = '내 할 일 끝나면 먼저 갈 수 있다'
where test_type = 'mini' and order_index = 9;

update questions set
  content = '가고 싶던 회사가 알고 보니 평판이 안 좋다. 나는?',
  option_a_label = '그래도 조건이 좋으면 간다',
  option_b_label = '신념에 안 맞으면 포기한다'
where test_type = 'mini' and order_index = 10;

update questions set
  content = '팀 프로젝트에서 편법을 쓰면 더 빨리 끝난다. 나는?',
  option_a_label = '결과가 중요하니 편법도 고려한다',
  option_b_label = '원칙대로 시간이 걸려도 정공법으로 간다'
where test_type = 'mini' and order_index = 11;

update questions set
  content = '친구와 여행 계획이 어긋났다. 나는?',
  option_a_label = '일정 바꿔서라도 실속 있게 간다',
  option_b_label = '처음 약속한 대로 밀고 나간다'
where test_type = 'mini' and order_index = 12;
