---
name: ai-knowledge-tutor
description: >
  AI knowledge base, concept relationship map, teaching templates, and Feishu
  document templates for the AI knowledge tutor agent. Load when explaining
  any AI concept or generating AI knowledge documents.
---

# AI Knowledge Tutor — Skill Reference

---

## 📚 Base Knowledge Map

### 概念关系总图 / Master Concept Graph

```
                        ┌─────────────────────┐
                        │   大语言模型 LLM      │  ← 核心引擎
                        └──────────┬──────────┘
              ┌───────────────┬────┴────┬───────────────┐
              ▼               ▼         ▼               ▼
         [Token /        [Prompt /  [Fine-tuning]   [Inference]
        Context]        Prompt Eng]   调整模型        推理输出
                               │
                    ┌──────────┴──────────┐
                    ▼                     ▼
               [RAG 检索增强]         [Embedding /
               外部知识注入            Vector DB]
                         \               /
                          └──── 提升回答质量
              ┌──────────────────────────────────────┐
              │             API 接口层                 │  ← 连接通道
              └────────────────┬─────────────────────┘
                               │
              ┌────────────────┴─────────────────────┐
              │               Agent                   │  ← 自主行动者
              └────────┬──────────────┬──────────────┘
                       ▼              ▼
              [Tool Calling]     [MCP 协议]
               调用外部工具       标准化工具接入
```

---

## 📖 核心概念定义库 / Concept Definitions

---

### 🧠 LLM — 大语言模型 (Large Language Model)

**一句话**: 一个通过海量文本训练出来的、能理解并生成人类语言的超大 AI 模型。

**类比**: 把人类写过的绝大多数书籍、网页、对话都喂给一个学生，让他不断做"完形填空"练习——预测下一个词是什么。练习几千亿次之后，这个学生就变成了 LLM。

**关键属性**:
- 参数量：数十亿到数万亿（决定"脑容量"）
- 训练数据：互联网文本、书籍、代码等
- 能力边界：文本理解、生成、推理、翻译、代码
- 代表模型：GPT-4、Claude、Gemini、LLaMA、Qwen

**上游依赖**: Transformer 架构、Token 化、大规模算力
**同级概念**: Multimodal Model（多模态）
**下游应用**: API、Agent、RAG、Fine-tuning

---

### 🔤 Token — 词元

**一句话**: LLM 处理文字时使用的最小单位，不完全等于"字"或"词"。

**类比**: 就像乐谱用"音符"而不是"乐句"来表示音乐，LLM 用 Token 而不是完整单词来处理文字。"ChatGPT" 可能被切成 ["Chat", "G", "PT"] 三个 Token。

**关键数字**:
- 英文：约 1 Token ≈ 0.75 个单词
- 中文：约 1 Token ≈ 0.5–1 个汉字
- 收费单位：大多数 API 按 Token 计费

**上游依赖**: 分词器（Tokenizer）
**同级概念**: Context Window
**下游影响**: API 费用、模型输入长度限制

---

### 📏 Context Window — 上下文窗口

**一句话**: LLM 每次对话时能"看到"的最大 Token 数量，超出就会"忘记"。

**类比**: 就像短期记忆——你可以记住最近 1 小时谈话内容，但昨天说了什么就不记得了。Context Window 就是这个"记忆容量"。

**关键数字**:
- GPT-3.5：4K Token ≈ 约 3000 字
- GPT-4 Turbo：128K Token ≈ 约 10 万字
- Claude 3.5：200K Token ≈ 约 15 万字

**上游依赖**: Token
**同级概念**: RAG（可以绕过长度限制）
**下游影响**: 对话连贯性、文档分析能力

---

### 💬 Prompt / Prompt Engineering — 提示词 / 提示词工程

**一句话**: 你给 LLM 的输入指令；Prompt Engineering 是系统性地设计这些指令以获得最佳输出的技艺。

**类比**: 和 LLM 打交道就像指挥一个全能但需要明确指令的员工。"帮我写个报告" vs "你是一个专业咨询顾问，请用 MECE 原则，写一份针对 B2B SaaS 市场的 500 字竞争分析报告" — 后者是 Prompt Engineering。

**常见技巧**:
- **角色设定**: "你是一位..."
- **思维链 (Chain-of-Thought)**: "一步一步思考..."
- **少样本 (Few-shot)**: 给出 2-3 个示例
- **输出格式**: "以 JSON/Markdown/表格形式输出"

**上游依赖**: LLM、Context Window
**同级概念**: Fine-tuning（另一种优化方式）
**下游应用**: 所有 LLM 应用的核心技能

---

### 🔌 API — 应用程序接口 (Application Programming Interface)

**一句话**: 一套标准规则，让你的程序能远程"调用" LLM 的能力，而不用自己部署模型。

**类比**: 餐厅厨房（LLM）不对外开放，但有一个服务员窗口（API）——你按菜单（API 文档）点餐（发请求），厨房做好后通过窗口端给你（返回结果）。

**工作流程**:
1. 开发者注册获取 API Key（门票）
2. 按格式发送 HTTP 请求（含 prompt + 参数）
3. 服务器调用模型生成回答
4. 返回 JSON 格式的结果

**关键参数**:
- `model`: 使用哪个模型
- `messages`: 对话历史（含 system/user/assistant）
- `temperature`: 随机性（0=保守，2=创意）
- `max_tokens`: 最大输出长度

**上游依赖**: LLM
**同级概念**: SDK（对 API 的封装）
**下游应用**: Agent、所有 AI 产品后端

---

### 🤖 Agent — AI 智能体

**一句话**: 一个能自主制定计划、调用工具、完成多步骤任务的 AI 系统，而不只是被动回答问题。

**类比**: 普通 LLM 是"问一句答一句的顾问"，Agent 是"给他一个目标，他会自己想方案、打电话、查资料、写报告，直到完成"的助手。

**核心循环 (ReAct 模式)**:
```
目标输入 → [思考] 下一步该做什么？
        → [行动] 调用工具（搜索/计算/读文件...）
        → [观察] 得到工具返回结果
        → [思考] 目标完成了吗？没有则继续循环
        → 输出最终结果
```

**构成要素**:
- **LLM**: 大脑，负责推理和决策
- **Memory**: 记忆（短期=Context，长期=数据库）
- **Tools**: 可调用的能力（搜索、代码执行、API 调用）
- **Planning**: 任务分解能力

**上游依赖**: LLM、API、Tool Calling
**同级概念**: Workflow（固定流程自动化，非自主）
**下游应用**: Copilot CLI、AutoGPT、各类 AI 助手

---

### 🛠️ Tool Calling / Function Calling — 工具调用

**一句话**: LLM 在生成回答时，识别到需要外部能力，主动发出调用外部函数/工具的指令。

**类比**: 你问朋友"现在几点？"，聪明的朋友不会瞎猜，而是说"等我看一下手表"（调用工具），然后告诉你准确时间。Tool Calling 就是 LLM 的"看手表"能力。

**工作流程**:
1. 用户提问："明天北京天气怎么样？"
2. LLM 识别：需要调用天气 API
3. LLM 输出：`{tool: "get_weather", args: {city: "北京", date: "tomorrow"}}`
4. 系统执行工具，返回结果给 LLM
5. LLM 用结果生成最终回答

**上游依赖**: LLM、API
**同级概念**: RAG（另一种扩展能力的方式）
**下游应用**: Agent、MCP

---

### 🔗 MCP — 模型上下文协议 (Model Context Protocol)

**一句话**: Anthropic 提出的开放标准，让 AI 模型以统一方式连接任意外部工具和数据源，就像 USB 接口一样。

**类比**: 在 MCP 出现之前，每个 AI 产品接入工具都要单独写对接代码，就像每个国家用不同插头——乱且费力。MCP 就是制定了统一的"国际通用插座标准"，工具厂商只需做一个 MCP Server，任何支持 MCP 的 AI 客户端都能用。

**架构**:
```
AI 客户端 (Host)          MCP Server
┌──────────────┐          ┌──────────────┐
│  Claude /    │◄────────►│ GitHub 工具  │
│  Copilot CLI │  MCP协议 │ 飞书工具     │
│  其他AI应用  │          │ 数据库工具   │
└──────────────┘          │ 自定义工具   │
                          └──────────────┘
```

**与 Tool Calling 的区别**:
- Tool Calling：LLM 调用工具的"动作"
- MCP：规范化这个动作的"标准协议"，让工具可插拔复用

**上游依赖**: Tool Calling、API
**同级概念**: OpenAPI、Plugin（旧方案）
**下游应用**: Copilot CLI 的工具接入、各类 AI 工具生态

---

### 📡 RAG — 检索增强生成 (Retrieval-Augmented Generation)

**一句话**: 先从外部知识库检索相关内容，再把检索结果塞入 Prompt，让 LLM 基于最新/私有知识回答问题。

**类比**: 开卷考试 vs 闭卷考试。普通 LLM 是"闭卷"——只能用训练时学过的知识。RAG 让 LLM 变成"开卷"——回答前先查相关资料再作答。

**工作流程**:
```
用户问题 → [检索] 在向量数据库中找最相关文档片段
         → [增强] 将文档片段 + 原问题拼成新 Prompt
         → [生成] LLM 基于文档生成有据可查的回答
```

**解决什么问题**:
- LLM 知识截止日期问题
- 私有/企业内部知识无法训练进模型
- 减少幻觉（有原文依据）

**上游依赖**: Embedding、Vector Database、LLM
**同级概念**: Fine-tuning（另一种注入知识的方式）
**下游应用**: 企业知识库问答、AI 客服、文档助手

---

### 🔢 Embedding — 向量嵌入

**一句话**: 把文字（或图片）转化为一组数字（向量），使语义相似的内容在数字空间中"距离近"。

**类比**: 把每个词/句子标注在一个超高维度的地图上。"猫"和"猫咪"距离很近，"猫"和"汽车"距离很远。Embedding 就是这个"语义地图"的坐标系。

**应用场景**:
- RAG 的检索步骤
- 相似内容推荐
- 情感分析、分类

**上游依赖**: LLM（生成 Embedding 的模型）
**下游应用**: Vector Database、RAG

---

### 🗄️ Vector Database — 向量数据库

**一句话**: 专门存储和高效检索向量（Embedding）的数据库。

**类比**: 普通数据库按"精确关键词"搜索（找到就是找到，找不到就是空）；向量数据库按"语义相似度"搜索（返回最像的结果）。

**代表产品**: Pinecone、Weaviate、Chroma、pgvector（PostgreSQL 扩展）、Milvus

**上游依赖**: Embedding
**下游应用**: RAG、推荐系统

---

### 🎯 Fine-tuning — 微调

**一句话**: 在预训练大模型基础上，用特定领域的数据继续训练，让模型更擅长特定任务或更符合特定风格。

**类比**: LLM 是一个"万能大学毕业生"。Fine-tuning 是让他在某家公司实习半年，专门学这家公司的业务、术语和工作方式。

**Fine-tuning vs RAG**:
| | Fine-tuning | RAG |
|---|---|---|
| 知识注入方式 | 烧录进权重 | 查询时注入 |
| 成本 | 高（需要 GPU 训练） | 低（只需向量检索） |
| 知识更新 | 慢（需重新训练） | 快（更新文档库即可） |
| 适合场景 | 风格/语气/格式固定 | 知识频繁更新 |

**上游依赖**: LLM、训练数据
**同级概念**: RAG、Prompt Engineering

---

### 🌀 Hallucination — 幻觉

**一句话**: LLM 以高置信度生成了听起来合理但实际上是错误的内容。

**类比**: 一个博学但有时会"自信地瞎说"的朋友——他不会说"我不知道"，而是会编一个听起来很有道理的答案。

**为什么发生**: LLM 本质是概率预测"下一个 Token"，没有"是否为真"的内在检验机制。

**缓解方案**: RAG（有原文依据）、Tool Calling（让工具提供真实数据）、RLHF 训练

---

### 🔄 RLHF — 基于人类反馈的强化学习

**一句话**: 通过人类标注者对模型输出打分，训练模型生成更符合人类偏好的回答。

**类比**: 厨师不断做菜，试吃员（人类）反馈"这道好吃/那道不好吃"，厨师根据反馈调整菜谱——反复多次后，菜的口味越来越符合大众喜好。

**上游依赖**: LLM 预训练
**下游效果**: ChatGPT、Claude 等对话友好性的关键来源

---

## 🗺️ 概念关系速查表 / Quick Relationship Reference

| 概念 | 解决的问题 | 依赖 | 被用于 |
|---|---|---|---|
| LLM | 语言理解与生成 | 算力、数据 | 几乎一切 |
| Token | 文字的处理单元 | LLM | 计费、长度限制 |
| Context Window | 记忆容量上限 | Token | 对话连贯性 |
| Prompt Eng | 优化输入指令 | LLM | 所有 AI 应用 |
| API | 远程调用 LLM | LLM | Agent、产品 |
| Agent | 自主完成多步骤任务 | LLM + Tools | AI 助手、自动化 |
| Tool Calling | LLM 主动调用工具 | LLM | Agent、MCP |
| MCP | 统一工具接入标准 | Tool Calling | Copilot CLI |
| Embedding | 文字→向量 | LLM | RAG、推荐 |
| Vector DB | 向量存储与检索 | Embedding | RAG |
| RAG | 外部知识注入 | Embedding + LLM | 企业知识库 |
| Fine-tuning | 领域专化训练 | LLM + 数据 | 垂直模型 |
| RLHF | 对齐人类偏好 | LLM | ChatGPT, Claude |
| Hallucination | （问题，非解决方案） | — | 被 RAG/Tool 缓解 |

---

## 📝 飞书知识卡片模板 / Feishu Knowledge Card Template

当用户要求生成飞书文档时，使用以下 Markdown 结构调用 `feishu-docx_builtin_import`：

```markdown
# 🧠 AI 知识卡片：{概念名称}

> **知识库分类**：AI 基础概念  
> **难度**：⭐⭐☆☆☆（可调整）  
> **更新时间**：{日期}

---

## 📌 一句话定义

{一句话定义}

---

## 💡 通俗类比

{类比说明}

---

## 🔍 深度解析

### 基础层：它是什么？
{基础解释}

### 机制层：怎么工作的？
{工作原理}

### 应用层：用在哪里？
{应用场景}

---

## 🗺️ 概念关系图

**上游（依赖这些才能存在）**：
- {上游概念 1}
- {上游概念 2}

**同级（并列或互补）**：
- {同级概念 1}

**下游（在此基础上构建）**：
- {下游概念 1}
- {下游概念 2}

---

## ❓ 常见误区

- ❌ 误区：{错误认知}  
  ✅ 正确：{正确说法}

---

## 🔗 延伸学习

- 下一步可以了解：{推荐概念 1}、{推荐概念 2}
```

使用 `feishu-docx_builtin_import` 时：
- `file_name` = "AI知识卡片 - {概念名称}"
- `markdown` = 填入上述模板（替换所有 `{...}` 占位符）

---

## 🔁 复习引导策略 / Review Strategy

在每次解释新概念前，检查本次对话已覆盖的概念，并说：

> "我们今天已经聊过了 **{已学概念}**，**{新概念}** 其实和它们有关系——
> {关系说明}。让我们把它加进来。"

复习时使用"概念关系总图"动态扩展，让用户看到知识地图不断延伸。
