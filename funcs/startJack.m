function [ openPorts ] = startJack( jackConfig )
%STARTJACK Starts a new Jack instance with provided jackConfig
%	jackConfig defaults to workspace variable if not passed.
%	If not found, following defaults are used:
%   jackConfig.jackpath = '/usr/local/bin/';
%   jackConfig.fs = 44100;
%   jackConfig.framesize = 256;
%   jackConfig.verbose = true;

% If no input is given, first search main workspace for jackConfig variable
if nargin == 0
    try
        jackConfig = evalin( 'base', 'jackConfig' );
    catch
        % Defaults
        jackConfig.jackpath = '/usr/local/bin/';
        jackConfig.fs = 44100;
        jackConfig.framesize = 256;
        jackConfig.verbose = true;
    end
end

jackpath = jackConfig.jackpath;
fs = jackConfig.fs;
framesize = jackConfig.framesize;
verbose = jackConfig.verbose;
%serverName = jackConfig.serverName;

% Start jack in background
system([jackpath, 'jackd -d coreaudio -r ', num2str(fs) ,' -p ', num2str(framesize), '&']);

% Check successfull execution
pause(1)
[status, cmdout] = system([jackpath, 'jack_lsp']);

if status
    error(cmdout);
else
    if verbose
        disp('Jack server started successfully')
    end
    
    % Return list of open ports
    openPorts = strsplit(cmdout);
    
    % Remove possible empty cell at the end
    if isempty(openPorts{end})
        openPorts = openPorts(1:end-1);
    end
end

