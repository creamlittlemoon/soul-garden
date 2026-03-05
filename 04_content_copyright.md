# 04 — Content & Copyright Strategy

## 1. 三类内容池（推荐）
- 原创（AI 生成 + 人工编辑）：60–80%
- 公版（Public Domain）：10–20%
- 现代书籍短引用：<10%（MVP 可先不做）

## 2. 现代书摘的风险控制（若必须使用）
- 尽量短（建议 < 120 characters）
- 必须标注 author + source
- 避免同一本书大量连续摘录
- 记录 license=short_quote + source_detail

## 3. 内容记录字段
text, author, source, language, license,
imagery_tags[], scent_tags[], attribute_tags[]

## 4. 生成与打标约束（给 LLM）
- tags 必须从固定集合中选择（不可发明）
- imagery 2–5；scent 2–4；attribute 1–2
