function [  ] = stopJack( jackConfig )
%STOPJACK Primitive wrapper to kill all instances of Jack
%	jackConfig defaults to workspace variable if not passed.
%	If not found, following defaults are used:
%   jackConfig.verbose = true;


% If no input is given, first search main workspace for jackConfig variable
if nargin == 0
    try
        verbose = evalin( 'base', 'jackConfig.verbose' );
    catch
        % Verbose defaults to true
        verbose = true;
    end
else
    verbose = jackConfig.verbose;
end

% status is 0 if jackd instances have been found and killed, 1 otherwise
[status, ~] = system('killall jackd ');

if verbose
    if status
        disp('No Jack instances found.')
    else
        disp('Jack shut down.')
    end
end

end

