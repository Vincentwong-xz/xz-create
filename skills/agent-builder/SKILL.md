---
name: agent-builder
description: >
  Templates, patterns, and reference material for building new Copilot CLI
  agents and skills. Load this skill when creating or designing a new agent.
allowed-tools: shell
---

# Agent Builder Skill

This skill provides templates and best-practice patterns for creating Copilot
CLI agents and skills. Use these templates when generating new agent files.

---

## File Structure Reference

```
~/.copilot/
├── agents/
│   └── <name>.agent.md        ← user-scoped agent (all projects)
└── skills/
    └── <name>/
        ├── SKILL.md           ← skill instructions
        └── <optional-scripts>
```

Repository-scoped alternatives:
```
<repo>/.github/agents/<name>.agent.md
<repo>/.github/skills/<name>/SKILL.md
```

---

## Agent File Template (General Purpose)

```markdown
---
name: <name>
description: >
  <Purpose>. Use this agent when <trigger condition>.
  Trigger phrases: "<phrase 1>", "<phrase 2>".
---

# <Display Name>

## Purpose
<What this agent does.>

## Workflow
1. <First step>
2. <Second step>
3. <Continue as needed>

## Guidelines
- <Rule 1>
- <Rule 2>
```

---

## Skill File Template

```markdown
---
name: <name>
description: <When Copilot should automatically load this skill.>
allowed-tools: shell
---

# <Skill Title>

## Overview
<What this skill provides.>

## Instructions
<Step-by-step guidance Copilot must follow.>

## Templates / Examples
<Reusable templates, code snippets, or examples.>
```

---

## Common Agent Archetypes

### 1. Content Processing Agent (e.g., summarizer, translator, formatter)

Key design points:
- Describe input format clearly (URL, file path, pasted text)
- Specify output format (bullet points, structured sections, length limit)
- Include language handling instructions if multilingual support is needed

Example description:
```
Summarizes and extracts key insights from articles, documents, or web pages.
Use this agent when asked to summarize, extract key points, or distill content.
Trigger phrases: "summarize this", "extract key points", "总结一下", "提炼要点".
```

### 2. Code Review / Analysis Agent

Key design points:
- Specify languages or frameworks in scope
- Define what to check: bugs, style, security, performance
- Set the signal-to-noise standard (avoid trivial comments)

Example description:
```
Reviews code changes for bugs, security vulnerabilities, and logic errors.
Use when asked to review code, check for issues, or audit a PR.
```

### 3. DevOps / Infrastructure Agent

Key design points:
- List the tools it has access to (kubectl, docker, terraform, etc.)
- Define safe vs. destructive operations
- Require confirmation before destructive commands

Example description:
```
Manages Kubernetes resources and Docker containers. Use when asked to
inspect pods, scale deployments, or debug container issues.
```

### 4. Documentation Agent

Key design points:
- Specify the documentation style (Markdown, JSDoc, docstring, etc.)
- Define what to document (functions, classes, APIs, READMEs)
- Set tone and audience

Example description:
```
Generates and improves code documentation. Use when asked to document
functions, write a README, or add docstrings.
```

### 5. Research / Investigation Agent

Key design points:
- Define information sources (web search, GitHub, codebase)
- Specify output format (report, bullet list, table)
- Set depth vs. speed trade-off

---

## Naming Conventions

| Element | Convention | Example |
|---|---|---|
| Agent name | lowercase, hyphenated | `article-summarizer` |
| Skill name | lowercase, hyphenated | `article-summarizer` |
| Agent file | `<name>.agent.md` | `article-summarizer.agent.md` |
| Skill dir | `<name>/` | `article-summarizer/` |
| Skill file | `SKILL.md` (uppercase) | `SKILL.md` |

---

## Shell Commands for Installation

```bash
# Create agent (user-scoped)
mkdir -p ~/.copilot/agents
cat > ~/.copilot/agents/<name>.agent.md << 'EOF'
<agent file content>
EOF

# Create skill (user-scoped)
mkdir -p ~/.copilot/skills/<name>
cat > ~/.copilot/skills/<name>/SKILL.md << 'EOF'
<skill file content>
EOF

# Verify
ls -la ~/.copilot/agents/<name>.agent.md
ls -la ~/.copilot/skills/<name>/SKILL.md
```

After writing files, tell the user to run `/skills reload` in the CLI session
(if a skill was added), or use `/agent` to browse available agents.

---

## Description Frontmatter Best Practices

The `description` field is the most important part of an agent file. Copilot
uses it to decide when to invoke the agent automatically.

**Good description** (specific triggers, clear scope):
```yaml
description: >
  Summarizes articles and extracts key insights. Use when the user asks to
  summarize content, distill an article, or says "总结", "提炼", "summarize".
```

**Bad description** (too vague):
```yaml
description: An agent that helps with text.
```

Rules:
1. State the primary function in the first sentence
2. Include "Use when..." to define the trigger condition
3. List 2–4 trigger phrases, including in the user's language
4. Keep under 3 sentences
