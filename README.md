# Brain Tumour MRI Classification

CIS143-6 Applications of AI — University of Bedfordshire  
Student: Najish Mahmud (2514376)

## Notebooks

Run in this order — each notebook depends on models saved by the previous one:

| Order | File | Description |
|-------|------|-------------|
| 1 | `part1_baseline.ipynb` | Environment setup, dataset download, baseline CNN |
| 2 | `part2a_data_segmentation.ipynb` | Otsu brain extraction pipeline |
| 3 | `part2b_ann_vs_cnn.ipynb` | ANN baseline, CNN Experiments A & B |
| 4 | `part2c_transfer_learning.ipynb` | EfficientNetB0 and ConvNeXtSmall experiments |
| 5 | `part2d_final_evaluation.ipynb` | Full comparison, GradCAM, Wilcoxon, cost analysis |

---

## Google Colab (recommended)

**Requirements:** Google account with Google Drive

**1. Upload notebooks**

Upload the `runed/` folder to your Google Drive, or open each notebook via File → Open notebook → Google Drive.

**2. Enable GPU**

For each notebook: Runtime → Change runtime type → Hardware accelerator → **T4 GPU** → Save.

**3. Kaggle credentials**

The notebooks download the dataset automatically via `kagglehub`. Set your credentials before running:

```python
import os
os.environ["KAGGLE_USERNAME"] = "your_username"
os.environ["KAGGLE_KEY"] = "your_api_key"
```

Get your API key from kaggle.com → Settings → API → Create New Token.

**4. Google Drive**

Mount Drive when prompted in the first cell. Models are saved to `MyDrive/brain_tumour_mri/` and reloaded by later notebooks — do not skip this step.

**5. Run all cells**

Runtime → Run all. Each notebook takes 10–30 minutes depending on GPU availability.

> Part 2D must be run last — it loads all saved models from Drive and will fail if earlier notebooks have not completed.

---

## Local — AMD GPU (Docker + ROCm)

**Requirements:** Linux, Docker, Docker Compose, AMD GPU with ROCm support (tested on RX 9060 XT / gfx1200)

**1. Kaggle credentials**

```bash
mkdir -p ~/.config/kaggle
echo '{"username":"your_username","key":"your_api_key"}' > ~/.config/kaggle/kaggle.json
chmod 600 ~/.config/kaggle/kaggle.json
```

**2. Start JupyterLab**

```bash
docker compose up
```

This will:
- Pull `rocm/tensorflow:rocm7.2.3-py3.12-tf2.20-dev`
- Install all dependencies automatically
- Download and symlink the dataset to `/content/brain_tumour_data`
- Start JupyterLab at `http://localhost:8888` (no password required)

**3. Open notebooks**

Go to `http://localhost:8888`. Notebooks are in the `runed/` directory. Run them in order.

Models save to `./models/` instead of Google Drive.

**4. Stop**

```bash
docker compose down
```

---

## Local — NVIDIA GPU or CPU (pip)

**Requirements:** Python 3.10+, pip. NVIDIA GPU with CUDA 12 is optional.

**1. Install dependencies**

```bash
# NVIDIA GPU
pip install "tensorflow[and-cuda]" kagglehub scikit-learn \
    opencv-python-headless scipy seaborn jupyterlab ipywidgets

# CPU only
pip install tensorflow kagglehub scikit-learn \
    opencv-python-headless scipy seaborn jupyterlab ipywidgets
```

**2. Kaggle credentials**

```bash
mkdir -p ~/.config/kaggle
echo '{"username":"your_username","key":"your_api_key"}' > ~/.config/kaggle/kaggle.json
chmod 600 ~/.config/kaggle/kaggle.json
```

**3. Start JupyterLab**

```bash
jupyter lab --notebook-dir=runed
```

Open `http://localhost:8888` and run notebooks in order.

> CPU-only training is significantly slower. EfficientNetB0 and ConvNeXtSmall experiments may take several hours.

---

## Dependencies

| Package | Purpose |
|---------|---------|
| TensorFlow 2.20 | Model building and training |
| kagglehub | Dataset download |
| scikit-learn | Metrics, splits, class weights |
| OpenCV | Otsu segmentation |
| scipy | Wilcoxon significance test |
| pandas / numpy | Data handling |
| matplotlib / seaborn | Visualisation |
