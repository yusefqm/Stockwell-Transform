# 📈 Stockwell Transform Tool for MATLAB
Generic MATLAB / GNU Octave utility for computing and visualising Stockwell spectrograms of multi‑channel time‑series data. The Stockwell Transform is useful in time-frequency analysis, offering high resolution in both domains. This tool is especially helpful for analyzing signals in applications like:

- Cyber-physical systems
- Biomedical signal processing (e.g., EEG, EMG)
- Network traffic analysis
- Mechanical vibrations and audio signals

## 🚀 Features
- Flexible input — Works on any [channels × samples] matrix.
- Multichannel — Handles any number of signal channels.
- Preprocessing — Detrend + optional normalisation.
- Event markers — Add vertical lines for key timestamps.
- Octave compatible — Tested on Octave and MATLAB.

## 📂 Files
- `apply_stockwell.m`: Main script to apply the Stockwell Transform.
- `stran.m`: MATLAB implementation of the Stockwell Transform.

## Requirements
- MATLAB R2018a or newer or GNU Octave 6.0+
- `stran.m` function must be in the same folder.

## Author
Created by Yusef Mahmoud
