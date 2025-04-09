#!/bin/bash -e
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

# Check for pip3
if [ ! "$(command -v pip3)" ]; then
    echo "Error: pip3 is not installed"
    exit 1
fi

# Check for uv
if [ ! "$(command -v uv)" ]; then
    pip3 install uv
fi

# Check if .pyenv directory already exists
if [ ! -d "${SCRIPT_DIR}/.pyenv" ]; then
    uv venv -p ">=3.12" "${SCRIPT_DIR}/.pyenv"    
fi

# Install dependencies
source "${SCRIPT_DIR}/.pyenv/bin/activate"   
uv pip install -e "${SCRIPT_DIR}"

$VIRTUAL_ENV/bin/jupyter lab local_llm_demo.ipynb
