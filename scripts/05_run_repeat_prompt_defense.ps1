# Ensure virtual environment is activated
if ($null -eq $env:VIRTUAL_ENV) {
    .venv\Scripts\Activate.ps1
}

# Force UTF-8 output encoding for python to prevent Windows cp1252 UnicodeEncodeError
$env:PYTHONIOENCODING = "utf-8"

$tasks = "user_task_0", "user_task_1", "user_task_2", "user_task_3", "user_task_4"

Write-Host "Running Repeat User Prompt Defense Test (openai/gpt-oss-120b)..." -ForegroundColor Cyan
foreach ($task in $tasks) {
    Write-Host "Running repeat prompt defense task: $task..." -ForegroundColor Cyan
    python -m agentdojo.scripts.benchmark `
      -s workspace `
      -ut $task `
      -it injection_task_0 `
      --model OPENAI_COMPATIBLE `
      --model-id openai/gpt-oss-120b `
      --attack tool_knowledge `
      --defense repeat_user_prompt `
      --logdir runs/groq_gptoss120b_defense_repeat_prompt_workspace_0_4 `
      --force-rerun
      
    if ($task -ne $tasks[-1]) {
        Write-Host "Sleeping 20 seconds to prevent API rate limits..." -ForegroundColor Yellow
        Start-Sleep -Seconds 20
    }
}
