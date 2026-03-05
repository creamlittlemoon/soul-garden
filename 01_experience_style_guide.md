# 01 — Experience & Style Guide（风格圣经）

> 目标：让 Agent 在没有设计稿时，也能做出“像 Soul Garden”的体验。

## 1. 总体氛围关键词
朦胧 / 空灵 / 柔软 / 低对比 / 缓慢 / 呼吸感 / 轻粒子 / 微光 / 夜色花园 / 梦境

## 2. 色彩（Color）
### 2.1 基础调色盘（建议）
- 背景主色：深蓝紫（夜幕）+ 雾化渐变（不写死具体色值，保持柔）
- 点缀：微光金 / 月白 / 青绿（露水感）
- 规则：
  - **低饱和、低对比**
  - 渐变必须带“雾化”遮罩（overlay 10–30%）
  - 高光只用于交互反馈（like / level up）

### 2.2 场景光影
- 有“月光/星光”方向性，但**不要硬阴影**
- 背景建议加入：
  - 轻微颗粒噪点（film grain）
  - 柔焦（blur）层叠
  - 远处散景光斑（bokeh）

## 3. 字体与排版（Typography）
- 英文优先：偏文学气质的 serif + 极简 UI sans
- 建议组合：
  - Quote 文本：Serif（有书页感）
  - UI 按钮/数字：Sans（干净）
- 字重：
  - Quote：Regular / Medium
  - UI：Medium
- 行距：
  - Quote 行距稍大（1.4–1.6），制造“呼吸空间”
- 留白：
  - 每屏至少 25% 空白，让用户“慢下来”

## 4. 动效（Motion）
### 4.1 总原则
- 所有动效都应该是：**慢、柔、短促但不突兀**
- 动效是“呼吸”，不是“炫技”

### 4.2 必备动效清单
- 背景粒子：缓慢漂浮（随机速度、随机路径），透明度 10–30%
- 树苗：轻微呼吸缩放（scale 0.98–1.02），周期 4–8s
- 光晕：press 时轻微扩散（200–400ms）
- 卡片 like：轻微上浮 + 微光闪一下（300–500ms）
- Level up：短暂“月光洒落”效果（1–1.5s），配合轻震动

### 4.3 动效节奏参数（默认）
- 页面切换：淡入淡出 250–350ms
- 按钮按下：缩放 0.98（80–120ms）+ 回弹（120–180ms）
- 卡片翻面：3D flip 350–450ms，easing：easeInOut

## 5. 声音（Audio）
### 5.1 BGM（可开关）
- 类型：ambient / soft pads / field recording（远处虫鸣、风声、轻雨）
- 音量：极低（存在感 < 10%）
- 不要旋律强的歌，不要鼓点

### 5.2 交互音效（SFX）
- like：轻“叮”或“落露”声（高频柔）
- flip：纸张/丝绸翻动（很轻）
- level up：细碎铃音 + 低频垫一层（很短）

## 6. 触感（Haptics）
- like：light impact
- level up：medium impact（一次即可）
- 不要频繁震动，避免打断疗愈感

## 7. 视觉资产建议（MVP）
- 背景：2–3 张“朦胧花园”插画（深色、带雾）
- 树苗 stage：5 张（seed / sprout / young tree / bloom / forest）
- 粒子贴图：2–3 种（光点、花粉、星尘）

## 8. 参考图（改用生成提示词，避免版权）
### 8.1 花园背景 prompt（示例）
“dreamy misty night garden, soft glow, bokeh lights, subtle film grain, low saturation, gentle gradient fog, illustrated, minimal details, calming, no text”

### 8.2 树苗 stage prompt（示例）
“symbolic tiny sprout in moonlit garden, soft watercolor illustration, minimal, gentle glow, consistent character, no text, centered composition”

### 8.3 UI mock prompt（示例）
“mobile app ui, serene mystical garden theme, soft gradients, subtle glassmorphism, minimal typography, calm, elegant, no branding, high-quality ui mock”
