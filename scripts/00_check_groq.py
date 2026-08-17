import os
from dotenv import load_dotenv
from openai import OpenAI

load_dotenv()

client = OpenAI(
    api_key=os.environ["OPENAI_COMPATIBLE_API_KEY"],
    base_url=os.environ["OPENAI_COMPATIBLE_BASE_URL"],
)

model = os.environ.get("GROQ_MODEL", "llama-3.3-70b-versatile")

response = client.chat.completions.create(
    model=model,
    messages=[
        {"role": "system", "content": "You are a concise test assistant."},
        {"role": "user", "content": "Reply with exactly: Groq connection OK"},
    ],
    temperature=0,
)

print(response.choices[0].message.content)
