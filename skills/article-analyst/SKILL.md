---
name: article-analyst
description: >
  Structured output templates and analysis guidelines for the article-analyst
  agent. Load this skill when analyzing articles, reports, or documents to
  extract key points and practical considerations.
---

# Article Analyst Skill

## Output Report Template

Use this exact structure when delivering the analysis report:

---

```
# 📄 文章分析报告 / Article Analysis Report

**来源 / Source**: <article title or URL>
**字数 / Length**: ~<word count> words
**类型 / Type**: <Research paper | Blog post | News article | Technical doc | Opinion | Other>

---

## 🔑 核心要点 / Key Points

1. <Point 1>
2. <Point 2>
3. <Point 3>
...

---

## ⚠️ 实践注意事项 / Considerations for Practice

### 前提条件 / Prerequisites
- <What must be true before applying this>

### 风险与陷阱 / Risks & Pitfalls
- <What can go wrong>
- <What the article warns against>

### 适用范围 / Context & Limitations
- <When this applies / when it does NOT apply>
- <Industry, scale, or tech stack constraints>

### 行动建议 / Recommended Actions
- <Concrete next step 1>
- <Concrete next step 2>

### 待解问题 / Open Questions
- <What the article leaves unanswered>

---

## 💡 核心结论 / Bottom Line

> <One sentence: the single most important takeaway from this article.>
```

---

## Analysis Depth Guide

| Article Type | Key Points | Considerations Depth |
|---|---|---|
| Short blog post (<1000 words) | 3–4 points | Focus on Risks & Actions |
| Technical article (1000–5000 words) | 5–7 points | All sections |
| Long report / whitepaper (>5000 words) | 6–8 points | All sections + note page refs |
| Opinion / editorial | 3–5 points | Emphasize Context & Limitations |
| News article | 3–4 points | Focus on Actions & Open Questions |

---

## Language Handling

- Detect the language of the article automatically.
- Respond in the **user's language** (the language they used in the request).
- For bilingual output, use the format `中文 / English` shown in the template.
- Preserve technical terms in their original language even if translating.

---

## Fetching Articles from URLs

When the user provides a URL:

1. Use `web_fetch` with `url=<URL>` to retrieve the content.
2. If the page is too long (>10,000 chars), fetch in sections using
   `start_index` pagination.
3. Strip navigation, ads, and boilerplate — focus on the article body.
4. Note the original title and publication date in the report header.

---

## Handling Long Articles

If the article exceeds context limits:
1. Process the introduction and conclusion first to get the thesis.
2. Scan section headings to map the structure.
3. Process each section, accumulating key points.
4. Synthesize at the end — do not just concatenate per-section summaries.

---

## Quality Checklist (self-verify before delivering)

- [ ] Key Points are distinct — no overlap between items
- [ ] Each Key Point is a complete, standalone sentence
- [ ] Considerations are specific to THIS article, not generic advice
- [ ] Bottom Line is a single sentence, not a paragraph
- [ ] Report language matches user's request language
- [ ] Source/title is correctly identified
