%% Digital IR measurements from Matlab 
% Use Jack to send an impulse to any digital audio effect while recording
% the response. Matlab ports only show up in JACK up while using the audio
% stream, so port connections have to be made while playing / recording.
% Luckily Jack re-initializes ports with their old connections for quick
% measurements after a initial setup.
%
% Only tested on Mac OSX 10.10.5 with Jack 1.9.10 and Ableton Live
%
% Christoph Hohnerlein, 11 Nov 2015

clear;clc;
addpath('funcs')

%% Variables
fs = 44100;
nBits = 16;
nChannels = 2;

jackConfig.jackpath = '/usr/local/bin/';
jackConfig.App = 'Live';
jackConfig.fs = fs;
jackConfig.nBits = nBits;
jackConfig.nChannels = nChannels;
jackConfig.framesize = 256;
jackConfig.verbose = false;
%jackConfig.serverName = 'matlabJackServer';

%% Setup
% Start Jack
openPorts  = startJack( jackConfig );

disp('Connect target app to Jack now and press a key...');
pause;

% Connect ports
[jackConfig.IDi, jackConfig.IDo, rec] = setupJack( jackConfig );

%% Play impulse and record response
[ y, t ] = recordImpulse( 1, rec, jackConfig);

% Calculate spectogram of left channel
[ s_dB, fSpec, tSpec ] = getSpectrogram( y( :, 1 ) , 512, 128, 1024, fs );

% Calculate FFT of both channels
[ y_dB, f_fft ] = easyFFT(y, fs);

% Plot
figure(1)
clf

% Plot IR in time domain
subplot(3,1,1)
irHandle = plotIR( y, t );

% Plot spectogram
subplot(3,1,2)
specHandle = plotSpectrogram( s_dB, tSpec, fSpec );

% Plot FFT
subplot(3,1,3)
fftHandle = plotFFT( y_dB, f_fft );
