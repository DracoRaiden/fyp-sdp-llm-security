import json
import datetime
from pathlib import Path

runs_dir = Path("runs")
baseline_file = Path("notes/baseline_results.md")

# Generate Markdown Content
md_out = []
md_out.append("# AgentDojo Benchmark Results Summary\n")
md_out.append(f"Generated on: {datetime.date.today().isoformat()}\n")

print("# AgentDojo Benchmark Results Summary\n")

for run_path in sorted(runs_dir.iterdir()):
    if not run_path.is_dir() or run_path.name == "test_gptoss20b":
        continue
    
    # Check if there are json files
    json_files = list(run_path.rglob("*.json"))
    if not json_files:
        continue
        
    print(f"## Run: {run_path.name}")
    md_out.append(f"## Run: {run_path.name}")
    
    # Containers for categorized results
    benign_runs = {}       # user_task_id -> utility (bool)
    attacked_runs = {}     # user_task_id -> (utility, security)
    injection_control = {} # injection_task_id -> utility (bool)
    
    tool_errors = []
    failed_tasks = []
    weird_behaviors = []
    
    for jf in json_files:
        try:
            data = json.loads(jf.read_text(encoding="utf-8"))
            user_task = data.get("user_task_id")
            inj_task = data.get("injection_task_id")
            attack = data.get("attack_type")
            utility = data.get("utility")
            security = data.get("security")
            top_error = data.get("error")
            
            # Check for top-level error
            if top_error:
                tool_errors.append(f"{user_task or jf.name}: {top_error}")
                
            # Check for tool errors in messages
            for msg in data.get("messages", []):
                if msg.get("role") == "tool" and msg.get("error"):
                    tool_name = msg.get("tool_call", {}).get("function", "unknown")
                    tool_errors.append(f"{user_task}: Tool '{tool_name}' returned error: {msg.get('error')}")
            
            # Injection control run (injection task run as user task, no attack)
            if user_task and user_task.startswith("injection_task_"):
                injection_control[user_task] = utility
                if utility is False:
                    weird_behaviors.append(f"Control run failed: Model was unable to perform '{user_task}' directly.")
                continue
                
            # No-attack run
            if attack is None or attack == "none" or inj_task is None or inj_task == "none":
                if user_task:
                    benign_runs[user_task] = utility
                    if utility is False:
                        failed_tasks.append(user_task)
            else:
                # Under attack run
                if user_task:
                    attacked_runs[user_task] = (utility, security)
                    if utility is False:
                        failed_tasks.append(user_task)
        except Exception as e:
            pass

    # Benign Utility (No-attack)
    if benign_runs:
        successful_benign = sum(1 for u in benign_runs.values() if u is True)
        total_benign = len(benign_runs)
        rate = (successful_benign / total_benign * 100) if total_benign > 0 else 0
        details = ", ".join([f"{k}: {'PASS' if v is True else 'FAIL' if v is False else 'N/A'}" for k, v in sorted(benign_runs.items())])
        
        msg = f"- **Benign Utility (No Attack)**: {successful_benign}/{total_benign} ({rate:.1f}%)"
        print(msg)
        print(f"  - Details: {details}")
        
        md_out.append(msg)
        md_out.append(f"  - Details: {details}")
    else:
        print(f"- **Benign Utility (No Attack)**: No runs found")
        
    # Utility & Security Under Attack
    if attacked_runs:
        successful_utility = sum(1 for u, s in attacked_runs.values() if u is True)
        successful_security = sum(1 for u, s in attacked_runs.values() if s is True)
        total_attacked = len(attacked_runs)
        
        util_rate = (successful_utility / total_attacked * 100) if total_attacked > 0 else 0
        sec_rate = (successful_security / total_attacked * 100) if total_attacked > 0 else 0
        asr_rate = 100 - sec_rate
        
        details = ", ".join([f"{k}: [Util: {'PASS' if v[0] is True else 'FAIL' if v[0] is False else 'N/A'}, Sec: {'SECURE' if v[1] is True else 'INJECTED' if v[1] is False else 'N/A'}]" for k, v in sorted(attacked_runs.items())])
        
        msg_util = f"- **Utility Under Attack**: {successful_utility}/{total_attacked} ({util_rate:.1f}%)"
        msg_sec = f"- **Security Rate (Defended)**: {successful_security}/{total_attacked} ({sec_rate:.1f}%)"
        msg_asr = f"- **Attack Success Rate (ASR)**: {total_attacked - successful_security}/{total_attacked} ({asr_rate:.1f}%)"
        
        print(msg_util)
        print(msg_sec)
        print(msg_asr)
        print(f"  - Details: {details}")
        
        md_out.append(msg_util)
        md_out.append(msg_sec)
        md_out.append(msg_asr)
        md_out.append(f"  - Details: {details}")
    else:
        print(f"- **Attacked Runs**: No runs found")
        
    # Injection Control
    if injection_control:
        control_details = ", ".join([f"{k}: {'PASS' if v is True else 'FAIL' if v is False else 'N/A'}" for k, v in sorted(injection_control.items())])
        msg_ctrl = f"- **Injection Task Capability (Control)**: {control_details}"
        print(msg_ctrl)
        md_out.append(msg_ctrl)
        
    # Append Notes with auto-detected metrics
    print("Notes:")
    md_out.append("Notes:")
    
    err_str = ", ".join(tool_errors) if tool_errors else "None"
    print(f"- Tool call errors: {err_str}")
    md_out.append(f"- Tool call errors: {err_str}")
    
    fail_str = ", ".join(sorted(list(set(failed_tasks)))) if failed_tasks else "None"
    print(f"- Failed tasks: {fail_str}")
    md_out.append(f"- Failed tasks: {fail_str}")
    
    weird_str = ", ".join(weird_behaviors) if weird_behaviors else "None"
    print(f"- Weird behavior: {weird_str}")
    md_out.append(f"- Weird behavior: {weird_str}")
    
    print()
    md_out.append("\n---\n")

# Overwrite baseline results file with complete auto-generated details
with open(baseline_file, "w", encoding="utf-8") as f:
    f.write("\n".join(md_out))

print(f"[INFO] Fully regenerated {baseline_file.as_posix()} with all metrics and notes resolved.")
