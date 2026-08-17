# Ensure virtual environment is activated
if ($null -eq $env:VIRTUAL_ENV) {
    .venv\Scripts\Activate.ps1
}

Write-Host "Running Step 8: First AgentDojo no-attack run (user_task_0)..." -ForegroundColor Cyan
python -m agentdojo.scripts.benchmark `
  -s workspace `
  -ut user_task_0 `
  --model openai-compatible `
  --model-id llama-3.3-70b-versatile `
  --logdir runs/groq_no_attack_workspace_0 `
  --force-rerun

Write-Host "Running Step 9: Five no-attack utility tasks (user_task_0 to user_task_4)..." -ForegroundColor Cyan
python -m agentdojo.scripts.benchmark `
  -s workspace `
  -ut user_task_0 `
  -ut user_task_1 `
  -ut user_task_2 `
  -ut user_task_3 `
  -ut user_task_4 `
  --model openai-compatible `
  --model-id llama-3.3-70b-versatile `
  --logdir runs/groq_no_attack_workspace_0_4 `
  --force-rerun
