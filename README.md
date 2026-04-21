# 🤖 My Copilot Agents & Skills

个人 GitHub Copilot CLI Agent 和 Skill 合集，包含日常工作中常用的智能助手。

## 📦 包含内容

| 名称 | 类型 | 功能描述 |
|---|---|---|
| `agent-builder` | Agent + Skill | 根据需求描述，自动创建新的 Agent 和 Skill 文件并安装 |
| `ai-knowledge-tutor` | Agent + Skill | AI 知识讲解助手，通俗解释 LLM/Agent/MCP 等概念，可生成飞书文档 |
| `article-analyst` | Agent + Skill | 文章要点提炼 + 实践注意事项分析，支持 URL 和文本输入 |

## 🚀 安装方法

```bash
# 1. 克隆这个仓库
git clone https://github.com/你的用户名/my-copilot-agents.git

# 2. 进入仓库目录
cd my-copilot-agents

# 3. 安装 agents
cp agents/*.agent.md ~/.copilot/agents/

# 4. 安装 skills
cp -r skills/* ~/.copilot/skills/
```

安装完成后，在 Copilot CLI 中运行：
```
/skills reload
```

## 💬 使用方式

### Agent Builder
```
我需要一个专门做 SQL 查询优化的 Agent
帮我创建一个翻译 Agent
```

### AI 知识导师
```
帮我理解一下 RAG 是什么
LLM 和 API 有什么关系？
把 MCP 的解释记录到飞书
```

### 文章分析师
```
帮我看看这篇文章：https://...
总结一下这篇文章并告诉我需要注意什么
```

## 🔄 更新

```bash
cd my-copilot-agents
git pull
cp agents/*.agent.md ~/.copilot/agents/
cp -r skills/* ~/.copilot/skills/
```
