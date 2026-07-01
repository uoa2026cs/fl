[ -d fl ] || git clone https://github.com/uoa2026cs/fl.git
cd fl
source /venv/main/bin/activate
uv --no-progress pip install -r requirements.txt
