# Setup Log

## 2026-08-17
Done:
- Created repository directories and initialized config files (`.gitignore`, `.env`, `requirements.txt`)
- Created Python virtual environment `.venv` and installed requirements (`agentdojo`, `openai`, `dotenv`, `pandas`, `rich`)
- Created verification script `00_check_groq.py`
- Created baseline execution scripts (`01_run_no_attack_baseline.ps1` and `02_run_static_attack_baseline.ps1`)
- Created results parsing script `03_parse_results.py`
Issues:
- None so far
Next:
- Run verification script `python scripts/00_check_groq.py`
- Run first AgentDojo no-attack run (`01_run_no_attack_baseline.ps1`)

## 2026-08-11
Done:
- Created repo
- Installed AgentDojo
- Groq test script worked
Issues:
- None
Next:
- Run workspace user_task_0 no-attack baseline
