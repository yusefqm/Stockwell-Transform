# 📈 Stockwell Transform Tool for MATLAB
Generic MATLAB / GNU Octave utility for computing and visualising Stockwell spectrograms of multi‑channel time‑series data. The Stockwell Transform is useful in time-frequency analysis, offering high resolution in both domains. This tool is especially helpful for analyzing signals in applications like:

- Cyber-physical systems
- Biomedical signal processing (e.g., EEG, EMG)
- Network traffic analysis
- Mechanical vibrations and audio signals

## 🚀 Features
Stockwell transform — Uses any stran.m‑compatible implementation on the MATLAB path.
Multi‑channel — Row‑wise channels, any number of samples.
Pre‑processing — Linear detrend and optional z‑score normalisation.
Plotting modes — Separate windows, tiled subplots, or headless (“none”).
Event markers — Vertical lines to highlight trigger / fault times.
Sample truncation — Limit memory footprint with MaxSamples.
Octave support — Tested on Octave 8.4 (Linux) and MATLAB R2023b (Windows/macOS).

## 📂 Files
- `apply_stockwell.m`: Main script to apply the Stockwell Transform.
- `stran.m`: MATLAB implementation of the Stockwell Transform.

## Requirements
- MATLAB R2018a or newer or GNU Octave 6.0+
- `stran.m` function must be in the same folder.

## Author
Created by Yusef Mahmoud
