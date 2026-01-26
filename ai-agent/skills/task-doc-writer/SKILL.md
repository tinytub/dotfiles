---
name: task-doc-writer
description: Write and update post-task design/implementation documentation using the bundled Markdown template. Use when a task is completed and a structured doc is required, including filling required sections, naming file as YYYY-MM-DD-主题名.md, and placing it in docs/ by default.
---

# Task Doc Writer

## Overview

Create or update a comprehensive completion document for the **entire session's work** or **feature implementation** using the template at `assets/doc-template.md`.
Default output directory is `docs/` unless the user specifies a different location.

## Workflow

1. **Analyze the entire conversation/session history:** Identify the overarching goal and ALL changes made (code, configuration, design) throughout the current session/interaction, not just the most recent step. Collect facts for the *entire* feature or set of features implemented: scope, design decisions, implementation paths, configs, observability, compatibility, risks, rollout/rollback, and verification results.
2. Determine the document date (local time) and topic name; set file name to `YYYY-MM-DD-主题名.md`.
3. **Check for existing file:** Check if the target file already exists at the path.
    - **If file DOES NOT exist:** Copy the template from `assets/doc-template.md` to the target path.
    - **If file ALREADY exists:** Read the existing file content. **DO NOT overwrite it with the template.** Preserving existing content is critical.
4. Determine author name via `git config user.name`; if missing, ask the user.
5. **Update Content:**
    - **For New Files:** Replace all placeholders (`placeholder`, `<name>`) and fill all sections.
    - **For Existing Files:** intelligently merge new facts into existing sections (e.g., add new risks to the Risk section, update Implementation Path). **Do not delete existing valid content.**
6. **Revision Log:**
    - **New Files:** Add the initial row (v1.0).
    - **Existing Files:** **Append** a new row to the Revision Log table with the current date, incremented version (e.g., v1.1), author, and a summary of the *new* changes.
7. Set/Update metadata: Ensure `最近修订` (Last Revised) is set to the current date.
8. For unknown facts, write `不确定/待确认` and include the reason.
9. Keep sentences concise; one item per line; avoid vague wording.

## Output Rules

- Preserve the template’s Chinese headings.
- Keep code blocks in English.
- Only include Chinese in string literals when the task explicitly requires Chinese UI copy or log messages.

## Resources

- `assets/doc-template.md`: Markdown template to copy and fill.
