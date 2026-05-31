# Config for Qwen 3 Coder Next on jnimacstudio

```bash
ollama pull qwen3-coder-next:q4_K_M

cat > ./Modelfile <<'EOF'
# On the MAC. Pull first:  ollama pull qwen3-coder-next:q4_K_M
# Build:  ollama create jni-qwen3-coder-next -f ~/.ollama/Modelfile
FROM qwen3-coder-next:q4_K_M

# 128 GB unified memory + linear-attention architecture = context is cheap.
# 128K is realistic here; the model goes to 256K natively if you want it.
PARAMETER num_ctx 131072

# Qwen coder sampling (same family as your 30B).
PARAMETER temperature 0.7
PARAMETER top_p 0.8
PARAMETER top_k 20
PARAMETER repeat_penalty 1.05

# Keep everything resident — you have the memory, avoid reload churn.
PARAMETER num_gpu 99
EOF

# alias works here — the file lives at /root/.ollama inside the container
ollama create jni-qwen3-coder-next -f ./Modelfile

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
        "jni-qwen3-coder-next": {
          "name": "jni-qwen3-coder-next",
          "tools": true
        }
      }
```


