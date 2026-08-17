from pathlib import Path
import json

runs_dir = Path("runs")
for path in runs_dir.rglob("*.json"):
    print("\nFILE:", path)
    try:
        data = json.loads(path.read_text(encoding="utf-8"))
        if isinstance(data, dict):
            print("Top-level keys:", list(data.keys())[:20])
        else:
            print("JSON type:", type(data))
    except Exception as e:
        print("Could not parse:", e)
