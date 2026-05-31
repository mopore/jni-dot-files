# Config for Qwen 3 Coder on MacBook Pro

```bash
ollama pull qwen3-coder:30b

cat > ./Modelfile <<'EOF'
# Build:  ollama create jni-qwen3-coder -f ~/.ollama/Modelfile
FROM qwen3-coder:30b

# The payoff vs the 4090: ~40 GB free after the 19 GB model, so context
# can be big. 64K is the comfortable daily default on a laptop you're
# also working on; push to 131072 if you close other memory hogs.
PARAMETER num_ctx 65536

# Qwen coder sampling (identical to your 4090 config — same model, keep it consistent).
PARAMETER temperature 0.7
PARAMETER top_p 0.8
PARAMETER top_k 20
PARAMETER repeat_penalty 1.05

# Keep it all resident.
PARAMETER num_gpu 99
EOF

# alias works here — the file lives at /root/.ollama inside the container
ollama create jni-qwen3-coder -f ./Modelfile

# Sanity check
ollama list
```

Add with
```json
    "Ollama jnimacstudio": {
      "npm": "@ai-sdk/openai-compatible",
      "name": "Ollama (localhost)",
      "options": {
        "baseURL": "http://localhost:11434/v1"
      },
      "models": {
        // ...
        "jni-qwen3-coder": {
          "name": "jni-qwen3-coder",
          "tools": true
        }
      }
```


