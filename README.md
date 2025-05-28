# 📈 Stockwell Transform Tool for MATLAB
This repository provides a general-purpose MATLAB script for applying the **Stockwell Transform (S-Transform)** to any 1D signal. The Stockwell Transform is useful in time-frequency analysis, offering high resolution in both domains. This tool is especially helpful for analyzing signals in applications like:

- Cyber-physical systems
- Biomedical signal processing (e.g., EEG, EMG)
- Network traffic analysis (e.g., IEC 61850 GOOSE messages)
- Mechanical vibrations and audio signals

## 🚀 Features
- Fast computation of the Stockwell Transform
- Automatically handles normalization and preprocessing
- Works with any `.csv` or `.mat` signal file
- Outputs a clear, high-resolution spectrogram
- Easily customizable and extendable

## 📂 Files
- `apply_stockwell.m`: Main script to apply the Stockwell Transform.
- `stran.m`: MATLAB implementation of the Stockwell Transform.
- `instructions.txt`: Step-by-step guide for usage.

## Requirements
- MATLAB R2018 or later.
- `stran.m` function must be in the same folder.

## Author
Created by Yusef Mahmoud
