#!/usr/bin/env bash
set -e

pip install -q --upgrade \
    protobuf kagglehub scikit-learn seaborn \
    "opencv-python-headless" scipy \
    jupyterlab ipywidgets

# Symlink kagglehub-cached dataset to /content/brain_tumour_data
python3 - <<'EOF'
import kagglehub, os
p = kagglehub.dataset_download("masoudnickparvar/brain-tumor-mri-dataset")
dst = "/content/brain_tumour_data"
if not os.path.exists(dst):
    os.symlink(p, dst)
    print(f"Linked dataset: {p} -> {dst}")
else:
    print(f"Dataset already at {dst}")
EOF

mkdir -p /content/drive/MyDrive/brain_tumour_mri

exec jupyter lab \
    --ip=0.0.0.0 \
    --port=8888 \
    --no-browser \
    --allow-root \
    --notebook-dir=/workspace/runed \
    --ServerApp.token='' \
    --ServerApp.password='' \
    --ServerApp.disable_check_xsrf=True
