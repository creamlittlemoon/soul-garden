# 05 — Data / API / Analytics (Supabase-oriented)

## 1. 数据表（最小集合）
### quotes
text, author, source, language, license,
imagery_tags(text[]), scent_tags(text[]), attribute_tags(text[])

### interactions
user_id, quote_id, action(like/skip/save/flip), created_at

### user_growth（快照）
user_id, xp, stage, calm, courage, clarity, scent_scores(jsonb), updated_at

### daily_whisper（可选）
date, quote_id

## 2. 关键接口（逻辑）
GET daily_whisper
GET quotes/feed
POST interactions
GET profile

## 3. 事件埋点（MVP）
app_open, view_daily_whisper, enter_garden, start_explore,
quote_like, quote_save, quote_flip, explore_complete,
level_up, view_profile, paywall_view, subscribe_success
