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

# Set the VENV_BIN variable based on the operating system
if [[ "$OSTYPE" == "msys" ]]; then
    VENV_BIN="$SCRIPT_DIR/.pyenv/Scripts"
else
    VENV_BIN="$SCRIPT_DIR/.pyenv/bin"
fi

# Install dependencies
source "$VENV_BIN/activate"
uv pip install -e "${SCRIPT_DIR}"

$VENV_BIN/jupyter lab local_llm_tutorial.ipynb
