-- ============================================================
-- PBTI (Politics Type Indicator) - Initial Schema
-- ============================================================
-- 4 Axes:
--   Axis 1: Change(+) vs Stability(-)      -> C / S
--   Axis 2: Market(+) vs Government(-)     -> M / G
--   Axis 3: Individual(+) vs Community(-)  -> I / C
--   Axis 4: Ideal(+) vs Realism(-)         -> I / R
-- Type code = 4 letters, e.g. "SMIR"
-- ============================================================

-- ------------------------------------------------------------
-- 1. pbti_types : 16 politics types (result content)
-- ------------------------------------------------------------
create table pbti_types (
  code text primary key check (char_length(code) = 4),
  name text not null,                      -- e.g. '냉철한 정책 분석가'
  short_description text not null,         -- 카드/공유용 한 줄 요약
  full_description text not null,          -- 결과 페이지 본문
  keywords text[] not null default '{}',   -- 특성 키워드 리스트
  soulmate_politician text not null,       -- 소울메이트 정치인 이름
  soulmate_reason text not null,           -- 소울메이트 선정 이유
  archenemy_politician text not null,      -- 아치에너미 정치인 이름
  archenemy_reason text not null,          -- 아치에너미 선정 이유
  image_url text,                          -- 결과 카드 대표 이미지
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

comment on table pbti_types is '16가지 PBTI 성향 유형별 결과 콘텐츠';

-- ------------------------------------------------------------
-- 2. questions : mini(12) + full(40) test items
-- ------------------------------------------------------------
create type test_type as enum ('mini', 'full');

create table questions (
  id bigint generated always as identity primary key,
  test_type test_type not null,
  order_index integer not null,             -- 화면 노출 순서
  axis smallint not null check (axis between 1 and 4),
  -- 척도 방향: 이 문항에 '동의(찬성/긍정)'할수록 axis의 +방향으로 가중
  -- mini 문항은 A/B 양자택일이므로 weight는 항상 +1/-1 두 선택지로 처리(옵션 테이블 참고)
  direction smallint not null check (direction in (1, -1)),
  content text not null,                    -- 문항 본문
  option_a_label text,                      -- mini 전용: A안 라벨 (예: '개혁이 우선이다')
  option_b_label text,                      -- mini 전용: B안 라벨 (예: '안정이 우선이다')
  is_active boolean not null default true,
  created_at timestamptz not null default now(),
  unique (test_type, order_index)
);

comment on table questions is '미니(12문항)/상세(40문항) 테스트 문항. mini는 A/B 양자택일, full은 5점 척도';
comment on column questions.direction is '5점 척도 응답값이 +방향(동의)일 때 axis 가중 방향 (+1: 응답이 클수록 axis 양수, -1: 응답이 클수록 axis 음수)';

-- ------------------------------------------------------------
-- 3. user_responses : anonymous user test submissions
-- ------------------------------------------------------------
create table user_responses (
  id uuid primary key default gen_random_uuid(),
  session_id uuid not null,                 -- 클라이언트 로컬 생성 익명 식별자
  test_type test_type not null,

  -- 응답 원본: [{ "question_id": 1, "answer": 4 }, ...]
  -- mini: answer는 1(A선택) 또는 5(B선택)로 정규화하여 저장
  -- full: answer는 1~5 (5점 척도)
  raw_answers jsonb not null,

  -- 계산된 축 점수 (양수/음수 원점수)
  axis1_score integer not null default 0,
  axis2_score integer not null default 0,
  axis3_score integer not null default 0,
  axis4_score integer not null default 0,

  result_code text references pbti_types(code),

  -- 대시보드 필터링용 인구통계 (선택 입력)
  age_group text check (age_group in ('10s','20s','30s','40s','50s','60plus')),
  gender text check (gender in ('male', 'female', 'other', 'unspecified')),
  region text,

  created_at timestamptz not null default now()
);

comment on table user_responses is '익명 유저의 테스트 응답 및 결과. 여론 대시보드 집계의 원천 데이터';

create index idx_user_responses_result_code on user_responses (result_code);
create index idx_user_responses_created_at on user_responses (created_at);
create index idx_user_responses_demographics on user_responses (age_group, gender);

-- ------------------------------------------------------------
-- RLS: 익명 유저는 insert만 가능, 결과 집계는 view를 통해서만 read
-- ------------------------------------------------------------
alter table pbti_types enable row level security;
alter table questions enable row level security;
alter table user_responses enable row level security;

create policy "pbti_types are publicly readable"
  on pbti_types for select
  using (true);

create policy "active questions are publicly readable"
  on questions for select
  using (is_active = true);

create policy "anyone can submit a response"
  on user_responses for insert
  with check (true);

-- 유저 응답 원본은 직접 조회 불가 (대시보드는 아래 집계 view만 사용)
create policy "no direct read of raw responses"
  on user_responses for select
  using (false);

-- ------------------------------------------------------------
-- 대시보드용 집계 view (개인 식별 정보 없이 노출)
-- ------------------------------------------------------------
create view v_result_distribution as
select
  result_code,
  age_group,
  gender,
  count(*) as response_count
from user_responses
where result_code is not null
group by result_code, age_group, gender;

comment on view v_result_distribution is '실시간 여론 대시보드 집계용 뷰 (개인정보 미노출)';

grant select on v_result_distribution to anon, authenticated;
