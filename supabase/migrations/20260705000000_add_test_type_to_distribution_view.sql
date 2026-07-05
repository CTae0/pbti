-- ============================================================
-- v_result_distribution에 test_type 추가
-- 미니 테스트와 상세 테스트의 결과 분포를 분리 집계하기 위함.
-- ============================================================

drop view if exists v_result_distribution;

create view v_result_distribution as
select
  test_type,
  result_code,
  age_group,
  gender,
  count(*) as response_count
from user_responses
where result_code is not null
group by test_type, result_code, age_group, gender;

comment on view v_result_distribution is '실시간 여론 대시보드 집계용 뷰 (개인정보 미노출, test_type별 분리 집계)';

grant select on v_result_distribution to anon, authenticated;
