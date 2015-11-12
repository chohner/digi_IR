function [ IDi, IDo, recorder ] = setupJack( jackConfig )
%SETUPJACK Connects MATLAB to another Jack port and returns device handles
%	jackConfig defaults to workspace variable if not passed.

%% Setup
% If no input is given, first search main workspace for jackConfig variable
if nargin == 0
    try
        jackConfig = evalin( 'base', 'jackConfig' );
    catch
        error('No jackConfig found.')
    end
end

fs = jackConfig.fs;
nBits = jackConfig.nBits;
nChannels = jackConfig.nChannels;
jackpath = jackConfig.jackpath;
App = jackConfig.App;
verbose = jackConfig.verbose;

%% find jackrouter device
if verbose
    disp('Loading Jack audio device...')
end
%deviceInfo = audiodevinfo;

try
    IDi = audiodevinfo(1,'JackRouter');
    IDo = audiodevinfo(0,'JackRouter');
catch
    error('No JackRouter device found');
end

% check if fs is supported
if audiodevinfo(1,IDi,fs,nBits,nChannels) && audiodevinfo(0,IDo,fs,nBits,nChannels)
    if verbose
        disp('Jack device found.')
    end
else
    error('Configuration mismatch, check fs, nBits and nChannels against Jack settings.')
end

%% connect jack
% This is pretty ugly but should work for now:
% Quickly play / record something to make MATLABs port appear in Jack
% Luckily Jack reconnects ports on later plays / recordings

if verbose
    disp('Connecting Jack ports...')
end

T=.1;

% Init recorder
recorder = audiorecorder(fs, nBits, nChannels, IDi);

% Init temporary audioplayer playing zeros
tmpPly = audioplayer( zeros( T*fs , 2 ), fs, nBits, IDo );

% Start playing / recording
record(recorder)
play(tmpPly)

% Connect Matlab to jackConfig.App
system([jackpath, 'jack_connect MATLAB:out1 ', App, ':in1']);
system([jackpath, 'jack_connect MATLAB:out2 ', App, ':in2']);
system([jackpath, 'jack_connect ', App, ':out1 MATLAB:in1']);
system([jackpath, 'jack_connect ', App, ':out2 MATLAB:in2']);

% Stop playing / recording
stop(tmpPly)
stop(recorder)

% TODO handle errors

if verbose
    disp('Jack setup complete.')
end

end

