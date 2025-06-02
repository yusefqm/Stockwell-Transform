%==========================================================================
% stockwellSpectrogram.m
% -------------------------------------------------------------------------
% Generic helper for computing and visualising Stockwell spectrograms.
% Works with MATLAB (R2018a+) or GNU Octave.  No file‑format assumptions are
% made – simply load/prepare your multichannel signal matrix and call the
% function.  Each row is interpreted as **one channel**, each column as a
% **time sample**.
%
% REQUIREMENTS
%   •  A Stockwell transform implementation on the path.  The toolbox was
%      originally written against STRAN.M from the MATLAB File‑Exchange:
%      https://www.mathworks.com/matlabcentral/fileexchange/38203-stockwell-transform
%   •  Detrend / z‑score rely on core MATLAB, but Octave equivalents exist.
%
% USAGE EXAMPLE
%   fs   = 20e3;                          % 20 kHz sampling rate
%   t    = 0:1/fs:0.5;                    % half‑second record
%   x    = sin(2*pi*400*t) + 0.1*randn(size(t));
%   y    = chirp(t,100,0.5,2e3);
%   data = [x ; y];                       % 2 × Nsamp matrix
%   events = [0.12 0.25 0.33];            % vertical markers (optional)
%
%   stockwellSpectrogram(data,fs, ...
%       'ChannelNames',{'tone','chirp'}, ...
%       'PlotMode','subplots', ...
%       'EventTimes',events);
%
% FUNCTION SIGNATURE
%   ST = stockwellSpectrogram(data, fs, Name,Value, ...)
%
% INPUTS
%   data  – double [Nch×Nsamp]  multichannel signal (rows = channels)
%   fs    – scalar               sampling frequency in Hz
%
% NAME‑VALUE PAIRS  (all optional)
%   'ChannelNames' – string/cellstr  → labels for each channel (default Ch1…)
%   'PlotMode'     – 'separate' | 'subplots' | 'none'   (default 'separate')
%   'EventTimes'   – vector of seconds; vertical lines on the plots (default [])
%   'MaxSamples'   – positive integer; truncate to this many samples (default Inf)
%   'Normalize'    – logical; z‑score each channel  (default true)
%
% OUTPUT
%   ST – 1×Nch cell array.  Each cell is complex Stockwell spectrum
%        [Nfreq × Nsamp] for the corresponding channel.
%
% -------------------------------------------------------------------------
% Author:  Yusef Mahmoud
%==========================================================================
function ST = stockwellSpectrogram(data, fs, varargin)

% ---- input checks -------------------------------------------------------
if nargin < 2,  error('Two inputs required: DATA matrix and sampling rate FS.'); end
validateattributes(data, {'numeric'}, {'2d','finite'}, mfilename,'data',1);
validateattributes(fs,   {'numeric'}, {'scalar','positive'}, mfilename,'fs',2);

% convert to double precision & ensure channels are rows ------------------
if size(data,1) > size(data,2) && size(data,2) > 1
    % Heuristic: if channels likely in columns, transpose for convenience
    warning('%s: assuming channels are in columns – transposing data.',mfilename);
    data = data.';   % now rows = channels
end

% ---- parse name‑value pairs --------------------------------------------
P = inputParser;
P.KeepUnmatched = false;
addParameter(P,'ChannelNames',[]);
addParameter(P,'PlotMode','separate',@(s) any(strcmpi(s,{'separate','subplots','none'})));
addParameter(P,'EventTimes',[],@(v) isnumeric(v) && isvector(v));
addParameter(P,'MaxSamples',Inf,@(v) isnumeric(v) && isscalar(v) && v>0);
addParameter(P,'Normalize',true,@islogical);
parse(P, varargin{:});
opt = P.Results;

[Nc, Ns] = size(data);

% ---- sample truncation --------------------------------------------------
if opt.MaxSamples < Ns
    data = data(:,1:opt.MaxSamples);
    Ns   = opt.MaxSamples;
end

% ---- detrend & (optionally) z‑score ------------------------------------
% Detrend works column‑wise – operate on the transposed matrix for speed.
% MATLAB ''detrend'' can handle large matrices efficiently.

data = detrend(data.', 'linear').';   % back to [Nch×Nsamp]
if opt.Normalize
    data = (data - mean(data,2))./std(data,0,2);
end

% ---- main Stockwell transform ------------------------------------------
ST = cell(1,Nc);
for k = 1:Nc
    ST{k} = stran(data(k,:));   % each cell: [Nfreq × Nsamp]
end

% ---- plotting (optional) ------------------------------------------------
if ~strcmpi(opt.PlotMode,'none')
    % basic axis helpers
    t  = (0:Ns-1) ./ fs;
    f_ = @(M) (0:M-1) .* fs / Ns;

    % default channel names ------------------------------------------------
    if isempty(opt.ChannelNames)
        opt.ChannelNames = "Ch" + string(1:Nc);
    else
        opt.ChannelNames = string(opt.ChannelNames);
        if numel(opt.ChannelNames) < Nc
            opt.ChannelNames(end+1:Nc) = "Ch" + string(numel(opt.ChannelNames)+1:Nc);
        end
    end

    switch lower(opt.PlotMode)
        case 'separate'
            for k = 1:Nc
                figure('Color','w');
                imagesc(t, f_(size(ST{k},1)), abs(ST{k}));
                axis xy tight;
                colormap turbo;  colorbar;
                xlabel('Time [s]');  ylabel('Frequency [Hz]');
                title("Stockwell – " + opt.ChannelNames(k));

                for et = reshape(opt.EventTimes,1,[])
                    xline(et,'w-','LineWidth',1.1);
                end
            end

        case 'subplots'
            nRow = ceil(sqrt(Nc));  nCol = ceil(Nc/nRow);
            figure('Color','w','Units','normalized','Position',[.05 .05 .9 .85]);
            for k = 1:Nc
                subplot(nRow,nCol,k);
                imagesc(t, f_(size(ST{k},1)), abs(ST{k}));
                axis xy tight;
                colormap turbo;
                title(opt.ChannelNames(k));
                xlabel('t [s]');  ylabel('f [Hz]');

                for et = reshape(opt.EventTimes,1,[])
                    xline(et,'w-','LineWidth',1);
                end
            end
            sgtitle('Stockwell spectrograms');
    end
end

end  %‑‑‑ stockwellSpectrogram ------------------------------------------------

% End of file
