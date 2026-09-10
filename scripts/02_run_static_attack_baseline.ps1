# Ensure virtual environment is activated
if ($null -eq $env:VIRTUAL_ENV) {
    .venv\Scripts\Activate.ps1
}

# Force UTF-8 output encoding for python to prevent Windows cp1252 UnicodeEncodeError
$env:PYTHONIOENCODING = "utf-8"

$tasks = "user_task_0", "user_task_1", "user_task_2", "user_task_3", "user_task_4"
# Comment
# -------------------------------------------------------------
# 1. Primary Model (gpt-oss-120b) Static-Attack user_task_0
# -------------------------------------------------------------
Write-Host "Running Step 10: Static prompt-injection baseline (openai/gpt-oss-120b, user_task_0)..." -ForegroundColor Cyan
python -m agentdojo.scripts.benchmark `
  -s workspace `
  -ut user_task_0 `
  -it injection_task_0 `
  --model OPENAI_COMPATIBLE `
  --model-id openai/gpt-oss-120b `
  --attack tool_knowledge `
  --logdir runs/groq_gptoss120b_static_attack_workspace_0 `
  --force-rerun

Write-Host "Sleeping 20 seconds to cool down rate limits..." -ForegroundColor Yellow
Start-Sleep -Seconds 20

# -------------------------------------------------------------
# 2. Primary Model (gpt-oss-120b) Static-Attack user_task_0 to user_task_4
# -------------------------------------------------------------
Write-Host "Running Step 10: Five-task static prompt-injection baseline (openai/gpt-oss-120b)..." -ForegroundColor Cyan
foreach ($task in $tasks) {
    Write-Host "Running attacked task for gpt-oss-120b: $task..." -ForegroundColor Cyan
    python -m agentdojo.scripts.benchmark `
      -s workspace `
      -ut $task `
      -it injection_task_0 `
      --model OPENAI_COMPATIBLE `
      --model-id openai/gpt-oss-120b `
      --attack tool_knowledge `
      --logdir runs/groq_gptoss120b_static_attack_workspace_0_4 `
      --force-rerun
      
    Write-Host "Sleeping 20 seconds to prevent API rate limits..." -ForegroundColor Yellow
    Start-Sleep -Seconds 20
}

# -------------------------------------------------------------
# 3. Secondary Model (gpt-oss-20b) No-Attack user_task_0 to user_task_4
# -------------------------------------------------------------
Write-Host "Running Step 11: Five-task no-attack utility test (openai/gpt-oss-20b)..." -ForegroundColor Cyan
foreach ($task in $tasks) {
    Write-Host "Running no-attack task for gpt-oss-20b: $task..." -ForegroundColor Cyan
    python -m agentdojo.scripts.benchmark `
      -s workspace `
      -ut $task `
      --model OPENAI_COMPATIBLE `
      --model-id openai/gpt-oss-20b `
      --logdir runs/groq_gptoss20b_no_attack_workspace_0_4 `
      --force-rerun
      
    Write-Host "Sleeping 20 seconds to prevent API rate limits..." -ForegroundColor Yellow
    Start-Sleep -Seconds 20
}

# -------------------------------------------------------------
# 4. Secondary Model (gpt-oss-20b) Static-Attack user_task_0 to user_task_4
# -------------------------------------------------------------
Write-Host "Running Step 11: Five-task static prompt-injection baseline (openai/gpt-oss-20b)..." -ForegroundColor Cyan
foreach ($task in $tasks) {
    Write-Host "Running attacked task for gpt-oss-20b: $task..." -ForegroundColor Cyan
    python -m agentdojo.scripts.benchmark `
      -s workspace `
      -ut $task `
      -it injection_task_0 `
      --model OPENAI_COMPATIBLE `
      --model-id openai/gpt-oss-20b `
      --attack tool_knowledge `
      --logdir runs/groq_gptoss20b_static_attack_workspace_0_4 `
      --force-rerun
      
    if ($task -ne $tasks[-1]) {
        Write-Host "Sleeping 20 seconds to prevent API rate limits..." -ForegroundColor Yellow
        Start-Sleep -Seconds 20
    }
}
