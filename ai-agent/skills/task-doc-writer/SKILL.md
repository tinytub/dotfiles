---
name: task-doc-writer
description: Write and update post-task design/implementation documentation using the bundled Markdown template. Use when a task is completed and a structured doc is required, including filling required sections, naming file as YYYY-MM-DD-主题名.md, and placing it in docs/ by default.
---

# Task Doc Writer

## Overview

Create or update a comprehensive completion document for the **entire session's work** or **feature implementation** using the template at `assets/doc-template.md`.
Default output directory is `docs/` unless the user specifies a different location.

## Workflow

1. **Analyze the entire conversation/session history:** Identify the overarching goal and ALL changes made (code, configuration, design) throughout the current session/interaction. Collect facts: scope, design decisions, implementation paths, configs, observability, compatibility, risks, rollout/rollback, and verification results.
2. Determine the document date (local time) and topic name; set file name to `YYYY-MM-DD-主题名.md`.
3. **Check for existing file:** Check if the target file already exists at the path.
    - **If file DOES NOT exist:** Copy the template from `assets/doc-template.md` to the target path.
    - **If file ALREADY exists:** Read the existing file content. **DO NOT overwrite it with the template.** Preserving existing content is critical.
4. Determine author name via `git config user.name`; if missing, ask the user.
5. **Update Content:**
    - **For New Files:** Replace all placeholders (`<...>`) and fill all required sections. Delete optional sections that are not applicable (see Section Rules below).
    - **For Existing Files:** Intelligently merge new facts into existing sections (e.g., add new risks, update implementation path). **Do not delete existing valid content.**
6. **Revision Log:**
    - **New Files:** Add the initial row (v1.0).
    - **Existing Files:** **Append** a new row to the Revision Log table with the current date, incremented version (e.g., v1.1), author, and a summary of the *new* changes.
7. Set/Update metadata: Ensure `最近修订` (Last Revised) is set to the current date.
8. For unknown facts, write `不确定/待确认` and include the reason.
9. Keep sentences concise; one item per line; avoid vague wording.

## Anti-Leak Rule (CRITICAL)

The template at `assets/doc-template.md` contains **only** the document skeleton with `<...>` placeholders. It does **not** contain any guidance or instruction text.

When generating the final document:
- **NEVER** include any instruction, guidance, meta-commentary, or rule text (such as "要求", "说明", "必读", "按需", "原因", etc.) in the output.
- **NEVER** include any text that tells the reader *how* the document should be written — only the actual document content.
- The only text in the output should be factual content about the specific task/feature being documented.

## Section Rules

### Required Sections (always present)

These sections **MUST** appear in every document. If a required section has no content, write `- 无`.

| Section | Minimum Content |
|---------|-----------------|
| 文档元信息 | Status, associated PR/Commit |
| 修订日志 | At least one row |
| 背景 | Current problem, impact scope, constraints/prerequisites |
| 目标 | What to achieve, what is explicitly excluded |
| 变更类型 | At least one type selected |
| 范围 | Changed scope, unchanged scope |
| 设计要点 | Core approach/data flow, key assumptions, compatibility guarantees |
| 实现路径 | File paths and key function/object names |
| 配置/注解/参数 | New/changed configs or `- 无` |
| 可观测性 | Logs/metrics/alerts or `- 无` |
| 兼容性清单 | CRD/Schema, API, data, upgrade path compatibility |
| 风险与回归 | At least 1 potential breakage + 1 regression trigger |
| 发布与回滚 | Rollout strategy, rollback conditions and steps |
| 验证 | At least 1 local/unit test command |

### Optional Sections (delete entirely if not applicable)

These sections should be **removed from the document** (not filled with `- 无`) when they don't apply.

| Section | When to Include |
|---------|-----------------|
| 术语与缩写 | When internal terms or abbreviations are used |
| 流程图 | When there are >=2 branches or non-obvious data flow |
| 接口说明 | When adding/changing external APIs |
| 行为说明 | When involving degradation, fallback, caching, idempotency, or retry strategies |
| 示例（curl/SDK） | When adding/changing external APIs |
| 后续 | When there are explicitly deferred items for the future |

### Per-Section Rules

- **背景**: At least 2 items (current problem, impact scope). Constraints/prerequisites must be stated.
- **目标**: At least 2 items (achievement, explicit exclusion).
- **设计要点**: At least 2 items (core approach, compatibility/user-facing guarantee).
- **实现路径**: Must give concrete file paths and key function/object names; note reuse points.
- **配置/注解/参数**: Table format; include type, default value, change method (hot/cold), impact scope.
- **接口说明**: Must fill request/response bodies, field highlights, and error handling.
- **风险与回归**: Quantify impact scope when possible.
- **验证**: At least 1 local/unit test command; if cannot execute, explain why and give alternative.

## General Writing Rules

- Preserve the template's Chinese headings.
- Keep code blocks in English.
- Only include Chinese in string literals when the task explicitly requires Chinese UI copy or log messages.
- Dates: 创建日期 = filename date; 最近修订 = last modification date; revision log gets a new row on every edit.
- Empty value handling: write `- 无` for required sections with no content; never leave blank; never use `.../TBD/placeholder`.
- Placeholder replacement: all `<...>` must be replaced with real values.
- Scope control: only describe changes in this task; out-of-scope items go in 后续.
- Factual boundary: for unknown information, write `不确定/待确认` with the reason.

## Resources

- `assets/doc-template.md`: Markdown template to copy and fill.
