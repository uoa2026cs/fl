# fl

```bash
python -m venv $HOME/.venv
source $HOME/.venv/bin/activate
pip install -r requirements.txt

```

```bash
vastai search offers "cuda_vers>=13"
vastai create instance 12345678 --image vastai/pytorch:2.12.1-cu130-cuda-13.2-mini-py314-2026-08-26
source <(curl -s https://raw.githubusercontent.com/uoa2026cs/fl/refs/heads/main/workspace.sh)
```
