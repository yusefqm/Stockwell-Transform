% apply_stockwell.m
% General-purpose script to apply Stockwell Transform to any 1D signal

clear; clc;

%% Step 1: Load Your Data
% Load from CSV or MAT file
filename = 'your_signal_file.csv';  % Replace with your filename
T = readtable(filename);            % Assumes the file has a column named 'Signal'

%% Step 2: Extract Signal Column
signal = T.Signal;   % Change 'Signal' to match your column name
time = T.Time;       % Optional: change or comment out if not available

%% Step 3: Remove NaNs and Normalize
validIdx = ~isnan(signal);
signal = signal(validIdx);
if exist('time', 'var')
    time = time(validIdx);
end
signal = double(signal);
signal = (signal - mean(signal)) / std(signal);
signal = signal(:)';  % Ensure row vector

%% Step 4: Optionally Trim to First N Samples
N = min(10000, length(signal));
signal = signal(1:N);
if exist('time', 'var')
    time = time(1:N);
else
    time = 1:N;  % Default x-axis if time is not provided
end

%% Step 5: Apply Stockwell Transform
ST = stran(signal);  % Ensure stran.m is available in folder

%% Step 6: Plot the Spectrogram
figure;
imagesc(time, 1:size(ST,1), abs(ST));
xlabel('Time (samples)');
ylabel('Frequency Index');
title('Stockwell Transform of Input Signal');
colorbar;
axis xy;