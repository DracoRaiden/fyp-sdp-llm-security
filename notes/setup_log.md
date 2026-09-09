# Setup Log

## 2026-08-19
Done:
- Automated the extraction of run notes in `scripts/summarize.py`.
- Resolved all empty values in `notes/baseline_results.md` (auto-populating tool errors, failed tasks, and weird behaviors directly from execution JSONs).
Issues:
- None.
Next:
- Implement SwarmSec and CryptoFirewall defense modules.

## 2026-08-18
Done:
- Ran baseline check `00_check_groq.py` (connection verified).
- Ran no-attack benchmark baseline (`01_run_no_attack_baseline.ps1`) for `openai/gpt-oss-120b`.
- Ran static-attack benchmark baseline (`02_run_static_attack_baseline.ps1`) for `openai/gpt-oss-120b` and `openai/gpt-oss-20b`.
- Generated custom summarization tool (`scripts/summarize.py`) to parse results.
- Populated baseline results in `notes/baseline_results.md`.
Issues:
- Windows Command Prompt Unicode encoding issues resolved in parser (Unicode emoji replacement with ASCII names).
Next:
- Design security/defense modules under `src/swarmsec` and `src/cryptofirewall` to block the static attacks.
- Evaluate the defenses using the pipeline scripts.

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


