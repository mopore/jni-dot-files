# Config for Qwen 3 Coder Next on jnimacstudio

```bash
ollama pull qwen3.6:27b

cat > ./Modelfile <<'EOF'
FROM qwen3.6:27b
PARAMETER num_ctx 131072
PARAMETER temperature 0.7
PARAMETER top_p 0.8
PARAMETER top_k 20
PARAMETER min_p 0.0
PARAMETER repeat_penalty 1.0
# Apple Silicon offloads all layers by default; this is belt-and-suspenders.
PARAMETER num_gpu 99
EOF

# alias works here — the file lives at /root/.ollama inside the container
ollama create jni-qwen3.6:27b-128k -f ./Modelfile

# Sanity check
ollama list
```

Add with
```json
    "Ollama jnimacstudio": {
      "npm": "@ai-sdk/openai-compatible",
      "name": "Ollama (jnimacstudio)",
      "options": {
        "baseURL": "http://jnimacstudio:11434/v1"
      },
      "models": {
        // ...
        "jni-qwen3.6:27b-128k": {
          "name": "Qwen3.6 27B (128k)",
          "tools": true,
          "limit": { "context": 131072, "output": 8192 }
        }
      }
```


