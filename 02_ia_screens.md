# 02 — Information Architecture & Screens

## 1. 页面清单（MVP）
1) Opening / Daily Whisper  
2) Garden Home  
3) Explore (Quote Cards)  
4) Profile (Growth + Scent Identity + Collection 入口)  

## 2. Opening / Daily Whisper
### 目的
- 建立仪式感：今天的“安抚句子”
- 一键进入花园

### UI 组件
- 背景：模糊花园渐变 + 微粒子
- 中央 Quote 文本（Serif）
- 底部按钮：`Enter Garden`
- 次级：`Save`（收藏今日句）

### 状态
- 首次启动：onboarding 一句话（可选）
- 非首次：直接显示 daily whisper

## 3. Garden Home
### 目的
- 展示“我在成长”
- 快速入口：Explore
- 轻量展示属性与能量

### UI 组件
- 背景花园（随 stage 更丰富）
- 中央：Tree（stage 形态 + 呼吸动效）
- 资源（可选）：Sunlight / Dew（象征能量）
- 属性条：Calm / Courage / Clarity（3 个）
- CTA：`Explore`
- 入口：`Profile`

### 关键反馈
- like 后回到 Home：Tree 有轻微增大/光晕反馈（可选）
- level up 时：出现“月光洒落”动效 + 温柔文案

## 4. Explore — Quote Cards（点击式）
### 目的
- 让用户做选择（like/save/skip）
- 通过“翻面”看标签与气味，产生好奇

### UI 组件（单卡）
- Quote 文本
- Source（作者/书名/原创）
- 操作区：`Like` / `Skip` / `Flip` / `Save`

### 卡片翻面内容
- Imagery Tags
- Scent Tags
- Attribute impact（Calm +1 等）

### 状态
- 加载：骨架屏 + 微光
- 空：提示“今日探索已完成” + 订阅引导（若有 daily limit）

## 5. Profile
### 展示内容
- Tree stage
- 属性趋势（近 7 天）
- Scent Identity 卡片：名称 + Top tags + 一句描述
- 收藏入口（列表）
