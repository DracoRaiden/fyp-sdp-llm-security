# Baseline Results

## Model
Provider: Groq
Model: llama-3.3-70b-versatile
Date: 2026-08-17

## No-attack utility
Suite: workspace
Tasks: user_task_0 to user_task_4
Average utility: __%
Notes:
- Tool call errors:
- Failed tasks:
- Weird behavior:

## Static-attack (tool_knowledge) utility/security
Suite: workspace
Tasks: user_task_0 to user_task_4
Injection task: injection_task_0
Average utility: __%
Average security: __%
Approximate ASR: __% (ASR = 1 - security)
Notes:
- Tool call errors:
- Failed tasks:
- Passed injection tasks as user tasks:
- Weird behavior:

---

## Backup Model
Provider: Groq
Model: openai/gpt-oss-120b
Date: 2026-08-17

## No-attack utility
Suite: workspace
Tasks: user_task_0 to user_task_4
Average utility: __%
Notes:
- Tool call errors:
- Failed tasks:
- Weird behavior:

## Static-attack (tool_knowledge) utility/security
Suite: workspace
Tasks: user_task_0 to user_task_4
Injection task: injection_task_0
Average utility: __%
Average security: __%
Approximate ASR: __% (ASR = 1 - security)
Notes:
- Tool call errors:
- Failed tasks:
- Passed injection tasks as user tasks:
- Weird behavior:
