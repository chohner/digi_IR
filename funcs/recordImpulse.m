function [ y, t ] = recordImpulse( impulse_length, recorder, jackConfig )
%RECORDIMPULSE Records an Impulse Response given a length (in s), a
%audiorecorder handle and jackConfig. Returns stereo data and time vector.
%   jackConfig defaults to workspace variable if not passed.
%	If not found, following defaults are used:
%   jackConfig.fs = 44100;
%   jackConfig.verbose = 'true';

if nargin == 2
    try
        jackConfig = evalin( 'base', 'jackConfig' );
    catch
        % Defaults
        jackConfig.fs = 44100;
        jackConfig.verbose = true;
    end
end

fs      = jackConfig.fs;
verbose = jackConfig.verbose;

if verbose
    disp('Recording impulse response...');
end

% Create impulse audio player
impulse = createImpulse(impulse_length, jackConfig);

% Start recording, play impulse, stop recording
record( recorder );
playblocking( impulse );
stop( recorder );

% Retrieve audio data
y = getaudiodata( recorder );

% normalize
%y = 0.7 * y ./ max( y(:) );

% Time vector
t = ( 0 : length(y) - 1 ) ./ fs;

end

