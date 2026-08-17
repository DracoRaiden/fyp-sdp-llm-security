# Ensure virtual environment is activated
if ($null -eq $env:VIRTUAL_ENV) {
    .venv\Scripts\Activate.ps1
}

Write-Host "Running Step 10: Static prompt-injection baseline (llama-3.3-70b-versatile, user_task_0)..." -ForegroundColor Cyan
python -m agentdojo.scripts.benchmark `
  -s workspace `
  -ut user_task_0 `
  -it injection_task_0 `
  --model openai-compatible `
  --model-id llama-3.3-70b-versatile `
  --attack tool_knowledge `
  --logdir runs/groq_static_attack_workspace_0 `
  --force-rerun

Write-Host "Running Step 10: Five-task static prompt-injection baseline (llama-3.3-70b-versatile, user_task_0 to user_task_4)..." -ForegroundColor Cyan
python -m agentdojo.scripts.benchmark `
  -s workspace `
  -ut user_task_0 `
  -ut user_task_1 `
  -ut user_task_2 `
  -ut user_task_3 `
  -ut user_task_4 `
  -it injection_task_0 `
  --model openai-compatible `
  --model-id llama-3.3-70b-versatile `
  --attack tool_knowledge `
  --logdir runs/groq_static_attack_workspace_0_4 `
  --force-rerun

Write-Host "Running Step 11: Five-task no-attack utility test (openai/gpt-oss-120b)..." -ForegroundColor Cyan
python -m agentdojo.scripts.benchmark `
  -s workspace `
  -ut user_task_0 `
  -ut user_task_1 `
  -ut user_task_2 `
  -ut user_task_3 `
  -ut user_task_4 `
  --model openai-compatible `
  --model-id openai/gpt-oss-120b `
  --logdir runs/groq_gptoss120b_no_attack_workspace_0_4 `
  --force-rerun

Write-Host "Running Step 11: Five-task static prompt-injection baseline (openai/gpt-oss-120b)..." -ForegroundColor Cyan
python -m agentdojo.scripts.benchmark `
  -s workspace `
  -ut user_task_0 `
  -ut user_task_1 `
  -ut user_task_2 `
  -ut user_task_3 `
  -ut user_task_4 `
  -it injection_task_0 `
  --model openai-compatible `
  --model-id openai/gpt-oss-120b `
  --attack tool_knowledge `
  --logdir runs/groq_gptoss120b_static_attack_workspace_0_4 `
  --force-rerun
